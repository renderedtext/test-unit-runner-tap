require 'test-unit'
require File.expand_path(File.dirname(__FILE__) + '/../../lib/test/unit/runner/tap')

class ExampleTestCase < Test::Unit::TestCase
  def test_error
    raise
  end

  def test_failing
    assert_equal('1', '2')
  end

  def test_passing
    sleep 1
    assert_equal('1', '1')
  end

  def test_todo
    pend
    assert_equal(3, 1 + 2)
  end

  def test_omitted
    omit
    assert_equal(1, 1 + 0)
  end
end


