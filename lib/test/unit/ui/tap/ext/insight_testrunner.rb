require 'test/unit/ui/tap/base_testrunner'
require 'test/unit/ui/console/testrunner'

module Test
  module Unit
    module UI
      module Tap
        # This runner is used by SemaphoreCI to generate insights.
        # It shows the user friendly output on console and
        # creates a JSON output file(test_unit_report.json)
        #
        class InsightTestRunner < Tap::BaseTestRunner
          def initialize(suite, options={})
            @console = Test::Unit::UI::Console::TestRunner.new(suite, options)
            @results = []
            require 'json' unless respond_to?(:to_json)
            super(suite, options)
          end

          def tapout_before_suite(suite)
            @console.send(:started, suite)

            doc = super(suite)
            @results << doc if doc
          end

          def tapout_after_suite(time)
            @console.send(:finished, time)

            doc = super(time)
            @results << doc if doc
            write_to_report
          end

          def tapout_before_test(test)
            @console.send(:test_started, test)
            super(test)
          end

          def tapout_before_case(testcase)
            @console.send(:test_suite_started, testcase)

            doc = super(testcase)
            @results << doc if doc
          end

          def tapout_after_case(testcase)
            @console.send(:test_suite_finished, testcase)
          end

          def tapout_fault(test)
            @console.send(:add_fault, test)
            super(test)
          end

          def tapout_pass(test)
            @console.send(:test_finished, test)

            doc = super(test)
            @results << doc if doc
          end

          def tapout_fail(test)
            doc = super(test)
            @results << doc if doc
          end

          def tapout_note(note)
            doc = super(note)
            @results << doc if doc
          end

          def tapout_omit(test)
            doc = super(test)
            @results << doc if doc
          end

          def tapout_todo(test)
            doc = super(test)
            @results << doc if doc
          end

          def tapout_error(test)
            doc = super(test)
            @results << doc if doc
          end

          private
          def write_to_report
            File.open('test_unit_report.json', 'w') { |file| file.write(@results.to_json) }
          end
        end

      end #module Tap
    end #module UI
  end #module Unit
end #module Test
