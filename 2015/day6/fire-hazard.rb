#!/usr/bin/env ruby

class Grid
  attr_accessor :lights
  def initialize(width, heigth)
    @lights = Array.new(heigth).map{ |_| Array.new(width).fill(0) }
  end

  def turn_on(upper_left, lower_right)
    change_area(upper_left, lower_right, :on)
  end

  def turn_off(upper_left, lower_right)
    change_area(upper_left, lower_right, :off)
  end

  def toggle(upper_left, lower_right)
    change_area(upper_left, lower_right, :toggle_light)
  end

  def change_area(upper_left, lower_right, method)
    (upper_left[0]..lower_right[0]).each do |i|
      (upper_left[1]..lower_right[1]).each do |j|
        lights[j][i] = send(method, lights[j][i])
      end
    end
  end

  def print
    lights.each do |row|
      puts row.map { |light| light_char(light) }.join('')
    end
  end

  def light_char(light)
    (light == 1 ? '*' : '.')
  end

  def on(_)
    1
  end

  def off(_)
    0
  end

  def toggle_light(prev)
    (prev + 1) % 2
  end
end

Struct.new('Instruction', :command, :upper_left, :lower_right)


class Parser
  def parse(string)

  end

  def build_toggle(string)

  end

  def get_integer(s)
    s.scan(/\d+/).map(&:to_i)
  end
end



