# Library Chart

[![Common Library Tests](https://github.com/truecharts/library-charts/actions/workflows/common_library_tests.yaml/badge.svg?event=push)](https://github.com/truecharts/library-charts/actions/workflows/common_library_tests.yaml)

Helm Library Chart for TrueCharts Charts and Apps

## Feature addition(s) or enhancements

Please first discuss with us the feature you want to add, especially if it's a large one.
This is to ensure we have an extendable and maintainable implementation!

Keep in mind that both docs and unit tests are required in order to complete/merge the feature addition or enhancement.

## Bug fixes

Bug fixes should also be covered by a test case for that scenario. No PRs will be accepted without this.

---

## Contributions

- Any kind of change (feature or bug fix) that alters/adds/removes a key in the values structure have to also be [documented](https://github.com/truecharts/website)
- Additionally, unit tests must be added to cover the change, and if a migration is needed, must be added at the PR description.

Both are a hard requirement.

- Adding dependency handlers in the library chart, would assume that a dependency chart is already implemented and **merged** in the [charts](https://github.com/truecharts/charts) repo.
