#!/usr/bin/env ruby
require "./task.rb"

test_cases = {
    '{}' => 1,
    '{{{}}}' => 6,
    '{{{},{},{{}}}}' => 16,
    '{{},{}}' => 5,
    '{<a>,<a>,<a>,<a>}' => 1,
    '{{<ab}>},{<{ab>},{<ab>},{<ab>}}' => 9,
    '{{<!!>},{<!!>},{<!!>},{<!!>}}' => 9,
    "{{<a!>},{<a!>},{<a!>},{<ab>}}" => 3
}


test_cases.each do |input, expected|
    g = Group.new(input)
    if g.value == expected
        puts "#{input} OK"
    else
        puts "#{input} Bad got #{g.value} expected #{expected}"
    end
end

gf_test_cases = {
    '<>' => 0,
    '<random characters>' => 17,
    '<<<<>' => 3,
    '<{!>}>' => 2,
    '<!!>' => 0,
    '<{o"i!a,<{i<a>' => 10,
}

gf = GarbageFinder.new
gf_test_cases.each do |input, expected|
    res = gf.count_amount_of_garbage(input)
    if res == expected
        puts "#{input} OK"
    else
        puts "#{input} Bad got #{res} expected #{expected}"
    end
end
