# frozen_string_literal: true
require_relative '../../test_helper'

class Test < ChartTest
  @@chart = Chart.new('charts/library/common-test')

  describe @@chart.name do
    describe 'addon::promtail' do
      it 'defaults to disabled' do
        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        promtailContainer = containers.find{ |c| c["name"] == "promtail" }

        assert_nil(promtailContainer)
      end

      it 'promtail can be enabled' do
        values = {
        addons: {
          promtail: {
            enabled: true,
            volumeMounts: [
              {
              name: "config",
              mountPath: "/tmp",
              readOnly: true
          }
        ]
          }
        }
      }

        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        promtailContainer = containers.find{ |c| c["name"] == "promtail" }

        refute_nil(promtailContainer)
      end
    end
  end
end
