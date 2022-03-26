# frozen_string_literal: true
require_relative '../../test_helper'

class Test < ChartTest
  @@chart = Chart.new('charts/library/common-test')

  describe @@chart.name do
    describe 'pod::replicas' do
      it 'defaults to 1' do
        deployment = chart.resources(kind: "Deployment").first
        assert_equal(1, deployment["spec"]["replicas"])
      end

      it 'accepts integer as value' do
        values = {
          controller: {
            replicas: 3
          }
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        assert_equal(3, deployment["spec"]["replicas"])
      end
    end

    describe 'pod::hostNetwork' do
      it 'defaults to nil' do
        deployment = chart.resources(kind: "Deployment").first
        assert_nil(deployment["spec"]["template"]["spec"]["hostNetwork"])
      end

      it 'can be enabled' do
        values = {
          hostNetwork: true
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        assert_equal(true, deployment["spec"]["template"]["spec"]["hostNetwork"])
      end
    end

    describe 'pod::dnsPolicy' do
      it 'defaults to "ClusterFirst" without hostNetwork' do
        deployment = chart.resources(kind: "Deployment").first
        assert_equal("ClusterFirst", deployment["spec"]["template"]["spec"]["dnsPolicy"])
      end

      it 'defaults to "ClusterFirst" when hostNetwork: false' do
        values = {
          hostNetwork: false
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        assert_equal("ClusterFirst", deployment["spec"]["template"]["spec"]["dnsPolicy"])
      end

      it 'defaults to "ClusterFirstWithHostNet" when hostNetwork: true' do
        values = {
          hostNetwork: true
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        assert_equal("ClusterFirstWithHostNet", deployment["spec"]["template"]["spec"]["dnsPolicy"])
      end

      it 'accepts manual override' do
        values = {
          dnsPolicy: "None"
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        assert_equal("None", deployment["spec"]["template"]["spec"]["dnsPolicy"])
      end
    end

    describe 'pod::additional containers' do
      it 'accepts static additionalContainers' do
        values = {
          additionalContainers: [
            {
              name: "template-test"
            }
          ]
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        additionalContainer = containers.find{ |c| c["name"] == values[:additionalContainers][0][:name] }
        refute_nil(additionalContainer)
      end

      it 'accepts "Dynamic/Tpl" additionalContainers' do
        expectedContainerName = "common-test-container"
        values = {
          additionalContainers: [
            {
              name: "{{ .Release.Name }}-container",
            }
          ]
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        additionalContainer = containers.find{ |c| c["name"] == expectedContainerName }
        refute_nil(additionalContainer)
      end
    end
  end
end
