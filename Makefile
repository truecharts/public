
validate:
	@helm dependency update ./test/machinaris/1.0.11
	@helm template --values ./test/machinaris/1.0.11/ix_values.yaml machinaris ./test/machinaris/1.0.11 --debug