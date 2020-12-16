#!/usr/bin/ruby
# frozen_string_literal: true

# == Part 1 ==
# The input sets memory values with a changing bitmask.
# What is the sum of all values left in memory after it completes?

input = File.read('./input').split("\n")

or_mask = 0 # sets bits to 1
and_mask = 0 # sets bits to 0
memory = {}

input.each do |line|
  case line
  when /^mask/
    or_mask = 0
    and_mask = (2**36 - 1)
    mask = line.delete_prefix 'mask = '
    mask.each_char.reverse_each.with_index do |b, i| # LSB -> MSB
      next if b == 'X'

      or_mask |= b.to_i << i
      and_mask &= ~((1 ^ b.to_i) << i)
    end
  when /^mem/
    _, addr, value = line.split(/mem\[(\d+)\] = (\d+)/)

    value = value.to_i
    value |= or_mask
    value &= and_mask

    memory[addr] = value
  end
end

puts "Sum of memory with value masking: #{memory.values.reduce(:+)}"

# == Part 2 ==
# The mask actually changes the address bits instead of the value's.
# What is the sum of all values left in memory after it completes?

input = File.read('./input').split("\n")

or_mask = 0
and_mask = 0
floating_indexes = []
memory = {}

def all_possible_addresses(floating_indexes, addr)
  # generate all combinations of floating indexes
  idx_combinations = (0..floating_indexes.size).map { |l| floating_indexes.combination(l).to_a }.flatten(1)

  # turn array of indexes into proper numbers
  idx_combinations.map do |idxs|
    idxs.reduce(0) { |a, i| a | (1 << i) } | addr
  end
end

input.each do |line|
  case line
  when /^mask/
    or_mask = 0
    and_mask = 0
    floating_indexes = []

    mask = line.delete_prefix 'mask = '
    mask.each_char.reverse_each.with_index do |b, i| # LSB -> MSB
      case b
      when '1'
        or_mask |= 1 << i
      when 'X'
        and_mask |= 1 << i
        floating_indexes.append i
      end
    end

    and_mask = 2**36 - 1 ^ and_mask
  when /^mem/
    _, addr, value = line.split(/mem\[(\d+)\] = (\d+)/)

    addr = addr.to_i
    addr |= or_mask
    addr &= and_mask
    addrs = all_possible_addresses(floating_indexes, addr)

    addrs.each { |a| memory[a] = value.to_i }
  end
end

puts "Sum of memory with address masking: #{memory.values.reduce(:+)}"
