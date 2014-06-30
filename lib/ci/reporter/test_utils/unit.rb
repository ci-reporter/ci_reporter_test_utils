require 'ci/reporter/test_utils'

module CI::Reporter::TestUtils
  module Unit
    def save_env(v)
      ENV["PREV_#{v}"] = ENV[v]
    end

    def restore_env(v)
      ENV[v] = ENV["PREV_#{v}"]
      ENV.delete("PREV_#{v}")
    end
  end
end
