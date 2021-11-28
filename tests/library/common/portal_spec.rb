# frozen_string_literal: true
require_relative '../../test_helper'

class Test < ChartTest
  @@chart = Chart.new('charts/library/common-test')

  describe @@chart.name do
    describe 'portal::configmap::defaults' do
      it 'no configmap exists by default' do
        configmap = chart.resources(kind: "ConfigMap").first
        assert_nil(configmap)
      end

      it 'creates configmap when enabled' do
        values = {
          portal: {
            enabled: true
          }
        }
        chart.value values
        configmap = chart.resources(kind: "ConfigMap").first
        refute_nil(configmap)
      end

      it 'is named "portal"' do
        values = {
          portal: {
            enabled: true
          }
        }
        chart.value values
        configmap = chart.resources(kind: "ConfigMap").first
        assert_equal("portal", configmap["metadata"]["name"])
      end

      it 'uses "$node_ip" by default' do
        values = {
          portal: {
            enabled: true
          },
          ingress: {
            main: {
              enabled: false
            }
          }
        }
        chart.value values
        configmap = chart.resources(kind: "ConfigMap").first
        assert_equal("$node_ip", configmap["data"]["host"])
      end

      it 'uses port "443" by default' do
        values = {
          portal: {
            enabled: true
          },
          ingress: {
            main: {
              enabled: false
            }
          }
        }
        chart.value values
        configmap = chart.resources(kind: "ConfigMap").first
        assert_equal("443", configmap["data"]["port"])
      end

      it 'uses protocol "http" by default' do
        values = {
          portal: {
            enabled: true
          },
          ingress: {
            main: {
              enabled: false
            }
          }
        }
        chart.value values
        configmap = chart.resources(kind: "ConfigMap").first
        assert_equal("http", configmap["data"]["protocol"])
      end

      it 'uses path "/" by default' do
        values = {
          portal: {
            enabled: true
          },
          ingress: {
            main: {
              enabled: false
            }
          }
        }
        chart.value values
        configmap = chart.resources(kind: "ConfigMap").first
        assert_equal("/", configmap["data"]["path"])
      end
    end

    describe 'portal::configmap::overrides' do
      it 'ingressPort can be overridden' do
        values = {
          portal: {
            enabled: true,
            ingressPort: "666"
          },
          ingress: {
            main: {
              enabled: true
            }
          }
        }
        chart.value values
        configmap = chart.resources(kind: "ConfigMap").first
        assert_equal(values[:portal][:ingressPort], configmap["data"]["port"])
      end

      it 'nodePort Host can be overridden' do
        values = {
          portal: {
            enabled: true,
            host: "test.host"
          },
          ingress: {
            main: {
              enabled: false
            }
          }
        }
        chart.value values
        configmap = chart.resources(kind: "ConfigMap").first
        assert_equal(values[:portal][:host], configmap["data"]["host"])
      end

      it 'path  can be overridden' do
        values = {
          portal: {
            enabled: true,
            path: "/path"
          },
          ingress: {
            main: {
              enabled: false
            }
          }
        }
        chart.value values
        configmap = chart.resources(kind: "ConfigMap").first
        assert_equal(values[:portal][:path], configmap["data"]["path"])
      end
    end

    describe 'portal::configmap::nodeport' do
      it 'nodePort host defaults to "$node_ip"' do
        values = {
          portal: {
            enabled: true
          },
          ingress: {
            main: {
              enabled: false
            }
          },
          service: {
            main: {
              type: "NodePort",
              ports: {
                main: {
                nodePort: 666
                }
              }
            }
          }
        }
        chart.value values
        configmap = chart.resources(kind: "ConfigMap").first
        assert_equal("$node_ip", configmap["data"]["host"])
      end

      it 'nodePort port defaults to the nodePort' do
        values = {
          portal: {
            enabled: true
          },
          service: {
            main: {
              type: "NodePort",
              ports: {
                main: {
                  enabled: true,
                  port: 8080,
                  nodePort: 666
                }
              }
            }
          }
        }
        chart.value values
        configmap = chart.resources(kind: "ConfigMap").first
        assert_equal("666", configmap["data"]["port"])
      end

      it 'uses nodeport port protocol as protocol (HTTPS)' do
        values = {
          portal: {
            enabled: true
          },
          service: {
            main: {
              type: "NodePort",
              ports: {
                main: {
                  enabled: true,
                  port: 8080,
                  nodePort: 666,
                  protocol: "HTTPS"
                }
              }
            }
          }
        }
        chart.value values
        configmap = chart.resources(kind: "ConfigMap").first
        assert_equal("https", configmap["data"]["protocol"])
      end

      it 'uses nodeport port protocol as protocol (HTTP)' do
        values = {
          portal: {
            enabled: true
          },
          service: {
            main: {
              type: "NodePort",
              ports: {
                main: {
                  enabled: true,
                  nodePort: 666,
                  protocol: "HTTP"
                }
              }
            }
          }
        }
        chart.value values
        configmap = chart.resources(kind: "ConfigMap").first
        assert_equal("http", configmap["data"]["protocol"])
      end
    end

    describe 'portal::configmap::ingress' do
      it 'uses ingress host' do
        values = {
          portal: {
            enabled: true
          },
          ingress: {
            main: {
              enabled: true,
              hosts: [
                {
                  host: "test.domain",
                  paths:
                  [
                    {
                      path: "/test"
                    }
                  ]

                }
              ]
            }
          }
        }
        chart.value values
        chart.value values
        configmap = chart.resources(kind: "ConfigMap").first
        assert_equal("test.domain", configmap["data"]["host"])
      end

      it 'uses ingress path' do
        values = {
          portal: {
            enabled: true
          },
          ingress: {
            main: {
              enabled: true,
              hosts: [
                {
                  host: "test.domain",
                  paths:
                  [
                    {
                      path: "/test"
                    }
                  ]

                }
              ]
            }
          }
        }
        chart.value values
        configmap = chart.resources(kind: "ConfigMap").first
        assert_equal("/test", configmap["data"]["path"])
      end
    end
  end
end
