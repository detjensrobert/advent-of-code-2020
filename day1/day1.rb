#!/usr/bin/ruby

# == Part 1 ==
# Find two numbers in `input` that sum to 2020 and multiply them

# == Part 2 ==
# Do the same, but for a sum of three numbers.

input = File.read('./input').split.map { |x| x.to_i }

input.each do |x|
  input.each do |y|
    puts "Two-number sum: #{x}*#{y} = #{x * y}" if x + y == 2020

    input.each do |z|
      puts "Three-number sum: #{x}*#{y}*#{z} = #{x * y * z}" if x + y + z == 2020
    end
  end
end
