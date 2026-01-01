package modules

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"strings"
)

type lineNotify struct {
	client  *http.Client
	BaseURI string
}

type Notify interface {
	BuildCostNotifyMessage(jwt, toID, costSource string, costs map[string]map[string]float64) (string, error)
}

type lineNotifyReqBody struct {
	To       string    `json:"to"`
	Messages []message `json:"messages"`
}

type message struct {
	Type string `json:"type"`
	Text string `json:"text"`
}

type fetchAccessTokenResp struct {
	AccessToken string `json:"access_token"`
}

func NewLineNotify(
	client *http.Client,
	baseURI string,
) Notify {
	return &lineNotify{
		client:  client,
		BaseURI: baseURI,
	}
}

func (hlc *lineNotify) BuildCostNotifyMessage(jwt, toID, costSource string, costs map[string]map[string]float64) (string, error) {

	var processedDate string

	dailyCostKeysAsc := GetDailyCostKeysAsc(costs)

	accessToken, err := hlc.fetchAccessToken(jwt)

	if err != nil {
		processedDate = dailyCostKeysAsc[0]
		return processedDate, err
	}

	var body lineNotifyReqBody
	body.To = toID

	for _, date := range dailyCostKeysAsc {
		var messageText strings.Builder
		body.Messages = nil
		messageText.WriteString(fmt.Sprintf("%s（%s）のコスト情報です。\n", costSource, date))
		body.Messages = append(body.Messages, message{
			Type: "text",
			Text: func() string {
				for service, cost := range costs[date] {
					messageText.WriteString(fmt.Sprintf("- %s: %.2f USD\n", service, cost))
				}
				return messageText.String()
			}(),
		})

		jsonBody, err := json.Marshal(body)

		if err != nil {
			return date, err
		}

		req, err := http.NewRequest(http.MethodPost, hlc.BaseURI+"/v2/bot/message/push", bytes.NewBuffer(jsonBody))

		if err != nil {
			return date, err
		}

		req.Header.Set("Content-Type", "application/json")
		req.Header.Set("Authorization", "Bearer "+accessToken)

		resp, err := hlc.client.Do(req)

		if err != nil {
			return date, err
		}

		err = func() error {
			defer resp.Body.Close()
			if resp.StatusCode != http.StatusOK {
				return fmt.Errorf("failed to send message, status code: %d", resp.StatusCode)
			}
			processedDate = date
			return nil
		}()

		if err != nil {
			return date, err
		}
	}

	return processedDate, nil
}

func (hlc *lineNotify) fetchAccessToken(jwt string) (string, error) {

	data := map[string]string{
		"grant_type":            "client_credentials",
		"client_assertion_type": "urn:ietf:params:oauth:client-assertion-type:jwt-bearer",
		"client_assertion":      jwt,
	}

	formData := url.Values{}

	for k, v := range data {
		formData.Set(k, v)
	}

	body := bytes.NewBuffer([]byte(formData.Encode()))

	req, err := http.NewRequest(http.MethodPost, hlc.BaseURI+"/oauth2/v2.1/token", body)

	if err != nil {
		return "", err
	}

	req.Header.Set("Content-Type", "application/x-www-form-urlencoded")

	resp, err := hlc.client.Do(req)

	if err != nil {
		return "", err
	}

	defer resp.Body.Close()

	bodyBytes, err := io.ReadAll(resp.Body)

	if err != nil {
		return "", err
	}

	var respData fetchAccessTokenResp

	err = json.Unmarshal(bodyBytes, &respData)

	if err != nil {
		return "", err
	}

	return respData.AccessToken, nil
}
