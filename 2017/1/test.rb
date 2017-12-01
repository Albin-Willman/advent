#!/usr/bin/env ruby
require './task.rb'

easy_inverse_captcha = InverseCaptch.new(EasyIndexComputer.new)
hard_inverse_captcha = InverseCaptch.new(OppositeIndexComputer.new)

tests = {
    '1122' => 3,
    '1111' => 4,
    '1234' => 0,
    '91212129' => 9,
}
def run_test(inverse_captcha, tests)
    tests.each do |input, expected|
        result = inverse_captcha.run(input)
        if result == expected
            puts "#{input} OK"
        else
            puts "#{input} Error"
        end
    end
end
hard_tests = {
    '1212' => 6,
    '1221' => 0,
    '123425' => 4,
    '123123' => 12,
    '12131415' => 4,
}
puts 'Easy'
run_test(easy_inverse_captcha, tests)
puts 'Hard'
run_test(hard_inverse_captcha, hard_tests)
