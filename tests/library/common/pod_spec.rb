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
        chart.value replicas: 3
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

    describe 'pod::persistence' do
      it 'multiple volumes' do
        values = {
          persistence: {
              cache: {
                enabled: true,
                emptyDir: {
                  enabled: true
                }
              },
              config: {
                enabled: true,
                existingClaim: "configClaim",
                emptyDir: {
                  enabled: false
                }
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
                enabled: true,
                emptyDir: {
                  enabled: false
                }
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
                nameSuffix: "test",
                emptyDir: {
                  enabled: false
                }
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
                nameSuffix: "-",
                emptyDir: {
                  enabled: false
                }
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
                emptyDir: {
                  enabled: true
                }
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
                emptyDir: {
                  enabled: true,
                  medium: "memory"
                }
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
                emptyDir: {
                  enabled: true,
                  medium: "memory",
                  sizeLimit: "1Gi"
                }
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

    describe 'pod::hostPathMounts' do
      it 'multiple volumes' do
        values = {
          hostPathMounts: [
          {
                name: "data",
                enabled: true,
                mountPath: "/data",
                hostPath: "/tmp1"
          },
          {
                name: "config",
                enabled: true,
                mountPath: "/config",
                hostPath: "/tmp2"
          }
          ]
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        volumes = deployment["spec"]["template"]["spec"]["volumes"]

        volume = volumes.find{ |v| v["name"] == "hostpathmounts-data"}
        refute_nil(volume)
        assert_equal('/tmp1', volume["hostPath"]["path"])

        volume = volumes.find{ |v| v["name"] == "hostpathmounts-config"}
        refute_nil(volume)
        assert_equal('/tmp2', volume["hostPath"]["path"])
      end

      it 'emptyDir can be enabled' do
        values = {
          hostPathMounts: [
          {
                name: "data",
                enabled: true,
                emptyDir: true,
                mountPath: "/data"
          }
          ]
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        volumes = deployment["spec"]["template"]["spec"]["volumes"]
        volume = volumes.find{ |v| v["name"] == "hostpathmounts-data"}
        refute_nil(volume)
        assert_equal(Hash.new, volume["emptyDir"])
      end
    end
  end
end
