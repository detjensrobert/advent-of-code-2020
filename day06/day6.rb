#!/usr/bin/ruby
# frozen_string_literal: true

group_responses = File.read('input').split("\n\n")
group_responses.map! { |g| g.split("\n").map { |p| p.split('') } }

# == Part 1 ==
# Count the number of questions that any person in each group responded to.

total_responses = 0
group_responses.each do |group|
  total_responses += group.reduce { |common, p| common.union p }.length
end

puts "Total responses from any person in all groups: #{total_responses}"

# == Part 2 ==
# Count the number of questions that every person in each group responded to.

total_responses = 0
group_responses.each do |group|
  total_responses += group.reduce { |common, p| common.intersection p }.length
end

puts "Total responses from every person in all groups: #{total_responses}"
