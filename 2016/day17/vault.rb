#!/usr/bin/env ruby
require 'digest'

Struct.new('Option', :position, :path)

class Vault
  OPEN_INDICATORS = 'bcdef'
  attr_accessor :input, :options, :digest, :longest_path
  def initialize(input)
    @input, @longest_path = input, 0
    @digest = Digest::MD5.new
    @options = [Struct::Option.new([0, 0], '')]
  end

  def traverse(for_longest = false)
    while options.length > 0
      option = options.shift
      if option.position.join('-') == '3-3'
        @longest_path = option.path.length
        return option.path unless for_longest
      else
        @options += find_open_doors(option)
      end
    end
    raise 'Failed to find route' if longest_path == 0
    longest_path
  end

  def find_open_doors(option)
    open_doors = []
    hex = digest.hexdigest("#{input}#{option.path}")
    open_doors << new_option(option, 'D', [0, 1]) if door_is_open?(hex[1]) && option.position[1] < 3
    open_doors << new_option(option, 'R', [1, 0]) if door_is_open?(hex[3]) && option.position[0] < 3
    open_doors << new_option(option, 'U', [0, -1]) if door_is_open?(hex[0]) && option.position[1] > 0
    open_doors << new_option(option, 'L', [-1, 0]) if door_is_open?(hex[2]) && option.position[0] > 0

    open_doors
  end

  def new_option(prev, step, change)
    new_pos = [prev.position, change].transpose.map {|x| x.reduce(:+)}
    Struct::Option.new(new_pos, prev.path + step)
  end

  def door_is_open?(char)
    OPEN_INDICATORS.include?(char)
  end
end

inputs = [
  'ihgpwlah',
  'kglvqrro',
  'ulqzkmiv',
  'yjjvjgan'
]

inputs.each do |input|
  v = Vault.new(input)
  puts v.traverse
  puts v.traverse(true)
end
