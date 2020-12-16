#!/usr/bin/ruby
# frozen_string_literal: true

# == Part 1 ==
# If the previous number has not been said, say 0.
# If it has, say how long ago it was said.
# What is the 2020th number?

def memory_game(limit)
  input = File.read('./input').split(",").map(&:to_i)

  history = {} # when each number was last spoken
  history.default = [nil, nil]
  current = nil

  input.each.with_index do |n, i|
    current = n
    history[current] = [i, history[current][0]]
  end

  i = input.length

  while i < limit
    previous = current
    if history[previous][1].nil?
      current = 0
    else
      current = history[previous][0] - history[previous][1]
    end

    history[current] = [i, history[current][0]]
    i += 1
  end

  current
end

puts "The 2020th number is: #{memory_game(2020)}"

# == Part 2 ==
# what is the 30000000th number?

puts "The 30000000th number is: #{memory_game(30000000)}"
