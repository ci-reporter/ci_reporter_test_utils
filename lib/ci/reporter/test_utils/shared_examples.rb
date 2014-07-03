require 'ci/reporter/test_utils'

module CI::Reporter::TestUtils
  module SharedExamples
    shared_examples "nothing was output" do
      describe "stdout" do
        subject { result.system_out }
        it { should be_empty }
      end

      describe "stderr" do
        subject { result.system_err }
        it { should be_empty }
      end
    end

    shared_examples "a report with consistent attribute counts" do
      describe "the failure count" do
        subject { result.failures_count }
        it { should eql result.failures.count }
      end

      describe "the error count" do
        subject { result.errors_count }
        it { should eql result.errors.count }
      end

      describe "the test count" do
        subject { result.tests_count }
        it { should eql result.testcases.count }
      end
    end

    shared_examples "assertions are not tracked" do
      describe "the assertion count" do
        subject { result.assertions_count }
        it { should eql 0 }
      end
    end
  end
end
