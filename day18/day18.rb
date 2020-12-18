#!/usr/bin/ruby
# frozen_string_literal: true

equations = File.read('./input').split("\n")

# == Part 1 ==
# Evaluate the input equations in strict L2R, not PEMDAS.
# What is the sum of all equations?

# abuse operator overloading to make '+' eval at same time as '*'
class Integer
  def /(other)
    self + other
  end
end
equations.map! { |e| e.gsub('+', '/') }

sum = equations.reduce(0) { |sum, eqn| sum + eval(eqn) }

puts "Sum of L2R evals: #{sum}"

# == Part 2 ==
# Addition is now done before multiplication.
# What is the sum of all equations?

# keep the overloading train going
class Integer
  def -(other)
    self * other
  end
end
equations.map! { |e| e.gsub('*', '-') }

sum = equations.reduce(0) { |sum, eqn| sum + eval(eqn) }

puts "Sum of add-then-multiply evals: #{sum}"
