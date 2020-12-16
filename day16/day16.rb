#!/usr/bin/ruby
# frozen_string_literal: true

input = File.read('./input').split("\n\n")

restrictions = {}
input[0].split("\n").each do |r|
  _, name, r1_l, r1_h, r2_l, r2_h = r.split(/(.+): (\d+)-(\d+) or (\d+)-(\d+)/)

  restrictions[name] = [
    (r1_l.to_i..r1_h.to_i),
    (r2_l.to_i..r2_h.to_i)
  ]
end

my_ticket = input[1].split("\n")[1].split(',').map(&:to_i)

other_tickets = input[2].split("\n")[1..-1]
other_tickets.map! { |t| t.split(',').map(&:to_i) }

# == Part 1 ==
# What is you ticket scanning error rate?
# (the sum of all values not valid for any field)

sum_of_invalid = 0

other_tickets.each do |ticket|
  ticket.each do |field|
    sum_of_invalid += field unless restrictions.values.flatten.map { |r| r.include?(field) }.any?
  end
end

puts "Sum of invalid fields (ticket error rate): #{sum_of_invalid}"

# == Part 2 ==
# Remove the invalid tickets from part 1.
# Use the remaining tickets to see which field is which.
# What is the product of the departure* fields on your ticket?

# remove known invalid tickets
other_tickets.keep_if do |ticket|
  ticket.map do |field|
    restrictions.values.flatten.map { |r| r.include?(field) }.any?
  end.all?
end

field_names = {}
my_ticket.each.with_index { |_, i| field_names[i] = restrictions.keys }

# look through all tickets and eliminate non-possible fields
other_tickets.each do |ticket|
  ticket.each.with_index do |value, i|
    field_names[i].keep_if do |name|
      restrictions[name][0].include?(value) || restrictions[name][1].include?(value)
    end
  end
end

field_names = field_names.sort_by { |_, names| names.size }.to_h

already_seen = {}
field_names.each do |idx, names|
  already_seen[names[0]] = idx

  field_names.each do |i, n|
    field_names[i] = n - already_seen.keys
  end
end

already_seen.keep_if { |name, _| name.match?(/departure/) }

puts "Product of all departure fields: #{already_seen.reduce(1) { |sum, kv| sum * my_ticket[kv[1]] }}"
