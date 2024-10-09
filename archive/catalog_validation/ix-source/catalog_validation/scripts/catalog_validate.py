#!/usr/bin/env python
import argparse

from catalog_validation.exceptions import CatalogDoesNotExist, ValidationErrors
from catalog_validation.validation import validate_catalog


def validate(catalog_path):

    try:
        validate_catalog(catalog_path)
    except CatalogDoesNotExist:
        print(f'[\033[91mFAILED\x1B[0m]\tSpecified {catalog_path!r} path does not exist')
        exit(1)
    except ValidationErrors as verrors:
        print('[\033[91mFAILED\x1B[0m]\tFollowing validation failures were found:')
        for index, verror in enumerate(verrors.errors):
            print(f'[\033[91m{index}\x1B[0m]\t{verror}')
        exit(1)
    else:
        print('[\033[92mOK\x1B[0m]\tPASSED VALIDATION CHECKS')


def main():
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(help='sub-command help', dest='action')

    parser_setup = subparsers.add_parser('validate', help='Validate TrueNAS catalog')
    parser_setup.add_argument('--path', help='Specify path of TrueNAS catalog')

    args = parser.parse_args()
    if args.action == 'validate':
        validate(args.path)
    else:
        parser.print_help()


if __name__ == '__main__':
    main()
