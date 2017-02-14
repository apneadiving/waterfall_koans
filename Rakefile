require 'rspec'
require_relative 'spec_helper'

task default: %w[test]

task :test do
  RSpec::Core::Runner.run([
    './wf_path/1_wf_object_spec.rb',
    './wf_path/2_service_spec.rb',
    './wf_path/3_chaining_services_spec.rb',
    '--fail-fast'
  ])
end
