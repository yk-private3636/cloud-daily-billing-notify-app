package tests

import (
	"testing"

	"github.com/yk-private3636/cloud-daily-billing-notify-app/event/src/cost_line_notify/modules"
)

func TestGetDailyCostKeysAsc(t *testing.T) {
	t.Run("should return keys in ascending order", func(t *testing.T) {
		m := map[string]map[string]float64{
			"2025-07-03": {
				"A": 1,
			},
			"2025-07-01": {
				"A": 1,
			},
			"2025-07-02": {
				"A": 1,
			},
		}

		keys := modules.GetDailyCostKeysAsc(m)

		expected := []string{
			"2025-07-01",
			"2025-07-02",
			"2025-07-03",
		}

		for i, v := range expected {
			if keys[i] != v {
				t.Errorf("expected %s, but got %s", v, keys[i])
			}
		}
	})

	t.Run("should return empty slice when map is empty", func(t *testing.T) {
		m := map[string]map[string]float64{}

		keys := modules.GetDailyCostKeysAsc(m)

		if len(keys) != 0 {
			t.Errorf("expected length 0, but got %d", len(keys))
		}
	})
}
