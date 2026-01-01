package modules

import (
	"context"

	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
)

type database struct {
	clinet    *dynamodb.Client
	tabelName string
}

type Database interface {
	PutItem(ctx context.Context, costSource, nextProcessingDate string) error
}

func NewDatabase(client *dynamodb.Client, tableName string) Database {
	return &database{
		clinet:    client,
		tabelName: tableName,
	}
}

func (d *database) PutItem(ctx context.Context, costSource, nextProcessingDate string) error {
	_, err := d.clinet.PutItem(ctx, &dynamodb.PutItemInput{
		TableName: &d.tabelName,
		Item: map[string]types.AttributeValue{
			"cost_source":          &types.AttributeValueMemberS{Value: costSource},
			"next_processing_date": &types.AttributeValueMemberS{Value: nextProcessingDate},
		},
	})

	return err
}
