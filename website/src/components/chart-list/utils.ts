import data from "../../assets/charts.json";
export const normalizeTrainName = (train: string) => {
  return train.toLowerCase();
};

export const titleCase = (str: string) => {
  return str
    .split(" ")
    .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
    .join(" ");
};

export const getTrains = () => {
  return data.trains.map((t) => t.name);
};

export const getChartsFromTrain = (train: string) => {
  return data.trains.filter((t) => t.name === train)[0].charts;
};

export const getChartDescription = (chart: string) => {
  return data.trains
    .map((t) => t.charts.filter((c) => c.name === chart)[0])
    .map((c) => c.description)[0];
};

export const getChartCountFromTrain = (train: string) => {
  return getChartsFromTrain(train).length;
};

export const getChartCount = () => {
  let count = 0;
  getTrains().forEach((train) => (count += getChartCountFromTrain(train)));
  return count;
};
