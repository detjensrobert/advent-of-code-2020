#!/usr/bin/ruby
# frozen_string_literal: true

rules, messages = File.read('./input').split("\n\n")

rules = rules.split("\n")
messages = messages.split("\n")

# == Part 1 ==
# How many messages completely match rule 0?

# Convert input to BNF and parse it
require 'ebnf'

rules_bnf = rules.map do |r|
  r.gsub(':', ' ::=').gsub(/(\d+)/, 'rule\1')
end

grammar = EBNF.parse(rules_bnf.join("\n"), format: :ebnf)

puts grammar.to_s
