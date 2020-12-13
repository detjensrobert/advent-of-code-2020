#!/usr/bin/ruby
# frozen_string_literal: true

input = File.read('./input').split("\n").map(&:to_i)

# == Part 1 ==
# Each number must be the sum of any two of the preceding 25 numbers (except the leading 25).
# What is the first number that does not follow this pattern?

# process preamble
last25 = input.shift(25)
still_valid = true

while still_valid
  next_value = input.shift

  still_valid = last25.permutation(2).map { |x, y| x + y }.include? next_value

  last25.shift
  last25.append(next_value)
end

bad_number = last25[-1]

puts "First value not a sum of the prev 25: #{bad_number}"

# == Part 2 ==
# Find a contiguous set of 2+ numbers that sum to the value from Part 1.
# What is the sum of the smallest and largest numbers from that set?

input = File.read('./input').split("\n").map(&:to_i)

def find_sum_to(bad_number, input)
  sums = []
  input.each do |n|
    sums.collect! do |sum, arr| # add current number to all current sums
      sum += n
      arr.append n
      return arr if sum == bad_number

      [sum, arr]
    end
    sums.delete_if { |sum, _arr| sum > bad_number } # remove sums that are too big
    sums.append [n, [n]] # start new sum with current number
  end
end

puts "Sum of min/max in additive sequence: #{find_sum_to(bad_number, input).minmax.sum}"
