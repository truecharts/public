# frozen_string_literal: true
require_relative '../../test_helper'

class Test < ChartTest
  @@chart = Chart.new('charts/library/common-test')

  describe @@chart.name do
    describe 'addon::netshoot' do
      it 'defaults to disabled' do
        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        netshootContainer = containers.find{ |c| c["name"] == "netshoot" }

        assert_nil(netshootContainer)
      end

      it 'netshoot can be enabled' do
        values = {
        addons: {
          netshoot: {
            enabled: true
          }
        }
      }

        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        netshootContainer = containers.find{ |c| c["name"] == "netshoot" }

        refute_nil(netshootContainer)
      end
    end
  end
end
