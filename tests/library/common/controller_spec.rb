# frozen_string_literal: true
require_relative '../../test_helper'

class Test < ChartTest
  @@chart = Chart.new('charts/library/common-test')

  describe @@chart.name do
    describe 'controller::type' do
      it 'defaults to "Deployment"' do
        assert_nil(resource('StatefulSet'))
        assert_nil(resource('DaemonSet'))
        refute_nil(resource('Deployment'))
      end

      it 'accepts "statefulset"' do
        chart.value controller: {type: 'statefulset'}
        assert_nil(resource('Deployment'))
        assert_nil(resource('DaemonSet'))
        refute_nil(resource('StatefulSet'))
      end

      it 'accepts "daemonset"' do
        chart.value controller: {type: 'daemonset'}
        assert_nil(resource('Deployment'))
        assert_nil(resource('StatefulSet'))
        refute_nil(resource('DaemonSet'))
      end
    end

    describe 'controller::statefulset::volumeClaimTemplates' do
      it 'volumeClaimTemplates should be empty by default' do
        chart.value controller: {type: 'statefulset'}
        statefulset = chart.resources(kind: "StatefulSet").first
        assert_nil(statefulset['spec']['volumeClaimTemplates'])
      end

      it 'can set values for volumeClaimTemplates' do
        values = {
          controller: {
            type: 'statefulset',
          },
          volumeClaimTemplates: {
            storage: {
              accessMode: 'ReadWriteOnce',
              size: '10Gi',
              storageClass: 'storage'
            }
          }
        }

        chart.value values
        statefulset = chart.resources(kind: "StatefulSet").first
        volumeClaimTemplate = statefulset["spec"]["volumeClaimTemplates"].find{ |c| c["metadata"]["name"] == "storage"}
        refute_nil(volumeClaimTemplate)
        assert_equal(values[:volumeClaimTemplates][:storage][:accessMode], volumeClaimTemplate["spec"]["accessModes"][0])
        assert_equal(values[:volumeClaimTemplates][:storage][:size], volumeClaimTemplate["spec"]["resources"]["requests"]["storage"])
        assert_equal(values[:volumeClaimTemplates][:storage][:storageClass], volumeClaimTemplate["spec"]["storageClassName"])
      end
    end
  end
end
