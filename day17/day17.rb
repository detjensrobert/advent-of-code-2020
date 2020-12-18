#!/usr/bin/ruby
# frozen_string_literal: true

initial_state = File.read('./input').split("\n").map { |l| l.split('') }

# == Part 1 ==
# Given an initial slice of an infinite 3D voxel space and the following rules:
# - An active cube deactivates unless 2 or 3 of its neighbors are active.
# - An inactive cube activates if 3 of its neighbors are active.
# How many cubes are active after the sixth cycle?

# 3d "array" with default value
board = Hash.new(Hash.new(Hash.new('.')))

initial_state.each.with_index do |row, i|
  row.each.with_index do |state, j|
    board[0][i][j] = state
  end
end

def active_neighbors_3d(board, x, y, z)
  dirs = [-1, 0, 1]
  neighbors = dirs.product(dirs, dirs)
  neighbors.delete([0,0,0])

  neighbors.map do |dx, dy, dz|
    board[x+dx][y+dy][z+dz]
  end.count('#')
end

def do_round(board)
  new_board = Marshal.load(Marshal.dump(board)) # deep clone via serialization

  x_range = (board.keys.min - 1..board.keys.max + 1)
  x_range.each do |x, row|
    y_range = (board[x].keys.min - 1..board[x].keys.max + 1)
    y_range.each do |y, col|
      z_range = (board[x][y].keys.min - 1..board[x][y].keys.max + 1)
      z_range.each do |z, slice|
        neighbors = active_neighbors_3d(board, x, y, z)
        if slice == '#' && !(2..3).include?(neighbors)
          new_board[x][y][z] == '.'
        elsif slice == '.' && neighbors == 3
          new_board[x][y][z] == '#'
        end
      end
    end
  end
end

puts board.to_s

round = 0
while round < 6
  board = do_round(board)
end

puts "Number of active cubes after 6 rounds: #{board.flatten(3).count('#')}"
