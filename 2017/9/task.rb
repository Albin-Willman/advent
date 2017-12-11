
class Group
    attr_accessor :level, :children

    def initialize(content, level = 0)
        @level = level
        @children = []
        parse content
    end

    def parse(input)
        return unless input || input.length == 0
        input = clean(input) if input.is_a? String
        find_children_in(input)
    end

    def value
        level + children.inject(0) { |s, e| s + e.value }
    end

    def find_children_in(input)
        nesting_level = 0
        last_index = 0
        input.each_with_index do |c, i|
            nesting_level += 1 if c == '{'
            nesting_level -= 1 if c == '}'
            if nesting_level == 0
                children << Group.new(input[(last_index+1)..(i-1)], level + 1)
                last_index = i + 1
            end
        end
    end

    def clean(string)
        string = clear_bangs(string.dup)
        string.gsub(/<[^>]+>/, '').gsub(/[^{^}]/, '').split('')
    end

    def clear_bangs(string)
        inside_garbage = false
        chars = string.split('')
        chars.each_with_index do |c, i|
            inside_garbage = true if c == '<'
            inside_garbage = false if c == '>'
            if c == '!' && inside_garbage
                string[i+1] = 'a'
                chars[i+1] = 'a'
            end
        end
        string
    end
end

class GarbageFinder
    def count_amount_of_garbage(string)
        string = string.gsub('a', 'b')
        count = 0
        inside_garbage = false
        chars = string.split('')
        chars.each_with_index do |c, i|
            inside_garbage = true and next if !inside_garbage && c == '<'
            inside_garbage = false if c == '>'
            chars[i+1] = 'a' if c == '!' && inside_garbage
            count += 1 if inside_garbage && !(c == 'a' || c == '!')
        end
        count
    end
end