# frozen_string_literal: true
require_relative '../../test_helper'

class Test < ChartTest
  @@chart = Chart.new('charts/library/common-test')

  describe @@chart.name do
    describe 'service::ports settings' do
      default_name = 'main'
      default_port = 8080

      it 'defaults to name "servicename" on port 8080' do
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

      it 'port name can be overridden' do
        values = {
          services: {
            main: {
              port: {
                name: "server",
              },
            },
          },
        }
        chart.value values
        service = chart.resources(kind: "Service").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(service)
        assert_equal(default_port, service["spec"]["ports"].first["port"])
        assert_equal(values[:services][:main][:port][:name], service["spec"]["ports"].first["targetPort"])
        assert_equal(values[:services][:main][:port][:name], service["spec"]["ports"].first["name"])

        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        mainContainer = containers.find{ |c| c["name"] == "common-test" }
        assert_equal(default_port, mainContainer["ports"].first["containerPort"])
        assert_equal(values[:services][:main][:port][:name], mainContainer["ports"].first["name"])
      end

      it 'targetPort can be overridden' do
        values = {
          services: {
            main: {
              port: {
                targetPort: 80,
              },
            },
          },
        }
        chart.value values
        service = chart.resources(kind: "Service").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(service)
        assert_equal(default_port, service["spec"]["ports"].first["port"])
        assert_equal(values[:services][:main][:port][:targetPort], service["spec"]["ports"].first["targetPort"])
        assert_equal(default_name, service["spec"]["ports"].first["name"])

        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        mainContainer = containers.find{ |c| c["name"] == "common-test" }
        assert_equal(values[:services][:main][:port][:targetPort], mainContainer["ports"].first["containerPort"])
        assert_equal(default_name, mainContainer["ports"].first["name"])
      end

      it 'targetPort cannot be a named port' do
        values = {
          services: {
            main: {
              port: {
                targetPort: "test",
              },
            },
          },
        }
        chart.value values
        exception = assert_raises HelmCompileError do
          chart.execute_helm_template!
        end
        assert_match("Our charts do not support named ports for targetPort. (port name #{default_name}, targetPort #{values[:services][:main][:port][:targetPort]})", exception.message)
      end

      it 'protocol defaults to TCP' do
        service = chart.resources(kind: "Service").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(service)
        assert_equal("TCP", service["spec"]["ports"].first["protocol"])

        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        mainContainer = containers.find{ |c| c["name"] == "common-test" }
        assert_equal("TCP", mainContainer["ports"].first["protocol"])
      end

      it 'protocol is TCP when set to TCP explicitly' do
        values = {
          services: {
            main: {
              port: {
                protocol: "TCP",
              },
            },
          },
        }
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
        values = {
          services: {
            main: {
              port: {
                protocol: "HTTP",
              },
            },
          },
        }
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
        values = {
          services: {
            main: {
              port: {
                protocol: "HTTPS",
              },
            },
          },
        }
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
        values = {
          services: {
            main: {
              port: {
                protocol: "UDP",
              },
            },
          },
        }
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
        service = chart.resources(kind: "Service").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(service)
        assert_nil(service["metadata"]["annotations"])
      end
      it 'TCP port protocol does not set annotations' do
        values = {
          services: {
            main: {
              port: {
                protocol: 'TCP'
              }
            }
          }
        }
        chart.value values
        service = chart.resources(kind: "Service").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(service)
        assert_nil(service["metadata"]["annotations"])
      end
      it 'HTTPS port protocol sets traefik HTTPS annotation' do
        values = {
          services: {
            main: {
              port: {
                protocol: 'HTTPS'
              }
            }
          }
        }
        chart.value values
        service = chart.resources(kind: "Service").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(service)
        assert_equal("https", service["metadata"]["annotations"]["traefik.ingress.kubernetes.io/service.serversscheme"])
      end
    end
  end
end
