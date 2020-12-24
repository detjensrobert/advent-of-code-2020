#!/usr/bin/ruby
# frozen_string_literal: true

# == Part 1 ==
# After 100 turns of the crab's game, what order are the cups in after cup 1?

# The game:
#  Remove cups at indexes 1-3 from the list
#  Find the cup with the next lowest value from the first cup's value (with underflow).
#  Re-add the removed cups just after that cup.
#  Move the first cup to the end of the list.

cups = File.read('./input').split('').map(&:to_i)

# get maximum under the target value
# or overall max if none are smaller
def index_of_next_cup(cups, target)
  filtered = cups.filter { |c| c < target }
  cups.index(filtered.max || cups.max)
end

100.times do
  target = cups.shift

  removed = cups.shift(3)

  index = index_of_next_cup(cups, target)

  removed.reverse_each { |c| cups.insert(index + 1, c) }

  cups.append target
end

cups.append(cups.shift) until cups[0] == 1 # shift until 1 is in front
cups.shift # remove the 1

puts "After 100 turns: #{cups.join ''}"
