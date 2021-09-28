# frozen_string_literal: true
require_relative '../../test_helper'

class Test < ChartTest
  @@chart = Chart.new('charts/library/common-test')

  describe @@chart.name do

    describe 'hpa::defaults' do
      it 'does not exist by default' do
        hpa = chart.resources(kind: "HorizontalPodAutoscaler").first
        assert_nil(hpa)
      end

      it 'can be enabled' do
        values = {
          autoscaling: {
            enabled: true
          }
        }
        chart.value values
        hpa = chart.resources(kind: "HorizontalPodAutoscaler").first
        refute_nil(hpa)
      end

      it 'default target is common.names.fullname ' do
        values = {
          autoscaling: {
            enabled: true
          }
        }
        chart.value values
        hpa = chart.resources(kind: "HorizontalPodAutoscaler").first
        assert_equal("common-test",hpa["spec"]["scaleTargetRef"]["name"])
      end

      it 'default numer of replicas is min 1 max 3' do
        values = {
          autoscaling: {
            enabled: true
          }
        }
        chart.value values
        hpa = chart.resources(kind: "HorizontalPodAutoscaler").first
        assert_equal(1,hpa["spec"]["minReplicas"])
        assert_equal(3,hpa["spec"]["maxReplicas"])
      end
    end

    describe 'hpa::customsettings' do
      it 'can override target' do
        values = {
          autoscaling: {
            enabled: true,
            target: "targetname"
          }
        }
        chart.value values
        hpa = chart.resources(kind: "HorizontalPodAutoscaler").first
        assert_equal(values[:autoscaling][:target],hpa["spec"]["scaleTargetRef"]["name"])
      end

      it 'can change min and max replicas' do
        values = {
          autoscaling: {
            enabled: true,
            minReplicas: 4,
            maxReplicas: 8
          }
        }
        chart.value values
        hpa = chart.resources(kind: "HorizontalPodAutoscaler").first
        assert_equal(values[:autoscaling][:minReplicas],hpa["spec"]["minReplicas"])
        assert_equal(values[:autoscaling][:maxReplicas],hpa["spec"]["maxReplicas"])
      end

      it 'can set targetCPUUtilizationPercentage' do
        values = {
          autoscaling: {
            enabled: true,
            targetCPUUtilizationPercentage: 60
          }
        }
        chart.value values
        hpa = chart.resources(kind: "HorizontalPodAutoscaler").first
        assert_equal("cpu",hpa["spec"]["metrics"][0]["resource"]["name"])
        assert_equal(values[:autoscaling][:targetCPUUtilizationPercentage],hpa["spec"]["metrics"][0]["resource"]["targetAverageUtilization"])
      end

      it 'can set targetMemoryUtilizationPercentage' do
        values = {
          autoscaling: {
            enabled: true,
            targetMemoryUtilizationPercentage: 70
          }
        }
        chart.value values
        hpa = chart.resources(kind: "HorizontalPodAutoscaler").first
        assert_equal("memory",hpa["spec"]["metrics"][0]["resource"]["name"])
        assert_equal(values[:autoscaling][:targetMemoryUtilizationPercentage],hpa["spec"]["metrics"][0]["resource"]["targetAverageUtilization"])
      end

      it 'can set both targetCPU and targetMemoryUtilizationPercentage' do
        values = {
          autoscaling: {
            enabled: true,
            targetCPUUtilizationPercentage: 60,
            targetMemoryUtilizationPercentage: 70
          }
        }
        chart.value values
        hpa = chart.resources(kind: "HorizontalPodAutoscaler").first
        assert_equal("cpu",hpa["spec"]["metrics"][0]["resource"]["name"])
        assert_equal(values[:autoscaling][:targetCPUUtilizationPercentage],hpa["spec"]["metrics"][0]["resource"]["targetAverageUtilization"])
        assert_equal("memory",hpa["spec"]["metrics"][1]["resource"]["name"])
        assert_equal(values[:autoscaling][:targetMemoryUtilizationPercentage],hpa["spec"]["metrics"][1]["resource"]["targetAverageUtilization"])
      end
    end
  end
end
