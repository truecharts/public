package changelog

import (
    "fmt"
    "os"
    "path/filepath"
    "strings"
    "sync"

    "github.com/rs/zerolog/log"
)

type ActiveChart struct {
    Name  string
    Train string
}

type ActiveCharts struct {
    items map[string]ActiveChart
    mu    *sync.RWMutex
}

func (a *ActiveCharts) isActiveChart(chartName string) bool {
    a.mu.RLock()
    defer a.mu.RUnlock()
    _, ok := a.items[chartName]
    return ok
}

func (a *ActiveCharts) getActiveChartsWalker(path string, entry os.DirEntry, err error) error {
    if err != nil {
        return err
    }
    if entry.Name() != "Chart.yaml" {
        return nil
    }
    // path = charts/<train>/<chart>/Chart.yaml
    segLen := len(strings.Split(path, "/"))
    if segLen < 3 {
        return fmt.Errorf("path (%s) is not valid. expected at least charts/<train>/<chart>/Chart.yaml", path)
    }
    // chart = charts/<train>/<chart>/
    chart, _ := filepath.Split(path)
    // chart = charts/<train>/<chart>
    chart = strings.TrimSuffix(chart, "/")
    // train = charts/<train>
    train := filepath.Dir(chart)
    // train = <train>
    train = filepath.Base(train)
    // chartName = <chart>
    chartName := filepath.Base(chart)
    a.mu.Lock()
    if _, ok := a.items[chartName]; !ok {
        a.items[chartName] = ActiveChart{Name: chartName, Train: train}
    } else {
        log.Error().Msgf("chart [%s] already exists in activeCharts", chartName)
    }
    a.mu.Unlock()
    return nil
}
