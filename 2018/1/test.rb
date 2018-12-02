#!/usr/bin/env ruby
require "./task.rb"

puts FrequenzyChanger.new.run(['1','1','1'])

puts FrequenzyChanger.new.run_until_first_repeat(['1','-1','1'])

puts FrequenzyChanger.new.run_until_first_repeat(['+3', '+3', '+4', '-2', '-4'])
