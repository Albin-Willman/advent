#!/usr/bin/env ruby

class Level
  attr_accessor :generators, :microchips
  def initialize(generators, microchips)
    @generators, @microchips = generators, microchips
  end

  def valid?
    return true if generators.select { |k,v| v }.length == 0
    microchips.each do |key, val|
      return false unless generators[key]
    end
    true
  end

  def clone
    Level.new(generators.clone, microchips.clone)
  end

  def remove(payload)
    @string = nil
    send(payload[:type]).delete(payload[:value])
  end

  def add(payload)
    @string = nil
    send(payload[:type])[payload[:value]] = true
  end

  def possible_payloads
    all_tokens = generators.map { |k,v| { type: :generators, value: k } }
    all_tokens += microchips.map { |k,v| { type: :microchips, value: k } }
    payloads = all_tokens.combination(2).select do |comb|
      comb && (comb[0][:type] == comb[1][:type] || comb[0][:value] == comb[1][:value])
    end
    payloads + all_tokens.map { |e| [e] }
  end

  def empty?
    (generators.values + microchips.values).select { |e| e }.length == 0
  end

  def to_s
    return @string if @string
    pairs = 0
    gens, chips = [], []
    generators.each do |k,v|
      if microchips[k]
        pairs += 1
      else
        gens << k
      end
    end
    microchips.each do |k, v|
      chips << k unless generators[k]
    end

    @string = "G=#{gens.join('-')}|#{pairs}|M=#{chips.join('-')}"
  end
end

class Facility
  attr_accessor :levels, :elevator, :elements
  def initialize(levels, elements,  elevator = 0)
    @levels, @elements = levels, elements
    @elevator = elevator
  end

  def possible_children
    possibilities = {}


    possible_directions.each do |dir|
      possible_payloads.each do |payload|
        possibility = new_possibility(dir, payload)
        possibilities[possibility.state_key] = possibility if possibility
      end
    end
    possibilities
  end

  def new_possibility(dir, payloads)
    f = Facility.new(levels.map(&:clone), elements, elevator)
    payloads.each do |payload|
      f.level.remove(payload)
    end
    f.elevator += dir
    payloads.each do |payload|
      f.level.add(payload)
    end
    return false unless valid?
    f
  end

  def possible_directions
    return [-1] if elevator == 3
    return [1] if elevator == 0
    [-1, 1]
  end

  def valid?
    levels.all?(&:valid?)
  end

  def possible_payloads
    level.possible_payloads
  end

  def level
    levels[elevator]
  end

  def state_key
    return @state_key if @state_key
    pairs = []
    elements.each do |e|
      pair = {}
      levels.each_with_index do |level, i|
        pair[:gen] = i if level.generators[e]
        pair[:chip] = i if level.microchips[e]
      end
      pairs << "#{pair[:gen]}-#{pair[:chip]}"
    end

    @state_key = pairs.sort.join('|') + "e=#{elevator}"
  end

  def done?
    3.times do |i|
      return false unless levels[i].empty?
    end
    true
  end

  def print
    4.times do |i|
      elev = elevator == i ? "E" : "."
      puts "L#{i+1} #{elev} #{levels[i].to_s}"
    end
  end
end

def run(f)
  found, count = false, 0
  possibilities = {}
  possibilities[f.state_key] = f
  visited_states = {}
  until found
    puts "New_itteration #{count}"
    puts possibilities.count
    count += 1
    next_possibilites = {}
    possibilities.each do |k, v|
      visited_states[k] = true
      children = v.possible_children
      children.each do |key, possibility|
        next if visited_states[key]
        visited_states[key] = true
        if possibility.done?
          found = true
          break
        end
        next_possibilites[key] = possibility
      end
    end
    if possibilities.count == 0
      puts 'Bad input'
      break
    end
    possibilities = next_possibilites
  end
  puts "Solution: #{count}" if found
end

elements = [:h]
l1 = Level.new({ h: true }, { h: true })
l2 = Level.new({}, {})
l3 = Level.new({}, {})
l4 = Level.new({}, {})

elements = [:h, :l]
l1 = Level.new({}, { h: true, l: true })
l2 = Level.new({ h: true }, {})
l3 = Level.new({ l: true }, {})
l4 = Level.new({}, {})

elements = [:prom, :cob, :cur, :rut, :plut]
l1 = Level.new({ prom: true }, { prom: true })
l2 = Level.new({ cob: true, cur: true, rut: true, plut: true }, {})
l3 = Level.new({}, { cob: true, cur: true, rut: true, plut: true })
l4 = Level.new({}, {})

elements = [:prom, :cob, :cur, :rut, :plut, :el, :dil]
l1 = Level.new({ prom: true, el: true, dil: true }, { prom: true, el: true, dil: true })
l2 = Level.new({ cob: true, cur: true, rut: true, plut: true }, {})
l3 = Level.new({}, { cob: true, cur: true, rut: true, plut: true })
l4 = Level.new({}, {})

f = Facility.new([l1, l2, l3, l4], elements)
run(f)

