#!/usr/bin/ruby
# frozen_string_literal: true

adapters = File.read('./input').split("\n").map(&:to_i)

# == Part 1 ==
# A charging adapter can only work if it is plugged in to another charger rated 1-3 lower than itself.
# Find a chain that uses all adapters.
# What is the number of 1-jolt differences multiplied by the number of 3-jolt differences?

adapters.append 0 # wall plug
adapters.append adapters.max + 3 # device's charger
adapters.sort!

diff1_count = 0
diff3_count = 0

adapters.each.with_index do |curr_c, i|
  next if i == 0 || i == adapters.length - 1 # ignore first/last elems

  next_c = adapters[i + 1]

  # verify the chain is correct
  raise "Chain is bad! #{x} -> #{adapters[i + 1]} (pos #{i})" unless [1, 2, 3].include? next_c - curr_c

  diff1_count += 1 if curr_c + 1 == next_c
  diff3_count += 1 if curr_c + 3 == next_c
end

puts "Product of 1-diff and 3-diff: #{diff1_count * diff3_count}"

# == Part 2 ==
# How many different ways can you connect the device to the wall?

# memoization + recursion

# find all permutations of passed array
previously_found = {}
def num_permutations(adapters)

end

puts "Number of possible adapter chains:"
