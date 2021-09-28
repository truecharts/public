# frozen_string_literal: true
require_relative '../../test_helper'

class Test < ChartTest
  @@chart = Chart.new('charts/library/common-test')

  describe @@chart.name do
    describe 'initContainer::permissions' do
      it 'initContainer exists by default' do
        deployment = chart.resources(kind: "Deployment").first
        initContainer = deployment["spec"]["template"]["spec"]["initContainers"][0]
        refute_nil(initContainer)
      end

      it 'persistenceList do not affect permissions job by default' do
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
        assert_nil(deployment["spec"]["template"]["spec"]["initContainers"][0]["volumeMounts"])
      end
      it 'persistenceList.setPermissions adds volume(mounts)' do
        values = {
          persistenceList: [
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
        deployment = chart.resources(kind: "Deployment").first
        assert_equal("data", deployment["spec"]["template"]["spec"]["volumes"][0]["name"])
        assert_equal("data", deployment["spec"]["template"]["spec"]["initContainers"][0]["volumeMounts"][0]["name"])
      end
      it 'supports multiple persistenceList' do
        values = {
          persistenceList: [
          {
                name: "data",
                enabled: true,
                setPermissions: true,
                mountPath: "/data",
                hostPath: "/tmp"
          },
          {
                name: "configlist",
                enabled: true,
                setPermissions: true,
                mountPath: "/configlist",
                hostPath: "/tmp"
          }
          ]
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        initContainer = deployment["spec"]["template"]["spec"]["initContainers"][0]

        # Check that all persistenceList volumes have mounts
        values[:persistenceList].each { |value|
          volumeMount = initContainer["volumeMounts"].find{ |v| v["name"] == "" + value[:name].to_s }
          refute_nil(volumeMount)
        }
      end

      it 'supports setting mountPath' do
        values = {
          persistenceList: [
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
        deployment = chart.resources(kind: "Deployment").first
        initContainer = deployment["spec"]["template"]["spec"]["initContainers"][0]

        volumeMount = initContainer["volumeMounts"].find{ |v| v["name"] == "data" }
        refute_nil(volumeMount)
        assert_equal("/data", volumeMount["mountPath"])
      end

      it 'could mount multiple volumes' do
        values = {
          persistenceList: [
          {
                name: "data",
                enabled: true,
                type: "hostPath",
                setPermissions: true,
                mountPath: "/data",
                hostPath: "/tmp1"
          },
          {
                name: "configlist",
                enabled: true,
                type: "hostPath",
                setPermissions: true,
                mountPath: "/configlist",
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

      it 'can process default (568:568) permissions for multiple volumes' do
        results= {
          command: ["/bin/sh", "-c", "echo 'Automatically correcting permissions...';chown -R :568 '/configlist'; chmod -R g+w '/configlist';chown -R :568 '/data'; chmod -R g+w '/data';"]
        }
        values = {
          persistenceList: [
          {
                name: "data",
                enabled: true,
                type: "hostPath",
                setPermissions: true,
                mountPath: "/data",
                hostPath: "/tmp1"
          },
          {
                name: "configlist",
                enabled: true,
                type: "hostPath",
                setPermissions: true,
                mountPath: "/configlist",
                hostPath: "/tmp2"
          }
          ]
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        initContainer = deployment["spec"]["template"]["spec"]["initContainers"][0]
        assert_equal(results[:command], initContainer["command"])
      end

      it 'outputs default permissions with irrelevant podSecurityContext' do
        results= {
          command: ["/bin/sh", "-c", "echo 'Automatically correcting permissions...';chown -R :568 '/configlist'; chmod -R g+w '/configlist';chown -R :568 '/data'; chmod -R g+w '/data';"]
        }
        values = {
          podSecurityContext: {
              allowPrivilegeEscalation: false
          },
          persistenceList: [
          {
                name: "data",
                enabled: true,
                setPermissions: true,
                mountPath: "/data",
                hostPath: "/tmp1"
          },
          {
                name: "configlist",
                enabled: true,
                setPermissions: true,
                mountPath: "/configlist",
                hostPath: "/tmp2"
          }
          ]
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        initContainer = deployment["spec"]["template"]["spec"]["initContainers"][0]
        assert_equal(results[:command], initContainer["command"])
      end

      it 'outputs fsgroup permissions for multiple volumes when set' do
        results= {
          command: ["/bin/sh", "-c", "echo 'Automatically correcting permissions...';chown -R :666 '/configlist'; chmod -R g+w '/configlist';chown -R :666 '/data'; chmod -R g+w '/data';"]
        }
        values = {
          podSecurityContext: {
            fsGroup: 666
          },
          persistenceList: [
          {
                name: "data",
                enabled: true,
                setPermissions: true,
                mountPath: "/data",
                hostPath: "/tmp1"
          },
          {
                name: "configlist",
                enabled: true,
                setPermissions: true,
                mountPath: "/configlist",
                hostPath: "/tmp2"
          }
          ]
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        initContainer = deployment["spec"]["template"]["spec"]["initContainers"][0]
        assert_equal(results[:command], initContainer["command"])
      end

      it 'outputs runAsUser permissions for multiple volumes when set' do
        results= {
          command: ["/bin/sh", "-c", "echo 'Automatically correcting permissions...';chown -R :568 '/configlist'; chmod -R g+w '/configlist';chown -R :568 '/data'; chmod -R g+w '/data';"]
        }
        values = {
          podSecurityContext: {
            runAsUser: 999
          },
          persistenceList: [
          {
                name: "data",
                enabled: true,
                setPermissions: true,
                mountPath: "/data",
                hostPath: "/tmp1"
          },
          {
                name: "configlist",
                enabled: true,
                setPermissions: true,
                mountPath: "/configlist",
                hostPath: "/tmp2"
          }
          ]
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        initContainer = deployment["spec"]["template"]["spec"]["initContainers"][0]
        assert_equal(results[:command], initContainer["command"])
      end

      it 'outputs fsGroup AND runAsUser permissions for multiple volumes when both are set' do
        results= {
          command: ["/bin/sh", "-c", "echo 'Automatically correcting permissions...';chown -R :666 '/configlist'; chmod -R g+w '/configlist';chown -R :666 '/data'; chmod -R g+w '/data';"]
        }
        values = {
          podSecurityContext: {
            fsGroup: 666,
            runAsUser: 999
          },
          persistenceList: [
          {
                name: "data",
                enabled: true,
                setPermissions: true,
                mountPath: "/data",
                hostPath: "/tmp1"
          },
          {
                name: "configlist",
                enabled: true,
                setPermissions: true,
                mountPath: "/configlist",
                hostPath: "/tmp2"
          }
          ]
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        initContainer = deployment["spec"]["template"]["spec"]["initContainers"][0]
        assert_equal(results[:command], initContainer["command"])
      end
      it 'outputs PUID AND PGID permissions for multiple volumes when both are set' do
        results= {
          command: ["/bin/sh", "-c", "echo 'Automatically correcting permissions...';chown -R :568 '/configlist'; chmod -R g+w '/configlist';chown -R :568 '/data'; chmod -R g+w '/data';"]
        }
        values = {
          env: {
            PGID: 666,
            PUID: 999
          },
          persistenceList: [
          {
                name: "data",
                enabled: true,
                setPermissions: true,
                mountPath: "/data",
                hostPath: "/tmp1"
          },
          {
                name: "configlist",
                enabled: true,
                setPermissions: true,
                mountPath: "/configlist",
                hostPath: "/tmp2"
          }
          ]
        }
        chart.value values
        deployment = chart.resources(kind: "Deployment").first
        initContainer = deployment["spec"]["template"]["spec"]["initContainers"][0]
        assert_equal(results[:command], initContainer["command"])
      end
    end
  end
end
