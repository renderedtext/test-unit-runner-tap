require 'test/unit/ui/tap/base_testrunner'

module Test
  module Unit
    module UI
      module Tap

        # TAP-J report format.
        #
        class JSONTestRunner < Tap::BaseTestRunner
          def initialize(suite, options={})
            require 'json' unless respond_to?(:to_json)
            super(suite, options)
          end
          def tapout_before_suite(suite)
            puts super(suite).to_json
          end
          def tapout_before_case(testcase)
            doc = super(testcase)
            puts doc.to_json if doc
          end
          def tapout_note(note)
            doc = super(note)
            puts doc.to_json if doc
          end
          def tapout_pass(test)
            doc = super(test)
            puts doc.to_json if doc
          end
          def tapout_fail(test)
            doc = super(test)
            puts doc.to_json if doc
          end
          def tapout_omit(test)
            doc = super(test)
            puts doc.to_json if doc
          end
          def tapout_todo(test)
            doc = super(test)
            puts doc.to_json if doc
          end
          def tapout_error(test)
            doc = super(test)
            puts doc.to_json if doc
          end
          def tapout_after_suite(time)
            doc = super(time)
            puts doc.to_json if doc
          end
        end

      end #module Tap
    end #module UI
  end #module Unit
end #module Test
