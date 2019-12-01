require 'date'
class EventSorter
  def run(input)
    input.map { |str| Event.new(str) }.sort_by {|a| a.date }
  end
end

class Event
  attr_accessor :date, :label
  def initialize(string)
    @date = DateTime.parse(string[1,16])
    @label = string[19..-1]
  end

  def type
    return :new_guard if label.start_with?('Guard')
    return :sleep if label.start_with?('falls')
    return :awake if label.start_with?('wakes')
  end

  def get_id
    @label.gsub(/[^0-9]/, '')
  end

  def minute
    @date.min
  end
end

class Guard
  attr_accessor :naps, :id, :sleep_start

  def initialize(id)
    @id = id
    @naps = Array.new(60, 0)
  end

  def fall_asleep(time)
    @sleep_start = time
  end

  def wake_up(time)
    (@sleep_start..(time-1)).each do |i|
      @naps[i] += 1
    end
  end

  def sleepy_minute
    naps.each_with_index.max[1]
  end
end

class OptimalMinuteFinder
  attr_accessor :events, :guards, :current_guard_id
  def initialize(input)
    @events = EventSorter.new.run(input)
    @guards = {}
    log_events
  end

  def strategy_1
    guard = find_sleepy_guard
    [guard.id, guard.sleepy_minute]
  end

  def strategy_2
    guard = find_consistant_guard
    [guard.id, guard.sleepy_minute]
  end

  def find_consistant_guard
    @guards.values.sort_by {|g| g.naps.max }.last
  end

  def find_sleepy_guard
    @guards.values.sort_by {|g| g.naps.sum }.last
  end

  def log_events
    events.each do |event|
      case event.type
      when :new_guard
        @current_guard_id = event.get_id
        @guards[@current_guard_id] = Guard.new(@current_guard_id) unless @guards[@current_guard_id]
      when :sleep
        @guards[@current_guard_id].fall_asleep(event.minute)
      when :awake
        @guards[@current_guard_id].wake_up(event.minute)
      end
    end
  end
end