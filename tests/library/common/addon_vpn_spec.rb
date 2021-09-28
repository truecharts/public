# frozen_string_literal: true
require_relative '../../test_helper'

class Test < ChartTest
  @@chart = Chart.new('charts/library/common-test')

  describe @@chart.name do
    describe 'addon::vpn' do
      it 'defaults to disabled' do
        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        openvpnContainer = containers.find{ |c| c["name"] == "openvpn" }
        wireguardContainer = containers.find{ |c| c["name"] == "wireguard" }

        assert_nil(openvpnContainer)
        assert_nil(wireguardContainer)
      end

      it 'openvpn can be enabled' do
        values = {
        addons: {
          vpn: {
            type: "openvpn"
          }
        }
      }

        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        vpnContainer = containers.find{ |c| c["name"] == "openvpn" }

        refute_nil(vpnContainer)
      end

      it 'wireguard can be enabled' do
        values = {
        addons: {
          vpn: {
            type: "wireguard"
          }
        }
      }

        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        wireguardContainer = containers.find{ |c| c["name"] == "wireguard" }

        refute_nil(wireguardContainer)
      end

      it 'a openvpn configuration file can be passed' do
        values = {
          addons: {
            vpn: {
              type: "openvpn",
              configFile: {
                enabled: true,
                hostPath: "/test.conf"
              }
            }
          }
        }

        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        secret = chart.resources(kind: "Secret").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        volumes = deployment["spec"]["template"]["spec"]["volumes"]
        vpnContainer = containers.find{ |c| c["name"] == "openvpn" }

        # Make sure the deployKey volumeMount is present in the sidecar container
        vpnconfigVolumeMount = vpnContainer["volumeMounts"].find { |v| v["name"] == "vpnconfig"}
        refute_nil(vpnconfigVolumeMount)
        assert_equal("/vpn/vpn.conf", vpnconfigVolumeMount["mountPath"])
      end

      it 'a wireguard configuration file can be passed' do
        values = {
          addons: {
            vpn: {
              type: "wireguard",
              configFile: {
                enabled: true,
                hostPath: "/test.conf"
              }
            }
          }
        }

        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        secret = chart.resources(kind: "Secret").first
        containers = deployment["spec"]["template"]["spec"]["containers"]
        volumes = deployment["spec"]["template"]["spec"]["volumes"]
        vpnContainer = containers.find{ |c| c["name"] == "wireguard" }

        # Make sure the deployKey volumeMount is present in the sidecar container
        vpnconfigVolumeMount = vpnContainer["volumeMounts"].find { |v| v["name"] == "vpnconfig"}
        refute_nil(vpnconfigVolumeMount)
        assert_equal("/etc/wireguard/wg0.conf", vpnconfigVolumeMount["mountPath"])
      end
    end
  end
end
