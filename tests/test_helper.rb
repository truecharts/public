# frozen_string_literal: true

require 'json'
require 'yaml'
require 'open3'

require 'minitest-implicit-subject'
require "minitest/reporters"
require 'minitest/autorun'
require 'minitest/pride'

class HelmCompileError < StandardError
end

class HelmDepsError < StandardError
end

class Chart
  attr_reader :name, :path, :values

  def initialize(chart)
    @name = chart.split('/').last

    @path = File.expand_path(chart)

    @values = default_values

    update_deps!
  end

  def update_deps!
    command = "helm dep update '#{path}'"
    stdout, stderr, status = Open3.capture3(command)
    raise HelmDepsError, stderr if status != 0
  end

  def reset!
    @values = default_values
    @parsed_resources = nil
  end

  def value(value)
    values.merge!(value)
  end

  def configure_custom_name(name)
    @name = name
  end

  def execute_helm_template!
    file = Tempfile.new(name)
    file.write(JSON.parse(values.to_json).to_yaml)
    file.close

    begin
      command = "helm template '#{name}' '#{path}' --namespace='default' --values='#{file.path}'"
      stdout, stderr, status = Open3.capture3(command)

      raise HelmCompileError, stderr if status != 0

      stdout
    ensure
      file.unlink
    end
  end

  def parsed_resources
    @parsed_resources ||= begin
      output = execute_helm_template!
      puts output if ENV.fetch('DEBUG', 'false') == 'true'
      YAML.load_stream(output)
    end
  end

  def resources(matcher = nil)
    return parsed_resources unless matcher

    parsed_resources.select do |r|
      r >= Hash[matcher.map { |k, v| [k.to_s, v] }]
    end
  end

  def default_values
    {
    }
  end
end

class ExtendedMinitest < Minitest::Test
  extend MiniTest::Spec::DSL
end

class ChartTest < ExtendedMinitest
  Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

  before do
    chart.reset!
  end

  def chart
    self.class.class_variable_get('@@chart')
  end

  def resource(name)
    chart.resources(kind: name).first
  end
end

class Minitest::Result
  def name
    test_name = defined?(@name) ? @name : super
    test_name.to_s.gsub /\Atest_\d{4,}_/, ""
  end
end

class ::Hash
  def deep_merge_override(second)
    merger = proc do |key, original, override|
      if original.instance_of?(Hash) && override.instance_of?(Hash)
        original.merge(override, &merger)
      else
        if original.instance_of?(Array) && override.instance_of?(Array)
          # if the lengths are different, prefer the override
          if original.length != override.length
            override
          else
            # if the first element in the override's Array is a Hash, then we assume they all are
            if override[0].instance_of?(Hash)
              original.map.with_index do |v, i|
                # deep merge everything between the two arrays
                original[i].merge(override[i], &merger)
              end
            else
              # if we don't have a Hash in the override,
              # override the whole array with our new one
              override
            end
          end
        else
          override
        end
      end
    end
    self.merge(second.to_h, &merger)
  end
end
