#!/usr/bin/ruby
# frozen_string_literal: true

directions = File.read('./input').split("\n")

# == Part 1 ==
# Given the input navigation directions, how far does the ship travel in Manhattan distance?

ship_x = 0
ship_y = 0

FACINGS = %w[N E S W].freeze
ship_facing = 1 # starts facing east

directions.each do |d|
  action = d.slice!(0)
  distance = d.to_i

  action = FACINGS[ship_facing] if action == 'F'

  case action
  when 'N'
    ship_y += distance
  when 'E'
    ship_x += distance
  when 'S'
    ship_y -= distance
  when 'W'
    ship_x -= distance
  when 'L'
    ship_facing = (ship_facing - distance / 90) % 4
  when 'R'
    ship_facing = (ship_facing + distance / 90) % 4
  end
end

puts "Total Manhattan distance for ship movement: #{ship_x.abs + ship_y.abs}"

# == Part 1 ==
# The directions actually pertained to moving a waypoint around.
# How far does the ship travel in Manhattan distance with the new directions?

directions = File.read('./input').split("\n")

ship_x = 0
ship_y = 0

wp_x = 10
wp_y = 1

directions.each do |d|
  action = d.slice!(0)
  distance = d.to_i

  case action
  when 'N'
    wp_y += distance
  when 'E'
    wp_x += distance
  when 'S'
    wp_y -= distance
  when 'W'
    wp_x -= distance
  when 'L'
    (1..(distance / 90)).each { |_| wp_x, wp_y = -1 * wp_y, wp_x }
  when 'R'
    (1..(distance / 90)).each { |_| wp_x, wp_y = wp_y, -1 * wp_x }
  when 'F'
    ship_x += wp_x * distance
    ship_y += wp_y * distance
  end
end

puts "Total Manhattan distance for waypoint movement: #{ship_x.abs + ship_y.abs}"
