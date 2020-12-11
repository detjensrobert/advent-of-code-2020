#!/usr/bin/ruby
# frozen_string_literal: true

seats = File.read('./input').split("\n").map { |r| r.split('') }

def print_seats(seats)
  seats.each do |r|
    puts r.join
  end
end

# == Part 1 ==
# - if seat is empty & no surrounding are occupied, seat becomes occupied
# - if seat is occupied & >=4 surrounding are occupied, seat becomes empty
# How many seats are occupied when the simulation settles?

def adjacent_filled(seats, x, y)
  filled = 0

  filled += 1 if x > 0 && y > 0 && seats[x - 1][y - 1] == '#'
  filled += 1 if x > 0 && seats[x - 1][y] == '#'
  filled += 1 if x > 0 && y < seats[x].size - 1 && seats[x - 1][y + 1] == '#'

  filled += 1 if y > 0 && seats[x][y - 1] == '#'
  filled += 1 if y < seats[x].size - 1 && seats[x][y + 1] == '#'

  filled += 1 if x < seats.size - 1 && y > 0 && seats[x + 1][y - 1] == '#'
  filled += 1 if x < seats.size - 1 && seats[x + 1][y] == '#'
  filled += 1 if x < seats.size - 1 && y < seats[x].size - 1 && seats[x + 1][y + 1] == '#'

  filled
end

previous_state = nil

while seats != previous_state
  previous_state = seats.map(&:clone) # deep copy seats array

  previous_state.each.with_index do |row, x|
    row.each.with_index do |s, y|
      next if s == '.' # ignore floor tiles

      filled = adjacent_filled(previous_state, x, y)

      # fill seat if no adjacent seats filled
      seats[x][y] = '#' if filled == 0

      # vacate seat if at least 4 adjacent seats filled
      seats[x][y] = 'L' if filled >= 4
    end
  end
end

puts "Seats filled after adjacency settling: #{seats.reduce(0) { |c, r| c + r.count { |s| s == '#' } }}"

# == Part 2 ==
# Instead of immediately adjacent, use the nearest seat in each 8 directions, even if it is farther away.
# Also, 5 filled seats are now needed to vacate.

seats = File.read('./input').split("\n").map { |r| r.split('') }

def los_filled(seats, x, y)
  filled = 0
  directions = [
    [-1, -1], # left up
    [-1, 0],  # left
    [-1, 1],  # left down
    [0, -1],  # up
    [0, 1],   # down
    [1, -1],  # right up
    [1, 0],   # right
    [1, 1]    # right down
  ]

  directions.each do |x_inc, y_inc|
    curr_x = x + x_inc
    curr_y = y + y_inc
    while (curr_x >= 0 && curr_x < seats.size) && # x in bounds?
          (curr_y >= 0 && curr_y < seats[x].size) && # y in bounds?
          (seats[curr_x][curr_y] == '.') # are we still finding floor?
      curr_x += x_inc
      curr_y += y_inc
    end

    # in bounds and occupied
    if (curr_x >= 0 && curr_x < seats.size) && (curr_y >= 0 && curr_y < seats[x].size)
      filled += 1 if seats[curr_x][curr_y] == '#'
    end
  end
  filled
end

previous_state = nil

while seats != previous_state
  previous_state = seats.map(&:clone) # deep copy seats array

  previous_state.each.with_index do |row, x|
    row.each.with_index do |s, y|
      next if s == '.' # ignore floor tiles

      filled = los_filled(previous_state, x, y)

      # fill seat if no adjacent seats filled
      seats[x][y] = '#' if filled == 0

      # vacate seat if at least 4 adjacent seats filled
      seats[x][y] = 'L' if filled >= 5
    end
  end
end

puts "Seats filled after line-of-sight settling: #{seats.reduce(0) { |c, r| c + r.count { |s| s == '#' } }}"
