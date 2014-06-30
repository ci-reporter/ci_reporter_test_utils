require 'ci/reporter/test_utils'

module CI::Reporter::TestUtils
  module Rake
    def run_ruby_acceptance(cmd)
      ENV['CI_REPORTS'] ||= "acceptance/reports"
      if ENV['RUBYOPT']
        opts = ENV['RUBYOPT']
        ENV['RUBYOPT'] = nil
      else
        opts = "-rubygems"
      end
      begin
        result_proc = proc {|ok,*| puts "Failures above are expected." unless ok }
        ruby "-Ilib #{opts} #{cmd}", &result_proc
      ensure
        ENV['RUBYOPT'] = opts if opts != "-rubygems"
        ENV.delete 'CI_REPORTS'
      end
    end
  end
end
