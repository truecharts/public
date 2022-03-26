# frozen_string_literal: true
require_relative '../../test_helper'

class Test < ChartTest
  @@chart = Chart.new('charts/library/common-test')

  describe @@chart.name do
    describe 'service::ports settings' do
      baseValues = {
        service: {
          main: {
            ports: {
              main: {
                port: 8080
              }
            }
          }
        }
      }

      default_name = 'main'
      default_port = 8080

      it 'defaults to name "http" on port 8080' do
        values = baseValues
        chart.value values

        service = chart.resources(kind: "Service").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(service)
        assert_equal(default_port, service["spec"]["ports"].first["port"])
        assert_equal(default_name, service["spec"]["ports"].first["targetPort"])
        assert_equal(default_name, service["spec"]["ports"].first["name"])

        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        mainContainer = containers.find{ |c| c["name"] == "common-test" }
        assert_equal(default_port, mainContainer["ports"].first["containerPort"])
        assert_equal(default_name, mainContainer["ports"].first["name"])
      end

      it 'port name can be set' do
        values = baseValues.deep_merge_override({
          service: {
            main: {
              ports: {
                main: {
                  enabled: false
                },
                server: {
                  enabled: true,
                  port: 8080
                }
              }
            }
          }
        })
        chart.value values

        service = chart.resources(kind: "Service").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(service)
        assert_equal(default_port, service["spec"]["ports"].first["port"])
        assert_equal('server', service["spec"]["ports"].first["targetPort"])
        assert_equal('server', service["spec"]["ports"].first["name"])

        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        mainContainer = containers.find{ |c| c["name"] == "common-test" }
        assert_equal(default_port, mainContainer["ports"].first["containerPort"])
        assert_equal('server', mainContainer["ports"].first["name"])
      end

      it 'name suffix can be overridden' do
        values = baseValues.deep_merge_override({
          service: {
            main: {
              nameOverride: 'http'
            }
          }
        })
        chart.value values

        service = chart.resources(kind: "Service").find{ |s| s["metadata"]["name"] == "common-test-#{values[:service][:main][:nameOverride]}" }
        refute_nil(service)
      end

      it 'targetPort can be overridden' do
        values = baseValues.deep_merge_override({
          service: {
            main: {
              ports: {
                main: {
                  targetPort: 80
                }
              }
            }
          }
        })
        chart.value values

        service = chart.resources(kind: "Service").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(service)
        assert_equal(default_port, service["spec"]["ports"].first["port"])
        assert_equal(80, service["spec"]["ports"].first["targetPort"])
        assert_equal(default_name, service["spec"]["ports"].first["name"])

        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        mainContainer = containers.find{ |c| c["name"] == "common-test" }
        assert_equal(80, mainContainer["ports"].first["containerPort"])
        assert_equal(default_name, mainContainer["ports"].first["name"])
      end

      it 'targetPort cannot be a named port' do
        values = baseValues.deep_merge_override({
          service: {
            main: {
              ports: {
                main: {
                  targetPort: 'test'
                }
              }
            }
          }
        })
        chart.value values

        exception = assert_raises HelmCompileError do
          chart.execute_helm_template!
        end
        assert_match("Our charts do not support named ports for targetPort. (port name #{default_name}, targetPort test)", exception.message)
      end

      it 'protocol defaults to TCP' do
        values = baseValues
        chart.value values

        service = chart.resources(kind: "Service").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(service)
        assert_equal("TCP", service["spec"]["ports"].first["protocol"])

        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        mainContainer = containers.find{ |c| c["name"] == "common-test" }
        assert_equal("TCP", mainContainer["ports"].first["protocol"])
      end

      it 'protocol is TCP when set to TCP explicitly' do
        values = baseValues.deep_merge_override({
          service: {
            main: {
              ports: {
                main: {
                  protocol: 'TCP'
                }
              }
            }
          }
        })
        chart.value values

        service = chart.resources(kind: "Service").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(service)
        assert_equal("TCP", service["spec"]["ports"].first["protocol"])

        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        mainContainer = containers.find{ |c| c["name"] == "common-test" }
        assert_equal("TCP", mainContainer["ports"].first["protocol"])
      end

      it 'protocol is TCP when set to HTTP explicitly' do
        values = baseValues.deep_merge_override({
          service: {
            main: {
              ports: {
                main: {
                  protocol: 'HTTP'
                }
              }
            }
          }
        })
        chart.value values

        service = chart.resources(kind: "Service").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(service)
        assert_equal("TCP", service["spec"]["ports"].first["protocol"])

        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        mainContainer = containers.find{ |c| c["name"] == "common-test" }
        assert_equal("TCP", mainContainer["ports"].first["protocol"])
      end

      it 'protocol is TCP when set to HTTPS explicitly' do
        values = baseValues.deep_merge_override({
          service: {
            main: {
              ports: {
                main: {
                  protocol: 'HTTPS'
                }
              }
            }
          }
        })
        chart.value values

        service = chart.resources(kind: "Service").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(service)
        assert_equal("TCP", service["spec"]["ports"].first["protocol"])

        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        mainContainer = containers.find{ |c| c["name"] == "common-test" }
        assert_equal("TCP", mainContainer["ports"].first["protocol"])
      end

      it 'protocol is UDP when set to UDP explicitly' do
        values = baseValues.deep_merge_override({
          service: {
            main: {
              ports: {
                main: {
                  protocol: 'UDP'
                }
              }
            }
          }
        })
        chart.value values

        service = chart.resources(kind: "Service").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(service)
        assert_equal("UDP", service["spec"]["ports"].first["protocol"])

        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        mainContainer = containers.find{ |c| c["name"] == "common-test" }
        assert_equal("UDP", mainContainer["ports"].first["protocol"])
      end

      it 'No annotations get set by default' do
        values = baseValues
        chart.value values

        service = chart.resources(kind: "Service").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(service)
        assert_nil(service["metadata"]["annotations"])
      end

      it 'TCP port protocol does not set annotations' do
        values = baseValues.deep_merge_override({
          service: {
            main: {
              ports: {
                main: {
                  protocol: 'TCP'
                }
              }
            }
          }
        })
        chart.value values

        service = chart.resources(kind: "Service").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(service)
        assert_nil(service["metadata"]["annotations"])
      end

      it 'HTTPS port protocol sets traefik HTTPS annotation' do
        values = baseValues.deep_merge_override({
          service: {
            main: {
              ports: {
                main: {
                  protocol: 'HTTPS'
                }
              }
            }
          }
        })
        chart.value values
        service = chart.resources(kind: "Service").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(service)
        assert_equal("https", service["metadata"]["annotations"]["traefik.ingress.kubernetes.io/service.serversscheme"])
      end
    end
  end
end
