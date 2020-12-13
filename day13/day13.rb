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

buses = File.read('./input').split("\n")[1].split(',')

buses = buses.map.with_index { |b, i| b == 'x' ? nil : [b.to_i, i] }.compact.to_h

# bruh i dont understand this one :(
