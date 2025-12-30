package modules

import (
	"time"
)

func IsDateDiffWithinDays(from, to string, diff int) bool {
	f, err := time.Parse(time.DateOnly, from)

	if err != nil {
		return false
	}

	t, err := time.Parse(time.DateOnly, to)

	if err != nil {
		return false
	}

	isWithin := t.Sub(f).Hours()/24 <= float64(diff)

	return isWithin
}
