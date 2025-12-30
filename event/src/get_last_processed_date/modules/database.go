package modules

import (
	"context"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
)

type database struct {
	client    *dynamodb.Client
	tableName string
}

type Database interface {
	GetLastProcessedDate(ctx context.Context, partitionKey, partitionValue string) (string, error)
}

func NewDatabase(
	client *dynamodb.Client,
	tableName string,
) Database {
	return &database{
		client:    client,
		tableName: tableName,
	}
}

func (db *database) GetLastProcessedDate(ctx context.Context, partitionKey, partitionValue string) (string, error) {
	res, err := db.client.Query(ctx, &dynamodb.QueryInput{
		TableName: aws.String(db.tableName),
		ExpressionAttributeNames: map[string]string{
			"#pk": partitionKey,
		},
		ExpressionAttributeValues: map[string]types.AttributeValue{
			":pv": &types.AttributeValueMemberS{Value: partitionValue},
		},
		KeyConditionExpression: aws.String("#pk = :pv"),
		Limit:                  aws.Int32(1),
	})

	if err != nil {
		return "", err
	}

	for _, item := range res.Items {
		if v, ok := item["processed_date"]; ok {
			return v.(*types.AttributeValueMemberS).Value, nil
		}
	}

	return "", nil
}
