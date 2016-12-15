#!/usr/bin/env ruby
require 'digest'
input = 'abcdef'
input = 'ckczppom'

requirement = '00000'

part2 = true
requirement = '000000' if part2


digest = Digest::MD5.new
i = 0
loop do
  hex = digest.hexdigest("#{input}#{i}")
  if hex.start_with?(requirement)
    puts i
    break
  end
  i += 1
end
