#!/usr/bin/env ruby
require 'digest'

id, index, password = 'ugkcyxxp', 0, ''
digest = Digest::MD5.new

while password.length < 8
  hex = digest.hexdigest("#{id}#{index}")
  password += hex[5] if hex.start_with?('00000')
  index += 1
end
puts password
