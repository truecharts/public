# frozen_string_literal: true
require_relative '../../test_helper'

class Test < ChartTest
  @@chart = Chart.new('charts/library/common-test')

  describe @@chart.name do
    describe 'addon::codeserver' do
      baseValues = {
        addons: {
          codeserver: {
            enabled: true,
            volumeMounts: [
              {
                name: "config",
                mountPath: "/data/config"
              }
            ]
          }
        }
      }

      it 'defaults to disabled' do
        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        codeserverContainer = containers.find{ |c| c["name"] == "codeserver" }

        assert_nil(codeserverContainer)
      end

      it 'can be enabled' do
        values = baseValues

        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        codeserverContainer = containers.find{ |c| c["name"] == "codeserver" }

        refute_nil(codeserverContainer)
      end

      it 'a git deployKey can be passed' do
        values = baseValues.deep_merge_override({
          addons: {
            codeserver: {
              git: {
                deployKey: "testKey"
              }
            }
          }
        })

        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        secret = chart.resources(kind: "Secret").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        volumes = deployment["spec"]["template"]["spec"]["volumes"]
        codeserverContainer = containers.find{ |c| c["name"] == "codeserver" }
        expectedSecretContent = { "id_rsa" => values[:addons][:codeserver][:git][:deployKey] }

        # Check that the secret has been created
        refute_nil(secret)
        assert_equal("common-test-deploykey", secret["metadata"]["name"])
        assert_equal(expectedSecretContent, secret["stringData"])

        # Make sure the deployKey volumeMount is present in the sidecar container
        deploykeyVolumeMount = codeserverContainer["volumeMounts"].find { |v| v["name"] == "deploykey"}
        refute_nil(deploykeyVolumeMount)
        assert_equal("/root/.ssh/id_rsa", deploykeyVolumeMount["mountPath"])
        assert_equal("id_rsa", deploykeyVolumeMount["subPath"])

        # Make sure the deployKey volume is present in the Deployment
        deploykeyVolume = volumes.find{ |v| v["name"] == "deploykey" }
        refute_nil(deploykeyVolume)
        assert_equal("common-test-deploykey", deploykeyVolume["secret"]["secretName"])
      end

      it 'a git deployKey can be passed in base64 format' do
        values = baseValues.deep_merge_override({
          addons: {
            codeserver: {
              git: {
                deployKeyBase64: "dGVzdEtleQ=="
              }
            }
          }
        })

        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        secret = chart.resources(kind: "Secret").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        volumes = deployment["spec"]["template"]["spec"]["volumes"]
        codeserverContainer = containers.find{ |c| c["name"] == "codeserver" }
        expectedSecretContent = { "id_rsa" => values[:addons][:codeserver][:git][:deployKeyBase64] }

        # Check that the secret has been created
        refute_nil(secret)
        assert_equal("common-test-deploykey", secret["metadata"]["name"])
        assert_equal(expectedSecretContent, secret["data"])

        # Make sure the deployKey volumeMount is present in the sidecar container
        deploykeyVolumeMount = codeserverContainer["volumeMounts"].find { |v| v["name"] == "deploykey"}
        refute_nil(deploykeyVolumeMount)
        assert_equal("/root/.ssh/id_rsa", deploykeyVolumeMount["mountPath"])
        assert_equal("id_rsa", deploykeyVolumeMount["subPath"])

        # Make sure the deployKey volume is present in the Deployment
        deploykeyVolume = volumes.find{ |v| v["name"] == "deploykey" }
        refute_nil(deploykeyVolume)
        assert_equal("common-test-deploykey", deploykeyVolume["secret"]["secretName"])
      end

      it 'an existing secret can be passed as a git deployKey' do
        values = baseValues.deep_merge_override({
          addons: {
            codeserver: {
              git: {
                deployKeySecret: "existingSecret"
              }
            }
          }
        })

        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        secret = chart.resources(kind: "Secret").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        volumes = deployment["spec"]["template"]["spec"]["volumes"]
        codeserverContainer = containers.find{ |c| c["name"] == "codeserver" }

        # Check that the secret has not been created
        assert_nil(secret)

        # Make sure the deployKey volumeMount is present in the sidecar container
        deploykeyVolumeMount = codeserverContainer["volumeMounts"].find { |v| v["name"] == "deploykey"}
        refute_nil(deploykeyVolumeMount)
        assert_equal("/root/.ssh/id_rsa", deploykeyVolumeMount["mountPath"])
        assert_equal("id_rsa", deploykeyVolumeMount["subPath"])

        # Make sure the deployKey volume is present in the Deployment
        deploykeyVolume = volumes.find{ |v| v["name"] == "deploykey" }
        refute_nil(deploykeyVolume)
        assert_equal(values[:addons][:codeserver][:git][:deployKeySecret], deploykeyVolume["secret"]["secretName"])
      end
    end
  end
end
