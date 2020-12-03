#!/usr/bin/ruby
# frozen_string_literal: true

# == Part 1 ==
# Find how many trees (#) are encountered when moving down 1 and right 3 through the input.

$slope = File.read('input').split("\n").map{|l| l.split('')}
$slope_width = $slope[0].size

def calc_trees(x_inc, y_inc)
  x = 0
  y = 0

  trees_encountered = 0

  while x < $slope.size-1
    y += y_inc
    x += x_inc

    trees_encountered += 1 if $slope[x][y% $slope_width] == '#'
  end

  return trees_encountered
end

puts "Trees encountered: #{calc_trees(1,3)}"

# == Part 2 ==
# Find the product of the above for the following slopes:
# - Right 1, down 1.
# - Right 3, down 1.
# - Right 5, down 1.
# - Right 7, down 1.
# - Right 1, down 2.

total = calc_trees(1, 1) * calc_trees(1, 3) * calc_trees(1, 5) * calc_trees(1, 7) * calc_trees(2, 1)
puts "Total product of all paths: #{total}"
