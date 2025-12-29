package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"os"
	"strings"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/yk-private3636/cloud-daily-billing-notify-app/event/src/get_last_processed_date/modules"
)

var (
	database modules.Database
)

type Input struct {
	CostSource string `json:"cost_source"`
}

type Output struct {
	LastProcessedDate string `json:"last_processed_date"`
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

	database = modules.NewDatabase(
		dynamodb.NewFromConfig(cfg),
		os.Getenv("TABLE_NAME"),
	)
}

func main() {
	if strings.ToLower(os.Getenv("APP_ENV")) == "prod" {
		lambda.Start(handler)
	} else {
		event := modules.FileContent("./event.json")
		fmt.Println(handler(context.Background(), event))
	}
}

func handler(ctx context.Context, event json.RawMessage) (Output, error) {
	var input Input

	err := json.Unmarshal(event, &input)

	if err != nil {
		return Output{}, err
	}

	lastProcessedDate, err := database.GetLastProcessedDate(ctx, "cost_source", input.CostSource)

	if err != nil {
		return Output{}, err
	}

	return Output{
		LastProcessedDate: lastProcessedDate,
	}, nil
}
