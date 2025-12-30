package modules

import (
	"context"
	"strconv"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/costexplorer"
	"github.com/aws/aws-sdk-go-v2/service/costexplorer/types"
)

type collector struct {
	client *costexplorer.Client
}

type Collector interface {
	CollectDailyServiceCosts(ctx context.Context, from, to string) (map[string]map[string]float64, error)
}

func NewCollector(client *costexplorer.Client) Collector {
	return &collector{
		client: client,
	}
}

func (c *collector) CollectDailyServiceCosts(ctx context.Context, from, to string) (map[string]map[string]float64, error) {
	res, err := c.client.GetCostAndUsage(ctx, &costexplorer.GetCostAndUsageInput{
		Granularity: "DAILY",
		TimePeriod: &types.DateInterval{
			Start: aws.String(from),
			End:   aws.String(to),
		},
		Metrics: []string{"UnblendedCost"},
		GroupBy: []types.GroupDefinition{
			types.GroupDefinition{
				Key:  aws.String("SERVICE"),
				Type: types.GroupDefinitionTypeDimension,
			},
		},
	})

	if err != nil {
		return nil, err
	}

	// 小規模なのでネストしたmapで返す
	var costs map[string]map[string]float64 = make(map[string]map[string]float64)

	for _, result := range res.ResultsByTime {
		date := *result.TimePeriod.Start
		costs[date] = make(map[string]float64)

		for _, group := range result.Groups {
			service := group.Keys[0]
			amount := *group.Metrics["UnblendedCost"].Amount

			amountFloat, _ := strconv.ParseFloat(amount, 64)
			costs[date][service] = amountFloat
		}
	}

	return costs, nil
}
