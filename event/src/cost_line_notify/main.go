package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"
	"time"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/ssm"
	"github.com/yk-private3636/cloud-daily-billing-notify-app/event/src/cost_line_notify/modules"
)

var (
	store      modules.Store
	rsaBuilder modules.Builder
	notify     modules.Notify
)

type Input struct {
	Platform string                        `json:"platform"`
	Costs    map[string]map[string]float64 `json:"costs"`
}

func init() {
	var opts []func(*config.LoadOptions) error

	if strings.ToLower(os.Getenv("APP_ENV")) != "prod" {
		opts = append(opts, config.WithSharedConfigProfile("local"))
	}

	cfg, err := config.LoadDefaultConfig(
		context.TODO(),
		opts...,
	)

	if err != nil {
		log.Fatal(err.Error())
	}

	store = modules.NewStore(
		ssm.NewFromConfig(cfg),
	)

	rsaBuilder = modules.NewRSAAlgorithmBuilder(
		os.Getenv("LINE_KID"),
		os.Getenv("LINE_CHANNEL_ID"),
		os.Getenv("LINE_CHANNEL_ID"),
		os.Getenv("LINE_AUDIENCE"),
		time.Now().Add(15*time.Minute),
		map[string]interface{}{
			"token_exp": 1500,
		},
	)

	notify = modules.NewLineNotify(
		&http.Client{
			Timeout:   30 * time.Second,
			Transport: http.DefaultTransport,
		},
		os.Getenv("LINE_API_BASE_URI"),
	)
}

func main() {
	if strings.ToLower(os.Getenv("APP_ENV")) == "prod" {
		lambda.Start(handler)
	} else {
		event, _ := os.ReadFile("./event.json")
		fmt.Println(handler(context.Background(), event))
	}
}

func handler(ctx context.Context, event json.RawMessage) error {

	var input Input

	err := json.Unmarshal(event, &input)

	if err != nil {
		return err
	}

	if len(input.Costs) == 0 {
		return nil
	}

	// TODO: 排他制御開始(DynamoDB)

	toUserID, err := store.GetParameter(ctx, os.Getenv("SSM_LINE_USER_ID_NAME"))

	if err != nil {
		return err
	}

	privJwk, err := store.GetParameter(ctx, os.Getenv("SSM_LINE_PRIV_JWK_NAME"))

	if err != nil {
		return err
	}

	signed, err := rsaBuilder.RSAAlgorithmFromJWK(privJwk)

	if err != nil {
		return err
	}

	_, err = notify.BuildCostNotifyMessage(
		signed,
		toUserID,
		input.Platform,
		input.Costs,
	)

	if err != nil {
		return err
	}

	// TODO: 排他制御終了(DynamoDB)

	return nil
}
