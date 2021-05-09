# frozen_string_literal: true
require_relative '../../test_helper'

class Test < ChartTest
  @@chart = Chart.new('charts/library/common-test')

  describe @@chart.name do
    describe 'job::permissions' do
      it 'no job exists by default' do
        job = chart.resources(kind: "Job").first
        assert_nil(job)
      end

      it 'hostPathMounts do not affect permissions job by default' do
        values = {
          hostPathMounts: [
          {
                name: "data",
                enabled: true,
                mountPath: "/data",
                hostPath: "/tmp"
          }
          ]
        }
        chart.value values
        job = chart.resources(kind: "Job").first
        assert_nil(job["spec"]["template"]["spec"]["volumes"])
        assert_nil(job["spec"]["template"]["spec"]["containers"][0]["volumeMounts"])
      end
      it 'hostPathMounts.setPermissions adds volume(mounts)' do
        values = {
          hostPathMounts: [
          {
                name: "data",
                enabled: true,
                setPermissions: true,
                mountPath: "/data",
                hostPath: "/tmp"
          }
          ]
        }
        chart.value values
        job = chart.resources(kind: "Job").first
        assert_equal("hostpathmounts-data", job["spec"]["template"]["spec"]["volumes"][0]["name"])
        assert_equal("hostpathmounts-data", job["spec"]["template"]["spec"]["containers"][0]["volumeMounts"][0]["name"])
      end
      it 'supports multiple hostPathMounts' do
        values = {
          hostPathMounts: [
          {
                name: "data",
                enabled: true,
                setPermissions: true,
                mountPath: "/data",
                hostPath: "/tmp"
          },
          {
                name: "config",
                enabled: true,
                setPermissions: true,
                mountPath: "/config",
                hostPath: "/tmp"
          }
          ]
        }
        chart.value values
        job = chart.resources(kind: "Job").first
        mainContainer = job["spec"]["template"]["spec"]["containers"][0]

        # Check that all hostPathMounts volumes have mounts
        values[:hostPathMounts].each { |value|
          volumeMount = mainContainer["volumeMounts"].find{ |v| v["name"] == "hostpathmounts-" + value[:name].to_s }
          refute_nil(volumeMount)
        }
      end

      it 'supports setting mountPath' do
        values = {
          hostPathMounts: [
          {
                name: "data",
                enabled: true,
                setPermissions: true,
                mountPath: "/data",
                hostPath: "/tmp"
          }
          ]
        }
        chart.value values
        job = chart.resources(kind: "Job").first
        mainContainer = job["spec"]["template"]["spec"]["containers"][0]

        volumeMount = mainContainer["volumeMounts"].find{ |v| v["name"] == "hostpathmounts-data" }
        refute_nil(volumeMount)
        assert_equal("/data", volumeMount["mountPath"])
      end

      it 'could mount multiple volumes' do
        values = {
          hostPathMounts: [
          {
                name: "data",
                enabled: true,
                setPermissions: true,
                mountPath: "/data",
                hostPath: "/tmp1"
          },
          {
                name: "config",
                enabled: true,
                setPermissions: true,
                mountPath: "/config",
                hostPath: "/tmp2"
          }
          ]
        }
        chart.value values
        job = chart.resources(kind: "Job").first
        volumes = job["spec"]["template"]["spec"]["volumes"]

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
                setPermissions: true,
                emptyDir: true,
                mountPath: "/data"
          }
          ]
        }
        chart.value values
        job = chart.resources(kind: "Job").first
        volumes = job["spec"]["template"]["spec"]["volumes"]
        volume = volumes.find{ |v| v["name"] == "hostpathmounts-data"}
        refute_nil(volume)
        assert_equal(Hash.new, volume["emptyDir"])
      end

      it 'can process default (568:568) permissions for multiple volumes' do
        results= {
          command: ["/bin/sh", "-c", "chown -R 568:568 /data
chown -R 568:568 /config
"]
        }
        values = {
          hostPathMounts: [
          {
                name: "data",
                enabled: true,
                setPermissions: true,
                mountPath: "/data",
                hostPath: "/tmp1"
          },
          {
                name: "config",
                enabled: true,
                setPermissions: true,
                mountPath: "/config",
                hostPath: "/tmp2"
          }
          ]
        }
        chart.value values
        job = chart.resources(kind: "Job").first
        mainContainer = job["spec"]["template"]["spec"]["containers"][0]
        assert_equal(results[:command], mainContainer["command"])
      end

      it 'outputs default permissions with irrelevant podSecurityContext' do
        results= {
          command: ["/bin/sh", "-c", "chown -R 568:568 /data
chown -R 568:568 /config
"]
        }
        values = {
          podSecurityContext: {
            allowPrivilegeEscalation: false
          },
          hostPathMounts: [
          {
                name: "data",
                enabled: true,
                setPermissions: true,
                mountPath: "/data",
                hostPath: "/tmp1"
          },
          {
                name: "config",
                enabled: true,
                setPermissions: true,
                mountPath: "/config",
                hostPath: "/tmp2"
          }
          ]
        }
        chart.value values
        job = chart.resources(kind: "Job").first
        mainContainer = job["spec"]["template"]["spec"]["containers"][0]
        assert_equal(results[:command], mainContainer["command"])
      end

      it 'outputs fsgroup permissions for multiple volumes when set' do
        results= {
          command: ["/bin/sh", "-c", "chown -R 568:666 /data
chown -R 568:666 /config
"]
        }
        values = {
          podSecurityContext: {
            fsGroup: 666
          },
          hostPathMounts: [
          {
                name: "data",
                enabled: true,
                setPermissions: true,
                mountPath: "/data",
                hostPath: "/tmp1"
          },
          {
                name: "config",
                enabled: true,
                setPermissions: true,
                mountPath: "/config",
                hostPath: "/tmp2"
          }
          ]
        }
        chart.value values
        job = chart.resources(kind: "Job").first
        mainContainer = job["spec"]["template"]["spec"]["containers"][0]
        assert_equal(results[:command], mainContainer["command"])
      end

      it 'outputs runAsUser permissions for multiple volumes when set' do
        results= {
          command: ["/bin/sh", "-c", "chown -R 999:568 /data
chown -R 999:568 /config
"]
        }
        values = {
          podSecurityContext: {
            runAsUser: 999
          },
          hostPathMounts: [
          {
                name: "data",
                enabled: true,
                setPermissions: true,
                mountPath: "/data",
                hostPath: "/tmp1"
          },
          {
                name: "config",
                enabled: true,
                setPermissions: true,
                mountPath: "/config",
                hostPath: "/tmp2"
          }
          ]
        }
        chart.value values
        job = chart.resources(kind: "Job").first
        mainContainer = job["spec"]["template"]["spec"]["containers"][0]
        assert_equal(results[:command], mainContainer["command"])
      end

      it 'outputs fsGroup AND runAsUser permissions for multiple volumes when both are set' do
        results= {
          command: ["/bin/sh", "-c", "chown -R 999:666 /data
chown -R 999:666 /config
"]
        }
        values = {
          podSecurityContext: {
            fsGroup: 666,
            runAsUser: 999
          },
          hostPathMounts: [
          {
                name: "data",
                enabled: true,
                setPermissions: true,
                mountPath: "/data",
                hostPath: "/tmp1"
          },
          {
                name: "config",
                enabled: true,
                setPermissions: true,
                mountPath: "/config",
                hostPath: "/tmp2"
          }
          ]
        }
        chart.value values
        job = chart.resources(kind: "Job").first
        mainContainer = job["spec"]["template"]["spec"]["containers"][0]
        assert_equal(results[:command], mainContainer["command"])
      end
      it 'outputs PUID AND PGID permissions for multiple volumes when both are set' do
        results= {
          command: ["/bin/sh", "-c", "chown -R 999:666 /data
chown -R 999:666 /config
"]
        }
        values = {
          env: {
            PGID: 666,
            PUID: 999
          },
          hostPathMounts: [
          {
                name: "data",
                enabled: true,
                setPermissions: true,
                mountPath: "/data",
                hostPath: "/tmp1"
          },
          {
                name: "config",
                enabled: true,
                setPermissions: true,
                mountPath: "/config",
                hostPath: "/tmp2"
          }
          ]
        }
        chart.value values
        job = chart.resources(kind: "Job").first
        mainContainer = job["spec"]["template"]["spec"]["containers"][0]
        assert_equal(results[:command], mainContainer["command"])
      end
    end
  end
end
