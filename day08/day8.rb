#!/usr/bin/ruby
# frozen_string_literal: true

require 'set'

instructions = File.read('./input').split("\n")
instructions.map! do |i|
  op, arg = i.split
  [op, arg.to_i]
end

# == Part 1 ==
# There is an infinite loop somewhere in the input code!
# Immediately before any instruction is executed a second time, what value is in the accumulator?

acc = 0
idx = 0

already_executed = Set[]

while already_executed.add?(idx) # returns nil if already in the set
  op, arg = instructions[idx]

  case op
  when 'acc'
    acc += arg
    idx += 1
  when 'jmp'
    idx += arg
  when 'nop'
    idx += 1
  end
end

puts "ACC before executing duplicate instructions: #{acc}"

# == Part 2 ==
# An instruction is corrupted: either jmp->nop or nop->jmp.
# Find the corrupted instruction and fix it so the program ends correctly.
# (by attempting  to execute the instruction right after EOF)

# return ACC if finished correctly, or false if infinite loop
def execute(instructions, idx, acc, already_executed, corrected)
  return acc if idx == instructions.length

  op, arg = instructions[idx]

  return false unless already_executed.add?(idx)

  case op
  when 'acc'
    execute(instructions, idx + 1, acc + arg, already_executed, corrected)
  when 'jmp'
    # only try correction if it hasnt been done already in this branch
    nop = corrected ? false : execute(instructions, idx + 1, acc, already_executed.clone, true)
    nop || execute(instructions, idx + arg, acc, already_executed.clone, corrected)
  when 'nop'
    # only try correction if it hasnt been done already in this branch
    jmp = corrected ? false : execute(instructions, idx + arg, acc, already_executed.clone, true)
    jmp || execute(instructions, idx + 1, acc, already_executed.clone, corrected)
  end
end

puts "ACC after correctly executing everything: #{execute(instructions, 0, 0, Set[], false)}"
