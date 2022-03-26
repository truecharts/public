# frozen_string_literal: true
require_relative '../../test_helper'

class Test < ChartTest
  @@chart = Chart.new('charts/library/common-test')

  describe @@chart.name do

    describe 'pod::persistence' do
      it 'multiple volumes' do
        values = {
          persistence: {
            cache: {
              enabled: true,
              type: "emptyDir"
            },
            config: {
              enabled: true,
              existingClaim: "configClaim"
            },
            data: {
              enabled: true,
              existingClaim: "dataClaim"
            }
          }
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        volumes = deployment["spec"]["template"]["spec"]["volumes"]

        volume = volumes.find{ |v| v["name"] == "cache"}
        refute_nil(volume)

        volume = volumes.find{ |v| v["name"] == "config"}
        refute_nil(volume)
        assert_equal('configClaim', volume["persistentVolumeClaim"]["claimName"])

        volume = volumes.find{ |v| v["name"] == "data"}
        refute_nil(volume)
        assert_equal('dataClaim', volume["persistentVolumeClaim"]["claimName"])
      end

      it 'default nameSuffix' do
        values = {
          persistence: {
            config: {
              enabled: true
            }
          }
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        volumes = deployment["spec"]["template"]["spec"]["volumes"]
        volume = volumes.find{ |v| v["name"] == "config"}
        refute_nil(volume)
        assert_equal('common-test-config', volume["persistentVolumeClaim"]["claimName"])
      end

      it 'custom nameSuffix' do
        values = {
          persistence: {
            config: {
              enabled: true,
              nameOverride: "test"
            }
          }
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        volumes = deployment["spec"]["template"]["spec"]["volumes"]
        volume = volumes.find{ |v| v["name"] == "config"}
        refute_nil(volume)
        assert_equal('common-test-test', volume["persistentVolumeClaim"]["claimName"])
      end

      it 'no nameSuffix' do
        values = {
          persistence: {
            config: {
              enabled: true,
              nameOverride: "-"
            }
          }
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        volumes = deployment["spec"]["template"]["spec"]["volumes"]
        volume = volumes.find{ |v| v["name"] == "config"}
        refute_nil(volume)
        assert_equal('common-test', volume["persistentVolumeClaim"]["claimName"])
      end
    end

    describe 'pod::persistence::emptyDir' do
      it 'can be configured' do
        values = {
          persistence: {
            config: {
              enabled: true,
              type: "emptyDir"
            }
          }
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        volumes = deployment["spec"]["template"]["spec"]["volumes"]
        volume = volumes.find{ |v| v["name"] == "config"}
        refute_nil(volume)
        assert_equal(Hash.new, volume["emptyDir"])
      end

      it 'medium can be configured' do
        values = {
          persistence: {
            config: {
              enabled: true,
              type: "emptyDir",
              medium: "memory"
            }
          }
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        volumes = deployment["spec"]["template"]["spec"]["volumes"]
        volume = volumes.find{ |v| v["name"] == "config"}
        refute_nil(volume)
        assert_equal("memory", volume["emptyDir"]["medium"])
      end

      it 'sizeLimit can be configured' do
        values = {
          persistence: {
            config: {
              enabled: true,
              type: "emptyDir",
              medium: "memory",
              sizeLimit: "1Gi"
            }
          }
      }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        volumes = deployment["spec"]["template"]["spec"]["volumes"]
        volume = volumes.find{ |v| v["name"] == "config"}
        refute_nil(volume)
        assert_equal("1Gi", volume["emptyDir"]["sizeLimit"])
      end
    end

    describe 'pod::persistenceList' do
      it 'multiple volumes' do
        values = {
          persistenceList: [
            {
              name: "data",
              enabled: true,
              type: "hostPath",
              mountPath: "/data",
              hostPath: "/tmp1"
            },
            {
              name: "configlist",
              type: "hostPath",
              enabled: true,
              mountPath: "/config",
              hostPath: "/tmp2"
            }
          ]
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        volumes = deployment["spec"]["template"]["spec"]["volumes"]

        volume = volumes.find{ |v| v["name"] == "data"}
        refute_nil(volume)
        assert_equal('/tmp1', volume["hostPath"]["path"])

        volume = volumes.find{ |v| v["name"] == "configlist"}
        refute_nil(volume)
        assert_equal('/tmp2', volume["hostPath"]["path"])
      end

      it 'emptyDir can be enabled' do
        values = {
          persistenceList: [
            {
              name: "data",
              type: "emptyDir",
              enabled: true,
              mountPath: "/data"
            }
          ]
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        volumes = deployment["spec"]["template"]["spec"]["volumes"]
        volume = volumes.find{ |v| v["name"] == "data"}
        refute_nil(volume)
        assert_equal(Hash.new, volume["emptyDir"])
      end
    end


    describe 'container::persistence' do
      it 'supports multiple volumeMounts' do
        values = {
          persistence: {
              cache: {
                enabled: true,
                type: "emptyDir"
              },
              config: {
                enabled: true,
                existingClaim: "configClaim"
              },
              data: {
                enabled: true,
                existingClaim: "dataClaim"
              }
            }
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        mainContainer = containers.find{ |c| c["name"] == "common-test" }

        # Check that all persistent volumes have mounts
        values[:persistence].each { |key, value|
          volumeMount = mainContainer["volumeMounts"].find{ |v| v["name"] == key.to_s }
          refute_nil(volumeMount)
        }
      end

      it 'defaults mountPath to persistence key' do
        values = {
          persistence: {
              data: {
                enabled: true,
                existingClaim: "dataClaim"
              }
            }
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        mainContainer = containers.find{ |c| c["name"] == "common-test" }

        volumeMount = mainContainer["volumeMounts"].find{ |v| v["name"] == "data" }
        refute_nil(volumeMount)
        assert_equal("/data", volumeMount["mountPath"])
      end

      it 'supports setting custom mountPath' do
        values = {
          persistence: {
              data: {
                enabled: true,
                existingClaim: "dataClaim",
                mountPath: "/myMountPath"
              }
            }
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        mainContainer = containers.find{ |c| c["name"] == "common-test" }

        volumeMount = mainContainer["volumeMounts"].find{ |v| v["name"] == "data" }
        refute_nil(volumeMount)
        assert_equal("/myMountPath", volumeMount["mountPath"])
      end

      it 'supports setting subPath' do
        values = {
          persistence: {
              data: {
                enabled: true,
                existingClaim: "dataClaim",
                subPath: "mySubPath"
              }
            }
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        mainContainer = containers.find{ |c| c["name"] == "common-test" }

        volumeMount = mainContainer["volumeMounts"].find{ |v| v["name"] == "data" }
        refute_nil(volumeMount)
        assert_equal("mySubPath", volumeMount["subPath"])
      end
    end

    describe 'container::persistenceList' do
      it 'supports multiple persistenceList' do
        values = {
          persistenceList: [
          {
                name: "data",
                enabled: true,
                mountPath: "/data",
                hostPath: "/tmp"
          },
          {
                name: "config",
                enabled: true,
                mountPath: "/config",
                hostPath: "/tmp"
          }
          ]
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        mainContainer = containers.find{ |c| c["name"] == "common-test" }

        # Check that all persistenceList volumes have mounts
        values[:persistenceList].each { |value|
          volumeMount = mainContainer["volumeMounts"].find{ |v| v["name"] == value[:name].to_s }
          refute_nil(volumeMount)
        }
      end

      it 'supports setting mountPath' do
        values = {
          persistenceList: [
          {
                name: "data",
                enabled: true,
                mountPath: "/data",
                hostPath: "/tmp"
          }
          ]
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        mainContainer = containers.find{ |c| c["name"] == "common-test" }

        volumeMount = mainContainer["volumeMounts"].find{ |v| v["name"] == "data" }
        refute_nil(volumeMount)
        assert_equal("/data", volumeMount["mountPath"])
      end

      it 'supports setting subPath' do
        values = {
          persistenceList: [
          {
                name: "data",
                enabled: true,
                mountPath: "/data",
                hostPath: "/tmp",
                subPath: "mySubPath"
          }
          ]
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        mainContainer = containers.find{ |c| c["name"] == "common-test" }

        volumeMount = mainContainer["volumeMounts"].find{ |v| v["name"] == "data" }
        refute_nil(volumeMount)
        assert_equal("mySubPath", volumeMount["subPath"])
      end
    end
  end
end
