#!/usr/bin/ruby
# frozen_string_literal: true

rule_strs = File.read('./input').split("\n")

# hash of color => valid contained colors
rules = {}

rule_strs.each do |r|
  bag, contains = r.split(/(.+) bags contain (.+) bags?./).drop(1)

  contains = if contains == 'no other'
               nil
             else
               contains.split(', ').map do |c|
                 c.gsub!(/ bags?/, '')
                 c.split(/(\d+) (.+)/).drop(1).reverse
               end.to_h
             end

  rules[bag] = contains
end

# == Part 1 ==
# How many colors of bags can contain a shiny gold bag?

def can_contain_gold?(rules, already_known, bag_color)
  return already_known[bag_color] if already_known.include? bag_color # memoization ftw

  return false if rules[bag_color].nil? # nil == cannot contain any bags

  return true if rules[bag_color].include? 'shiny gold' # stop recursing if we can hold it

  already_known[bag_color] = rules[bag_color].map { |r| can_contain_gold?(rules, already_known, r[0]) }.any? # recurse if not found
  already_known[bag_color]
end

total = 0
rules.each do |color, _contains|
  total += 1 if can_contain_gold?(rules, {}, color)
end
puts "Total bags that can contain a gold bag: #{total}"

# == Part 2 ==
# How many bags are contained within a shiny gold bag?

def bag_contains(rules, bag_color)
  total = 1 # self
  return total if rules[bag_color].nil?

  rules[bag_color].each do |bag, count|
    total += count.to_i * bag_contains(rules, bag)
  end
  total
end

puts "Total bags within a gold bag: #{bag_contains(rules, 'shiny gold') - 1}"
