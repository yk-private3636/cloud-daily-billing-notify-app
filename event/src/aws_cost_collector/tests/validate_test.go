package tests

import (
	"testing"

	"github.com/yk-private3636/cloud-daily-billing-notify-app/event/src/aws_cost_collector/modules"
)

func TestIsDateDiffWithinDays(t *testing.T) {
	t.Run("DifferenceWithinLimit", func(t *testing.T) {
		from := "2024-01-01"
		to := "2024-01-08"
		diff := 10

		judge := modules.IsDateDiffWithinDays(from, to, diff)

		if !judge {
			t.Errorf("Expected true, but got false")
		}
	})

	t.Run("DifferenceAtLimit", func(t *testing.T) {
		from := "2024-01-01"
		to := "2024-01-11"
		diff := 10

		judge := modules.IsDateDiffWithinDays(from, to, diff)

		if !judge {
			t.Errorf("Expected true, but got false")
		}
	})

	t.Run("DifferenceExceedsLimit", func(t *testing.T) {
		from := "2024-01-01"
		to := "2024-01-12"
		diff := 10

		judge := modules.IsDateDiffWithinDays(from, to, diff)

		if judge {
			t.Errorf("Expected false, but got true")
		}
	})

	t.Run("InvalidFromDate", func(t *testing.T) {
		from := "invalid-date"
		to := "2024-01-08"
		diff := 10

		judge := modules.IsDateDiffWithinDays(from, to, diff)

		if judge {
			t.Errorf("Expected false due to invalid date, but got true")
		}
	})

	t.Run("InvalidToDate", func(t *testing.T) {
		from := "2024-01-01"
		to := "invalid-date"
		diff := 10

		judge := modules.IsDateDiffWithinDays(from, to, diff)

		if judge {
			t.Errorf("Expected false due to invalid date, but got true")
		}
	})
}
