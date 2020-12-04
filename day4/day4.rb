#!/usr/bin/ruby
# frozen_string_literal: true

# == Part 1 ==
# Find all passports that have these fields:
# byr iyr eyr hgt hcl ecl pid

# read passports into [{field: val, field: val}, {...}, ...]
passports = File.read('input').split("\n\n")
passports.map! do |entry|
  hash = {}
  entry.split(' ').each do |field|
    key, val = field.split(':')
    hash[key] = val
  end
  hash
end

required_fields = %w[byr iyr eyr hgt hcl ecl pid]
valid_passports = 0

passports.each do |p|
  has_fields = true
  required_fields.each do |f|
    has_fields = false unless p.include? f
  end

  valid_passports += 1 if has_fields
end

puts "Valid passports: #{valid_passports}"

# == Part 2 ==
# Find all passports that have valid data for those required fields.

valid_passports = 0
passports.each do |p|
  has_fields = true
  required_fields.each do |f|
    has_fields = false unless p.include? f
  end

  is_valid = false
  if has_fields
    byr = (1920..2002).include? p['byr'].to_i
    iyr = (2010..2020).include? p['iyr'].to_i
    eyr = (2020..2030).include? p['eyr'].to_i
    hgt = case p['hgt']
          when /cm/
            (150..193).include? p['hgt'].to_i
          when /in/
            (59..76).include? p['hgt'].to_i
          else
            false
          end
    hcl = p['hcl'].match?(/#[0-9a-f]{6}/)
    ecl = %w[amb blu brn gry grn hzl oth].include? p['ecl']
    pid = p['pid'].match?(/\d{9}/)

    is_valid = byr && iyr && eyr && hgt && hcl && ecl && pid
  end
  valid_passports += 1 if has_fields && is_valid
end

puts "Passports with valid data: #{valid_passports}"
