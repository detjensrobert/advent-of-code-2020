#!/usr/bin/ruby
# frozen_string_literal: true

# The plane has 128 rows of seats and 8 seats per row
# (F)rontmost is 0, (B)ackmost is 127.
# (L)eftmost is 0, (R)ightmost is 7

passes = File.read('input').split("\n")

# == Part 1 ===
# Find the highest seat ID (row*8 + col).

seat_ids = passes.map do |p|
  p.gsub(/F|L/, '0').gsub(/B|R/, '1').to_i(2)
end

puts "Highest seat ID: #{seat_ids.max}"

# == Part 2 ==
# Find the missing seat that does not already have a pass

missing_seats = (0..(127*8 + 7)).to_a - seat_ids
# Remove leading / trailing continuous sequences -- those seats don't exist on this plane & werent booked
missing_seats.delete_if.with_index {|s, i| s + 1 == missing_seats[i+1] }

puts "Missing seat ID: #{missing_seats[1]}"
