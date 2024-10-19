package website

import (
    "encoding/json"
    "fmt"
    "os"
    "path/filepath"
    "slices"
    "sync"

    "github.com/truecharts/public/clustertool/pkg/charts/chartFile"
    "github.com/truecharts/public/clustertool/pkg/helper"
)

type ChartList struct {
    TotalCount int64   `json:"totalCount"`
    Trains     []Train `json:"trains"`
}

type Train struct {
    Name   string  `json:"name"`
    Count  int64   `json:"count"`
    Charts []Chart `json:"charts"`
}

type Chart struct {
    Name        string `json:"name"`
    Description string `json:"description"`
    Train       string `json:"train"`
    Link        string `json:"link"`
    Icon        string `json:"icon"`
    Version     string `json:"version"`
}

type ChartListOptions struct {
    OutputPath  string   // Path to put the chart list json file
    TrainFilter []string // Empty means all trains
    sync.Mutex
    list *ChartList
}

func (o *ChartListOptions) WriteChartList() error {
    if o.list == nil {
        return fmt.Errorf("chart list is nil")
    }

    data, err := json.Marshal(o.list)
    if err != nil {
        return err
    }

    return os.WriteFile(o.OutputPath, data, 0644)
}
func (o *ChartListOptions) GetChartData(path string, entry os.DirEntry, err error) error {
    if o.list == nil {
        o.list = &ChartList{}
    }

    if err != nil {
        return err
    }

    // Skip directories that are excluded
    if entry.IsDir() && slices.Contains(helper.ExcludedDirs, entry.Name()) {
        return filepath.SkipDir
    }

    if entry.Name() != "Chart.yaml" {
        return nil
    }

    chart := chartFile.NewHelmChart()
    if err := chart.LoadFromFile(path); err != nil {
        return err
    }

    train := chartFile.GetTrain(path, chart)
    if len(o.TrainFilter) > 0 {
        if !slices.Contains(o.TrainFilter, train) {
            return nil
        }
    }

    o.Lock()
    defer o.Unlock()
    // Increment the total count
    o.list.TotalCount++
    webChart := Chart{
        Name:        chart.Metadata.Name,
        Description: chart.Metadata.Description,
        Icon:        chart.Metadata.Icon,
        Link:        chart.Metadata.Home,
        Version:     chart.Metadata.Version,
        Train:       chartFile.GetTrain(path, chart),
    }

    trainExists := false
    for idx, train := range o.list.Trains {
        if train.Name == webChart.Train {
            trainExists = true
            // Increase chart count for the existing train
            o.list.Trains[idx].Count++
            // Add the chart to the existing train
            o.list.Trains[idx].Charts = append(o.list.Trains[idx].Charts, webChart)
        }
    }
    if trainExists {
        return nil
    }

    // Add a new train with the chart
    o.list.Trains = append(o.list.Trains, Train{
        Name:   webChart.Train,
        Count:  1,
        Charts: []Chart{webChart},
    })

    return nil
}
