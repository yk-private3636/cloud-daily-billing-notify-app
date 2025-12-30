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
	"github.com/aws/aws-sdk-go-v2/service/costexplorer"
	"github.com/yk-private3636/cloud-daily-billing-notify-app/event/src/aws_cost_collector/modules"
)

var (
	collector modules.Collector
)

type Input struct {
	From string `json:"from"`
	To   string `json:"to"`
}

type Output struct {
	Costs map[string]map[string]float64 `json:"costs"`
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

	collector = modules.NewCollector(
		costexplorer.NewFromConfig(cfg),
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

func handler(ctx context.Context, event json.RawMessage) (Output, error) {
	var input Input

	if err := json.Unmarshal(event, &input); err != nil {
		return Output{}, err
	}

	isValid := modules.IsDateDiffWithinDays(input.From, input.To, 31)

	if !isValid {
		return Output{}, fmt.Errorf("the difference between from and to must be within 31 days")
	}

	if input.From == input.To {
		newTo, err := modules.AddDateString(input.To, 1)
		if err != nil {
			return Output{}, err
		}
		input.To = newTo
	}

	costs, err := collector.CollectDailyServiceCosts(ctx, input.From, input.To)

	if err != nil {
		return Output{}, err
	}

	return Output{
		Costs: costs,
	}, nil
}
