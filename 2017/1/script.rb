#!/usr/bin/env ruby
require './task.rb'
easy_inverse_captcha = InverseCaptch.new(EasyIndexComputer.new)
hard_inverse_captcha = InverseCaptch.new(OppositeIndexComputer.new)
File.open('data.txt').read.each_line do |line|
    puts "Result of part 1 is: #{easy_inverse_captcha.run(line)}"
    puts "Result of part 2 is: #{hard_inverse_captcha.run(line)}"
end
