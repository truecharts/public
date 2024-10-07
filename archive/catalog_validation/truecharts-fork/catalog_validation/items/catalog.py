import concurrent.futures
import functools
import os
import typing
import yaml

from jsonschema import validate as json_schema_validate, ValidationError as JsonValidationError

from .items_util import get_item_details, get_default_questions_context
from .utils import RECOMMENDED_APPS_FILENAME, RECOMMENDED_APPS_SCHEMA, valid_train


def item_details(items: dict, location: str, questions_context: typing.Optional[dict], item_key: str) -> dict:
    train = items[item_key]
    item = item_key.removesuffix(f'_{train}')
    item_location = os.path.join(location, train, item)
    return get_item_details(item_location, questions_context, {'retrieve_versions': True})


def retrieve_train_names(location: str, all_trains=True, trains_filter=None) -> list:
    train_names = []
    trains_filter = trains_filter or []
    for train in os.listdir(location):
        if not (all_trains or train in trains_filter) or not valid_train(train, os.path.join(location, train)):
            continue
        train_names.append(train)
    return train_names


def get_items_in_trains(trains_to_traverse: list, catalog_location: str) -> dict:
    items = {}
    for train in trains_to_traverse:
        items.update({
            f'{i}_{train}': train for i in os.listdir(os.path.join(catalog_location, train))
            if os.path.isdir(os.path.join(catalog_location, train, i))
        })

    return items


def retrieve_trains_data(
    items: dict, catalog_location: str, preferred_trains: list,
    trains_to_traverse: list, job: typing.Any = None, questions_context: typing.Optional[dict] = None
) -> typing.Tuple[dict, set]:
    questions_context = questions_context or get_default_questions_context()
    trains = {
        'charts': {},
        'test': {},
        **{k: {} for k in trains_to_traverse},
    }
    unhealthy_apps = set()

    total_items = len(items)
    with concurrent.futures.ProcessPoolExecutor(max_workers=(20 if total_items > 10 else 5)) as exc:
        for index, result in enumerate(zip(items, exc.map(
            functools.partial(item_details, items, catalog_location, questions_context),
            items, chunksize=(10 if total_items > 10 else 5)
        ))):
            item_key = result[0]
            item_info = result[1]
            train = items[item_key]
            item = item_key.removesuffix(f'_{train}')
            if job:
                job.set_progress(
                    int((index / total_items) * 80) + 10,
                    f'Retrieved information of {item!r} item from {train!r} train'
                )
            trains[train][item] = item_info
            if train in preferred_trains and not trains[train][item]['healthy']:
                unhealthy_apps.add(f'{item} ({train} train)')

    return trains, unhealthy_apps


def retrieve_recommended_apps(catalog_location: str) -> typing.Dict[str, list]:
    try:
        with open(os.path.join(catalog_location, RECOMMENDED_APPS_FILENAME), 'r') as f:
            data = yaml.safe_load(f.read())
            json_schema_validate(data, RECOMMENDED_APPS_SCHEMA)
    except (FileNotFoundError, JsonValidationError, yaml.YAMLError):
        return {}
    else:
        return data
