#!/usr/bin/env ruby
require "./task.rb"

test_input = ["pbga (66)",
"xhth (57)",
"ebii (61)",
"havc (66)",
"ktlj (57)",
"fwft (72) -> ktlj, cntj, xhth",
"qoyq (66)",
"padx (45) -> pbga, havc, qoyq",
"tknk (41) -> ugml, padx, fwft",
"jptl (61)",
"ugml (68) -> gyxo, ebii, jptl",
"gyxo (61)",
"cntj (57)"]

expected = 'tknk'
rt = RecursiveTree.new(test_input)
if rt.find_root.name == expected
    puts "Easy OK"
else
    puts "Easy Error"
end

rt.build_tree

puts "#{rt.find_correct_weight}"