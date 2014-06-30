require 'ci/reporter/test_utils'

module CI::Reporter::TestUtils
  class Accessor
    attr_reader :root

    def initialize(xml)
      @root = xml.root
    end

    def failures
      root.elements.to_a("/testsuite/testcase/failure")
    end

    def errors
      root.elements.to_a("/testsuite/testcase/error")
    end

    def testcases
      root.elements.to_a("/testsuite/testcase")
    end

    [:failures, :errors, :skipped, :assertions, :tests].each do |attr|
      define_method "#{attr}_count" do
        root.attributes[attr.to_s].to_i
      end
    end

    def system_out
      all_text_nodes_as_string("/testsuite/system-out")
    end

    def system_err
      all_text_nodes_as_string("/testsuite/system-err")
    end

    private

    def all_text_nodes_as_string(xpath)
      root.elements.to_a(xpath).map(&:texts).flatten.map(&:value).join.strip
    end
  end
end
