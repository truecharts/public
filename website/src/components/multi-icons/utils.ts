import { contributors } from "../../assets/contributors.json";
import { getChartsFromTrain, getTrains } from "../chart-list/utils";

// Contributors
const genContribImageName = (url: string) => {
  return url.split("/").pop()?.split("?v")[0];
};
const genContribImageUrl = (name: string) => {
  return `/assets/contributors/${genContribImageName(name)}.webp`;
};

export const getContributors = () => {
  // Remove people with no image
  let filteredPeople = contributors.filter((p) => p.avatar_url !== null);
  // Deduplicate people
  filteredPeople = filteredPeople.reduce((total, person) => {
    // if profile is already in total, skip
    if (total.some((p) => p.profile === person.profile)) return total;
    // if name is already in total, skip
    if (total.some((p) => p.name === person.name)) return total;
    // make sure the image name can be generated
    if (!genContribImageName(person.avatar_url)) return total;

    total.push(person);
    return total;
  }, [] as typeof filteredPeople);

  return filteredPeople.map((p) => ({
    id: p.name,
    img: genContribImageUrl(p.avatar_url),
    url: p.profile,
  }));
};

// Charts
export const getChartImageUrl = (name: string) => {
  return `/img/hotlink-ok/chart-icons-small/${name}.webp`;
};

export const getCharts = () => {
  const trains = getTrains();
  const charts = trains.map((train) => getChartsFromTrain(train)).flat();
  return charts.map((c) => ({
    id: c.name,
    img: getChartImageUrl(c.name),
    url: c.link,
  }));
};
