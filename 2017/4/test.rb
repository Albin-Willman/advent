#!/usr/bin/env ruby
require "./task.rb"


pv = PassphraseValidator.new
pc = PassphraseCounter.new(pv)

easy_test_data = {
    "aa bb cc dd ee" => true,
    "aa bb cc dd aa" => false,
    "aa bb cc dd aaa" => true
}

easy_test_data.each do |input, expected|
    if pv.valid?(input) == expected
        puts "Easy ok. #{input}"
    else
        puts "Easy error. #{input}"
    end
end

apv = AnagramPassphraseValidator.new
pc2 = PassphraseCounter.new(apv)

hard_test_data = {
    "abcde fghij" => true,
    "abcde xyz ecdab" => false,
    "a ab abc abd abf abj" => true,
    "iiii oiii ooii oooi oooo" => true,
    "oiii ioii iioi iiio" => false
}

hard_test_data.each do |input, expected|
    if apv.valid?(input) == expected
        puts "hard ok. #{input}"
    else
        puts "hard error. #{input}"
    end
end