#!/usr/bin/ruby

# == Part 1 ==
# Find all lines where `str` does not contain `c` between `X` and `Y` times.
# X-Y c: str

input = File.read('input').split("\n")

input.map! { |l| l.split(/(\d+)-(\d+) (.): (.+)/).drop(1) } # first match w/ regex split is empty
input.map! { |x, y, c, str| [x.to_i, y.to_i, c, str] }

valid_passwords = 0

input.each do |min, max, char, str|
  valid_passwords += 1 if (min..max).include? str.count(char)
end

puts "Valid passwords for range: #{valid_passwords}"

# == Part 2 ==
# Find all lines where `str` contains `c` at either position `X` or `Y` (1-index).
# X-Y c: str

valid_passwords = 0

input.each do |x, y, char, str|
  valid_passwords += 1 if (str[x - 1] == char) ^ (str[y - 1] == char) # ^ is XOR
end

puts "Valid passwords for positions: #{valid_passwords}"
