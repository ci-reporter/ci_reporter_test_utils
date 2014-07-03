require 'ci/reporter/test_utils'

module CI::Reporter::TestUtils
  class Accessor
    attr_reader :root

    Failure = Struct.new(:xml) do
      def type
        xml.attributes['type']
      end
    end

    Error = Struct.new(:xml) do
      def type
        xml.attributes['type']
      end
    end

    Testcase = Struct.new(:xml) do
      def name
        xml.attributes['name']
      end

      def failures
        xml.elements.to_a('failure').map {|f| Failure.new(f) }
      end

      def errors
        xml.elements.to_a("error").map {|e| Error.new(e) }
      end
    end

    def initialize(xml)
      @root = xml.root
    end

    def failures
      root.elements.to_a("/testsuite/testcase/failure").map {|f| Failure.new(f) }
    end

    def errors
      root.elements.to_a("/testsuite/testcase/error").map {|e| Error.new(e) }
    end

    def testcases
      root.elements.to_a("/testsuite/testcase").map {|tc| Testcase.new(tc) }
    end

    def testcase(name)
      testcases.select {|tc| tc.name == name }.first
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
