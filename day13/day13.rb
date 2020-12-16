#!/usr/bin/ruby
# frozen_string_literal: true

# == Part 1 ==
# For the next bus you can take,
# what is the bus ID times the number of minutes to wait for that bus?

departure_time, buses = File.read('./input').split("\n")

departure_time = departure_time.to_i
buses = buses.split(',').filter { |b| b != 'x' }.map(&:to_i)

wait_time = buses.map { |b| b * (departure_time / b + 1) - departure_time }

min_wait = wait_time.min
min_bus = buses[wait_time.index(min_wait)]

puts "Bus ID * wait time: #{min_bus * min_wait}"

# == Part 2 ==
# Find the time T where all buses in service depart at T + their index?

input = File.read('./input').split("\n")[1].split(',')

buses = []
remainders = []

input.each.with_index do |b, i|
  next if b == 'x'

  buses.append b.to_i
  remainders.append b.to_i - i
end

# sources:
# https://rosettacode.org/wiki/Modular_inverse#Ruby
# https://www.geeksforgeeks.org/chinese-remainder-theorem-set-2-implementation/
def modular_inverse(a, m) # compute a^-1 mod m if possible
  return m if m == 1

  m0 = m
  inv = 1
  x0 = 0
  while a > 1
    inv -= (a / m) * x0
    a, m = m, a % m
    inv, x0 = x0, inv
  end
  inv += m0 if inv < 0
  inv
end

def chinese_remainder(buses, mods)
  product = buses.reduce(:*)

  result = 0
  buses.each.with_index do |b, i|
    pp = product / b
    result += mods[i] * modular_inverse(pp, b) * pp
  end

  result % product
end

puts "Lowest time for index offsets: #{chinese_remainder(buses, remainders)}"
