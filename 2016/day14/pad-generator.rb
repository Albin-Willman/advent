#!/usr/bin/env ruby
require 'digest'

Struct.new('Prospect', :index, :char)

input = 'abc'
input = 'ngcjuoqr'

index, found, prospects = 0, [], []
digest = Digest::MD5.new

part2 = false

while found.length < 64 || prospects.length > 0
  prospects.reject! { |p| (p.index + 1000) <= index }

  hex = digest.hexdigest("#{input}#{index}")
  if part2
    2016.times do
      hex = digest.hexdigest(hex)
    end
  end

  triplets = hex.scan(/([a-f0-9])\1\1+/)
  if triplets.length > 0
    quintets = prospects.length > 0 ? hex.scan(/([a-f0-9])\1\1\1\1+/).flatten : []
    if quintets.length > 0
      prospects.reject! do |p|
        if (quintets.include?(p.char))
          found << p
        else
          false
        end
      end
    end
    prospect = Struct::Prospect.new(index, triplets.flatten[0])
    prospects << prospect if found.length < 64
  end
  index += 1
end

found.sort! { |a,b| a.index <=> b.index }
puts found[63].index
