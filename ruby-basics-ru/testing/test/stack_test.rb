# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN

  def test_insert
    stack = Stack.new [1, 2, 3]
    assert { !stack.to_a.include? 4 }
    stack.push! 4
    assert { stack.to_a.include? 4 }
  end

  def test_delete
    stack = Stack.new [1, 2, 3]
    assert { stack.to_a.include? 3 }
    stack.pop!
    assert { !stack.to_a.include? 3 }
  end

  def test_clear
    stack = Stack.new [1, 2, 3]
    assert { !stack.to_a.empty? }
    stack.clear!
    assert { stack.to_a.empty? }
  end

  def test_empty
    stack = Stack.new
    assert { stack.to_a.empty? }
    assert { stack.empty? }
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
