package modules

import (
	"time"

	"github.com/lestrrat-go/jwx/v3/jwa"
	"github.com/lestrrat-go/jwx/v3/jwk"
	"github.com/lestrrat-go/jwx/v3/jws"
	"github.com/lestrrat-go/jwx/v3/jwt"
)

type rsaalgorithmLineBuilder struct {
	kid        string
	Issuer     string
	Subject    string
	Audience   string
	Expiration time.Time
	Claims     map[string]interface{}
}

type Builder interface {
	RSAAlgorithmFromJWK(JWK string) (string, error)
}

func NewRSAAlgorithmBuilder(
	kid string,
	issuer string,
	subject string,
	audience string,
	expiration time.Time,
	claims map[string]interface{},
) Builder {
	return &rsaalgorithmLineBuilder{
		kid:        kid,
		Issuer:     issuer,
		Subject:    subject,
		Audience:   audience,
		Expiration: expiration,
		Claims:     claims,
	}
}

func (b *rsaalgorithmLineBuilder) RSAAlgorithmFromJWK(JWK string) (string, error) {
	privkey, err := jwk.ParseKey([]byte(JWK))

	if err != nil {
		return "", err
	}

	builder := jwt.NewBuilder().
		Issuer(b.Issuer).
		Subject(b.Subject).
		Audience([]string{b.Audience}).
		Expiration(b.Expiration)

	for k, v := range b.Claims {
		builder.Claim(k, v)
	}

	tok, err := builder.Build()

	if err != nil {
		return "", err
	}

	tok.Options().Enable(jwt.FlattenAudience)

	headers := jws.NewHeaders()

	headers.Set("kid", b.kid)

	signed, err := jwt.Sign(tok, jwt.WithKey(jwa.RS256(), privkey, jws.WithProtectedHeaders(headers)))

	if err != nil {
		return "", err
	}

	return string(signed), nil
}
