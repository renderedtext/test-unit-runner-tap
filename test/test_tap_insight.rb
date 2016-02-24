# encoding: UTF-8

# TODO: I don't think that `test-unit-runner-tap` should be showing up
# in backtraces, it should be filtered out.

require 'stringio'
require 'test/unit/ui/tap/ext/insight_testrunner'
require 'json'
require 'test/unit'

class TestTapInsight < Test::Unit::TestCase

  def test_failed
    @test_case = Class.new(Test::Unit::TestCase) do
      def test_success
        assert_equal(3, 1 + 2)
      end

      def test_omit
        omit
        assert_equal(3, 1 + 2)
      end

      def test_pend
        pend
        assert_equal(3, 1 + 2)
      end

      def test_fail
        assert_equal(3, 1 - 2)
      end
    end

    io = StringIO.new
    @runner = Test::Unit::UI::Tap::InsightTestRunner.new(@test_case.suite, output: io)
    @result = @runner.start

    assert_false(@result.passed?)
    assert_true(io.string.include?("4 tests, 2 assertions, 1 failures, 0 errors, 1 pendings, 1 omissions, 0 notifications"))

    insight_json_report_path = File.join(File.dirname(__FILE__), '../test_unit_report.json')
    assert_true(File.exist?(insight_json_report_path))

    output = JSON.parse(File.read(insight_json_report_path))
    test_case_results = output.select{|ele| ele["type"] == "test" }
    assert_equal(4, test_case_results.count)
    assert_equal("pass", test_case_results.find{|x| x["label"] == "test_success"}["status"])
    assert_equal("fail", test_case_results.find{|x| x["label"] == "test_fail"}["status"])
    assert_equal("skip", test_case_results.find{|x| x["label"] == "test_omit"}["status"])
    assert_equal("todo", test_case_results.find{|x| x["label"] == "test_pend"}["status"])
  end
end

