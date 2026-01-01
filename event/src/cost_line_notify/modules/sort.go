package modules

import (
	"sort"
)

func GetDailyCostKeysAsc(m map[string]map[string]float64) []string {
	keys := make([]string, 0, len(m))

	for k := range m {
		keys = append(keys, k)
	}

	sort.Strings(keys)

	return keys
}
