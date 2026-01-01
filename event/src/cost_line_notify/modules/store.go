package modules

import (
	"context"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/ssm"
)

type store struct {
	client *ssm.Client
}

type Store interface {
	GetParameter(ctx context.Context, name string) (string, error)
}

func NewStore(client *ssm.Client) Store {
	return &store{
		client: client,
	}
}

func (s *store) GetParameter(ctx context.Context, name string) (string, error) {
	res, err := s.client.GetParameter(
		ctx,
		&ssm.GetParameterInput{
			Name:           &name,
			WithDecryption: aws.Bool(true),
		},
	)

	if err != nil {
		return "", err
	}

	return *res.Parameter.Value, nil
}
