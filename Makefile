
validate-machinaris:
	@helm dependency update ./charts/machinaris/${v}
	@helm template --values ./charts/machinaris/${v}/test_values.yaml machinaris ./charts/machinaris/${v} --debug
