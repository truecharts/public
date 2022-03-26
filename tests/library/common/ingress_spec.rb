# frozen_string_literal: true
require_relative '../../test_helper'

class Test < ChartTest
  @@chart = Chart.new('charts/library/common-test')

  describe @@chart.name do
    describe 'ingress' do
      baseValues = {
        ingress: {
          main: {
            enabled: true
          }
        },
        service: {
          main: {
            ports: {
              http: {
                port: 8080
              }
            }
          }
        }
      }

      it 'disabled when ingress.main.enabled: false' do
        values = baseValues.deep_merge_override({
          ingress: {
            main: {
              enabled: false
            }
          }
        })
        chart.value values

        assert_nil(resource('Ingress'))
      end

      it 'enabled when ingress.main.enabled: true' do
        values = baseValues
        chart.value values

        refute_nil(resource('Ingress'))
      end

      it 'tls can be provided' do
        expectedPath = 'common-test.path'
        values = baseValues.deep_merge_override({
          ingress: {
            main: {
              tls: [
                {
                  hosts: [ 'hostname' ],
                  secretName: 'secret-name'
                }
              ]
            }
          }
        })
        chart.value values

        ingress = chart.resources(kind: "Ingress").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(ingress)
        assert_equal(values[:ingress][:main][:tls][0][:hosts][0], ingress["spec"]["tls"][0]["hosts"][0])
        assert_equal(values[:ingress][:main][:tls][0][:secretName], ingress["spec"]["tls"][0]["secretName"])
      end

      it 'tls secret can be left empty' do
        expectedPath = 'common-test.path'
        values = baseValues.deep_merge_override({
          ingress: {
            main:{
              tls: [
                {
                  hosts: [ 'hostname' ]
                }
              ]
            }
          }
        })
        chart.value values

        ingress = chart.resources(kind: "Ingress").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(ingress)
        assert_equal(values[:ingress][:main][:tls][0][:hosts][0], ingress["spec"]["tls"][0]["hosts"][0])
        assert_equal(false, ingress["spec"]["tls"][0].key?("secretName"))
        assert_nil(ingress["spec"]["tls"][0]["secretName"])
      end

      it 'tls secret template can be provided' do
        expectedPath = 'common-test.path'
        values = baseValues.deep_merge_override({
          ingress: {
            main: {
              tls: [
                {
                  secretName: '{{ .Release.Name }}-secret'
                }
              ]
            }
          }
        })
        chart.value values

        ingress = chart.resources(kind: "Ingress").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(ingress)
        assert_equal('common-test-secret', ingress["spec"]["tls"][0]["secretName"])
      end

      it 'path template can be provided' do
        expectedPath = 'common-test.path'
        values = baseValues.deep_merge_override({
          ingress: {
            main: {
              hosts: [
                {
                  host: 'test.local',
                  paths: [
                    {
                      path: '{{ .Release.Name }}.path'
                    }
                  ]
                }
              ]
            }
          }
        })
        chart.value values

        ingress = chart.resources(kind: "Ingress").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(ingress)
        assert_equal(expectedPath, ingress["spec"]["rules"][0]["http"]["paths"][0]["path"])
      end

      it 'hosts can be provided' do
        values = baseValues.deep_merge_override({
          ingress: {
            main: {
              hosts: [
                {
                  host: 'hostname',
                  paths: [
                    {
                      path: "/"
                    }
                  ]
                }
              ]
            }
          }
        })
        chart.value values

        ingress = chart.resources(kind: "Ingress").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(ingress)
        assert_equal(values[:ingress][:main][:hosts][0][:host], ingress["spec"]["rules"][0]["host"])
      end

      it 'hosts template can be provided' do
        expectedHostName = 'common-test.hostname'
        values = baseValues.deep_merge_override({
          ingress: {
            main: {
              hosts: [
                {
                  host: '{{ .Release.Name }}.hostname',
                  paths: [
                    {
                      path: "/"
                    }
                  ]
                }
              ]
            }
          }
        })
        chart.value values

        ingress = chart.resources(kind: "Ingress").find{ |s| s["metadata"]["name"] == "common-test" }
        refute_nil(ingress)
        assert_equal(expectedHostName, ingress["spec"]["rules"][0]["host"])
      end

      it 'custom service name / port can optionally be set on path level' do
        values = baseValues.deep_merge_override({
          ingress: {
            main: {
              hosts: [
                {
                  host: 'test.local',
                  paths: [
                    {
                      path: '/'
                    },
                    {
                      path: '/second',
                      service: {
                        name: 'pathService',
                        port: 1234
                      }
                    }
                  ]
                }
              ]
            }
          }
        })
        chart.value values

        ingress = chart.resources(kind: "Ingress").find{ |s| s["metadata"]["name"] == "common-test" }
        firstPath = ingress["spec"]["rules"][0]["http"]["paths"][0]
        secondPath = ingress["spec"]["rules"][0]["http"]["paths"][1]
        assert_equal("common-test", firstPath["backend"]["service"]["name"])
        assert_equal(8080, firstPath["backend"]["service"]["port"]["number"])
        assert_equal("pathService", secondPath["backend"]["service"]["name"])
        assert_equal(1234, secondPath["backend"]["service"]["port"]["number"])
      end

      it 'multiple ingress objects can be specified' do
        values = baseValues.deep_merge_override({
          ingress: {
            main: {
              enabled: true,
              primary: true
            },
            secondary: {
              enabled: true
            }
          }
        })
        chart.value values

        ingressMain = chart.resources(kind: "Ingress").find{ |s| s["metadata"]["name"] == "common-test" }
        ingressExtra = chart.resources(kind: "Ingress").find{ |s| s["metadata"]["name"] == "common-test-secondary" }
        refute_nil(ingressMain)
        refute_nil(ingressExtra)
      end
    end
  end
end
