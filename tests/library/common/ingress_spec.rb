# frozen_string_literal: true
require_relative '../../test_helper'

class Test < ChartTest
  @@chart = Chart.new('charts/library/common-test')

  describe @@chart.name do
    describe 'ingress' do
      it 'disabled when ingress.enabled: false' do
        values = {
          ingress: {
            enabled: false
          }
        }
        chart.value values
        assert_nil(resource('Ingress'))
      end

      it 'enabled when ingress.enabled: true' do
        values = {
          ingress: {
            enabled: true
          }
        }

        chart.value values
        refute_nil(resource('Ingress'))
      end

      it 'tls can be provided' do
        expectedPath = 'common-test.path'
        values = {
          ingress: {
            tls: [
              {
                hosts: [ 'hostname' ],
                secretName: 'secret-name'
              }
            ]
          }
        }

        chart.value values
        ingress = chart.resources(kind: "Ingress").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(ingress)
        assert_equal(values[:ingress][:tls][0][:hosts][0], ingress["spec"]["tls"][0]["hosts"][0])
        assert_equal(values[:ingress][:tls][0][:secretName], ingress["spec"]["tls"][0]["secretName"])
      end

      it 'tls secret can be left empty' do
        expectedPath = 'common-test.path'
        values = {
          ingress: {
            tls: [
              {
                hosts: [ 'hostname' ]
              }
            ]
          }
        }

        chart.value values
        ingress = chart.resources(kind: "Ingress").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(ingress)
        assert_equal(values[:ingress][:tls][0][:hosts][0], ingress["spec"]["tls"][0]["hosts"][0])
        assert_equal(false, ingress["spec"]["tls"][0].key?("secretName"))
        assert_nil(ingress["spec"]["tls"][0]["secretName"])
      end

      it 'tls secret template can be provided' do
        expectedPath = 'common-test.path'
        values = {
          ingress: {
            tls: [
              {
                secretNameTpl: '{{ .Release.Name }}-secret'
              }
            ]
          }
        }

        chart.value values
        ingress = chart.resources(kind: "Ingress").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(ingress)
        assert_equal('common-test-secret', ingress["spec"]["tls"][0]["secretName"])
      end

      it 'path template can be provided' do
        expectedPath = 'common-test.path'
        values = {
          ingress: {
            hosts: [
              {
                paths: [
                  {
                    pathTpl: '{{ .Release.Name }}.path'
                  }
                ]
              }
            ]
          }
        }

        chart.value values
        ingress = chart.resources(kind: "Ingress").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(ingress)
        assert_equal(expectedPath, ingress["spec"]["rules"][0]["http"]["paths"][0]["path"])
      end

      it 'hosts can be provided' do
        values = {
          ingress: {
            hosts: [
              {
                host: 'hostname'
              }
            ]
          }
        }

        chart.value values
        ingress = chart.resources(kind: "Ingress").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(ingress)
        assert_equal(values[:ingress][:hosts][0][:host], ingress["spec"]["rules"][0]["host"])
      end

      it 'hosts template can be provided' do
        expectedHostName = 'common-test.hostname'
        values = {
          ingress: {
            hosts: [
              {
                hostTpl: '{{ .Release.Name }}.hostname'
              }
            ]
          }
        }

        chart.value values
        ingress = chart.resources(kind: "Ingress").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(ingress)
        assert_equal(expectedHostName, ingress["spec"]["rules"][0]["host"])
      end

      it 'custom service name / port can optionally be set on path level' do
        values = {
          ingress: {
            enabled: true,
            hosts: [
              {
                paths: [
                  {
                    path: '/'
                  },
                  {
                    path: '/second',
                    serviceName: 'pathService',
                    servicePort: 1234
                  }
                ]
              }
            ]
          }
        }

        chart.value values
        ingress = chart.resources(kind: "Ingress").find{ |s| s["metadata"]["name"] == "common-test" }
        firstPath = ingress["spec"]["rules"][0]["http"]["paths"][0]
        secondPath = ingress["spec"]["rules"][0]["http"]["paths"][1]
        assert_equal("common-test", firstPath["backend"]["service"]["name"])
        assert_equal(8080, firstPath["backend"]["service"]["port"]["number"])
        assert_equal("pathService", secondPath["backend"]["service"]["name"])
        assert_equal(1234, secondPath["backend"]["service"]["port"]["number"])
      end
    end

    describe 'additionalIngress' do
      ingressValues = {
        ingress: {
          enabled: true,
          additionalIngresses: [
            {
              enabled: true,
              nameSuffix: "extra",
              hosts: [
                {
                  paths: [
                    {
                      path: '/'
                    }
                  ]
                }
              ]
            }
          ]
        }
      }

      it 'can be specified' do
        values = ingressValues
        chart.value values
        additionalIngress = chart.resources(kind: "Ingress").find{ |s| s["metadata"]["name"] == "common-test-extra" }
        refute_nil(additionalIngress)
      end

      it 'refers to main Service by default' do
        values = ingressValues
        chart.value values
        additionalIngress = chart.resources(kind: "Ingress").find{ |s| s["metadata"]["name"] == "common-test-extra" }
        assert_equal("common-test", additionalIngress["spec"]["rules"][0]["http"]["paths"][0]["backend"]["service"]["name"])
        assert_equal(8080, additionalIngress["spec"]["rules"][0]["http"]["paths"][0]["backend"]["service"]["port"]["number"])
      end

      it 'custom service name / port can be set on Ingress level' do
        values = ingressValues.deep_merge_override({
          ingress: {
            additionalIngresses: [
              {
                serviceName: "customService",
                servicePort: 8081
              }
            ]
          }
        })
        chart.value values
        additionalIngress = chart.resources(kind: "Ingress").find{ |s| s["metadata"]["name"] == "common-test-extra" }
        assert_equal("customService", additionalIngress["spec"]["rules"][0]["http"]["paths"][0]["backend"]["service"]["name"])
        assert_equal(8081, additionalIngress["spec"]["rules"][0]["http"]["paths"][0]["backend"]["service"]["port"]["number"])
      end

      it 'custom service name / port can optionally be set on path level' do
        values = ingressValues.deep_merge_override({
          ingress: {
            additionalIngresses: [
              {
                hosts: [
                  {
                    paths: [
                      {
                        path: '/'
                      },
                      {
                        path: '/second',
                        serviceName: 'pathService',
                        servicePort: 1234
                      }
                    ]
                  }
                ]
              }
            ]
          }
        })
        chart.value values
        additionalIngress = chart.resources(kind: "Ingress").find{ |s| s["metadata"]["name"] == "common-test-extra" }
        firstPath = additionalIngress["spec"]["rules"][0]["http"]["paths"][0]
        secondPath = additionalIngress["spec"]["rules"][0]["http"]["paths"][1]
        assert_equal("common-test", firstPath["backend"]["service"]["name"])
        assert_equal(8080, firstPath["backend"]["service"]["port"]["number"])
        assert_equal("pathService", secondPath["backend"]["service"]["name"])
        assert_equal(1234, secondPath["backend"]["service"]["port"]["number"])
      end
    end
  end
end
