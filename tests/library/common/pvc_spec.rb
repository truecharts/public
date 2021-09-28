# frozen_string_literal: true
require_relative '../../test_helper'

class Test < ChartTest
  @@chart = Chart.new('charts/library/common-test')

  describe @@chart.name do
    describe 'pvc' do
      it 'nameSuffix defaults to persistence key' do
        values = {
          persistence: {
            config: {
              enabled: true
            }
          }
        }
        chart.value values
        pvc = chart.resources(kind: "PersistentVolumeClaim").find{ |s| s["metadata"]["name"] == "common-test-config" }
        refute_nil(pvc)
      end

      it 'nameSuffix can be overridden' do
        values = {
          persistence: {
            config: {
              enabled: true,
              nameOverride: 'customSuffix'
            }
          }
        }
        chart.value values
        pvc = chart.resources(kind: "PersistentVolumeClaim").find{ |s| s["metadata"]["name"] == "common-test-customSuffix" }
        refute_nil(pvc)
      end

      it 'nameSuffix can be skipped' do
        values = {
          persistence: {
            config: {
              enabled: true,
              nameOverride: '-'
            }
          }
        }
        chart.value values
        pvc = chart.resources(kind: "PersistentVolumeClaim").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(pvc)
      end

      it 'storageClass can be set' do
        values = {
          persistence: {
            config: {
              enabled: true,
              storageClass: "test"
            }
          }
        }
        chart.value values
        pvc = chart.resources(kind: "PersistentVolumeClaim").find{ |s| s["metadata"]["name"] == "common-test-config" }
        refute_nil(pvc)
        assert_equal('test', pvc["spec"]["storageClassName"])
      end

      it 'can generate TrueNAS SCALE zfs storageClass' do
        values = {
          persistence: {
            config: {
              enabled: true,
              storageClass: "SCALE-ZFS"
            }
          }
        }
        chart.value values
        pvc = chart.resources(kind: "PersistentVolumeClaim").find{ |s| s["metadata"]["name"] == "common-test-config" }
        refute_nil(pvc)
        assert_equal('ix-storage-class-common-test', pvc["spec"]["storageClassName"])
      end

      it 'storageClass can be set to an empty value' do
        values = {
          persistence: {
            config: {
              enabled: true,
              storageClass: "-"
            }
          }
        }
        chart.value values
        pvc = chart.resources(kind: "PersistentVolumeClaim").find{ |s| s["metadata"]["name"] == "common-test-config" }
        refute_nil(pvc)
        assert_equal('', pvc["spec"]["storageClassName"])
      end
    end
  end
end
