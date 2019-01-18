require "bundler/setup"
require "rspec-benchmark"

Dir[File.join(__dir__, '../lib', '*.rb')].each { |file| require_relative file }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  # Benchmarks in rpsec
  config.include RSpec::Benchmark::Matchers

  # Skip puts statements from program while running tests
  config.before { allow($stdout).to receive(:puts) }

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end