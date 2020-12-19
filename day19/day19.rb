#!/usr/bin/ruby
# frozen_string_literal: true

require 'ebnf'

rules, messages = File.read('./input2').split("\n\n")

rules = rules.split("\n").sort
messages = messages.split("\n")

# == Part 1 ==
# How many messages completely match rule 0 of the given grammar?

# Convert input to BNF and parse it

rules_bnf = rules.map do |r|
  r.gsub(':', ' ::=').gsub(/(\d+)/, 'rule\1')
end

grammar = EBNF.parse(rules_bnf.join("\n")).make_peg.ast

# use temporary file to store errors
File.write('/tmp/aoc_day19_p1.errlog', nil)
logger = Logger.new('/tmp/aoc_day19_p1.errlog')
logger.level = Logger::ERROR
logger.formatter = ->(severity, _datetime, _progname, msg) { "#{severity} #{msg}\n" }

messages.each do |m|
  logger.error('<next>') # split error messages up
  begin
    EBNF::Parser.parse(m, :rule0, grammar, logger: logger)
  rescue StandardError
    # ignore errors, using the logger for this
  end
end

# this works like bash `uniq` - only remove adjacent duplicates
errors = File.read('/tmp/aoc_day19_p1.errlog').split("\n").chunk(&:itself).map(&:first)

error_count = errors.filter { |e| !e.match?(/<next>/) }.length

puts "Valid messages: #{messages.length - error_count}"

# == Part 2 ==
# Replace the following rules:
# rule 8 with 42 | 42 8
# rule 11 with 42 31 | 42 11 31

rules[rules.index('8: 42')] = '8: 42 | 42 8'
rules[rules.index('11: 42 31')] = '11: 42 31 | 42 11 31'

rules_bnf = rules.map do |r|
  r.gsub(':', ' ::=').gsub(/(\d+)/, 'rule\1')
end

grammar = EBNF.parse(rules_bnf.join("\n")).make_peg.ast

# use temporary file to store errors
File.write('/tmp/aoc_day19_p2.errlog', nil)
logger = Logger.new('/tmp/aoc_day19_p2.errlog')
logger.level = Logger::ERROR
logger.formatter = ->(severity, _datetime, _progname, msg) { "#{severity} #{msg}\n" }

messages.each do |m|
  logger.error('<next>') # split error messages up
  begin
    EBNF::Parser.parse(m, :rule0, grammar, logger: logger)
  rescue StandardError
    # ignore errors, using the logger for this
  end
end

# this works like bash `uniq` - only remove adjacent duplicates
errors = File.read('/tmp/aoc_day19_p2.errlog').split("\n").chunk(&:itself).map(&:first)

error_count = errors.filter { |e| !e.match?(/<next>/) }.length

puts "Valid messages with new rules: #{messages.length - error_count}"
