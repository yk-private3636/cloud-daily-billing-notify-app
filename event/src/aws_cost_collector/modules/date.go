package modules

import "time"

func AddDateString(dateStr string, days int) (string, error) {
	date, err := time.Parse(time.DateOnly, dateStr)
	if err != nil {
		return "", err
	}

	return date.AddDate(0, 0, days).Format(time.DateOnly), nil
}
