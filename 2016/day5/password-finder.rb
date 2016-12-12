#!/usr/bin/env ruby
require 'digest'

id, index, found, sep = 'ugkcyxxp', 0, 0, '-'
password = sep*8
digest = Digest::MD5.new

# while password.length < 8
#   hex = digest.hexdigest("#{id}#{index}")
#   password += hex[5] if hex.start_with?('00000')
#   index += 1
# end
# puts password

# Solution 2

def numeric?(lookAhead)
  lookAhead =~ /[0-9]/
end

def nextSep(sep)
  return '|' if sep == '-'
  '-'
end

while found < 8
  hex = digest.hexdigest("#{id}#{index}")
  if index % 50000 === 0
    newSep = nextSep(sep)
    password.gsub!(/#{Regexp.quote(sep)}/, newSep)
    sep = newSep

    print '     ' + password + "\r"
  end

  if hex.start_with?('00000') && numeric?(hex[5]) && password[hex[5].to_i] == sep
    found += 1
    password[hex[5].to_i] = hex[6]
    print '     ' + password + "\r"
  end
  index += 1
end

puts '     ' + password