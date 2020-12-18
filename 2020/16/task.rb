class Task
  def self.run(input)
    tv = TicketValidator.new
    tv.run(input)
    puts tv.invalids.sum

  end
  def self.run_b(input)
    tv = TicketValidator.new
    tv.run(input)
    tv.identify_fields
    tv.value
  end
end


class TicketValidator
  attr_accessor :invalids, :fields, :your_ticket, :valid_tickets, :field_indices
  def initialize
    @invalids = []
    @fields = {}
    @valid_tickets = []
    @field_indices = {}
  end

  def identify_fields
    possibilities = {}
    @your_ticket.length.times do |i|
      possibilities[i] = @fields.keys.select { |f| possible_field(f, i)}
    end
    possibilities.keys.length.times do
      possibilities.each do |i, fs|
        if fs.length == 1
          val = fs[0]
          @field_indices[val] = i
          possibilities.each do |j, fsi|
            fsi.delete(val)
          end
          break
        end
      end
    end
    puts "#{@field_indices}"
  end

  def value
    val = 1
    @field_indices.each do |field, i|
      val *= @your_ticket[i] if field.start_with?('departure')
    end
    val
  end

  def possible_field(field, i)
    @valid_tickets.each do |ticket|
      n = ticket[i]
      valid = false
      @fields[field].each do |range|
        valid ||= range.include?(n)
      end
      return false unless valid
    end
    true
  end

  def run(input)
    i = 0
    loop do
      val = input[i]
      i += 1
      break if val.start_with?('your')
      parts = val.split(': ')
      if parts[1]
        @fields[parts[0]] = []
        parts[1].split(' or ').each do |part|
          @fields[parts[0]] << Interval.new(part)
        end
      end
    end

    @your_ticket = input[i].split(',').map(&:to_i)

    i += 3
    (i..(input.length-1)).each do |j|
      ticket = input[j].split(',').map(&:to_i)
      @valid_tickets << ticket if validate(ticket)
    end
  end

  def validate(ticket)
    res = ticket.reject { |n| valid_number?(n) }
    if res.length > 0
      @invalids += res
      return false
    end
    true
  end

  def valid_number?(n)
    @fields.values.each do |field|
      field.each do |range|
        return true if range.include?(n)
      end
    end
    false
  end
end

class Interval
  attr_accessor :max, :min
  def initialize(str)
    parts = str.split('-')
    @min = parts[0].to_i
    @max = parts[1].to_i
  end

  def include?(n)
    @min <= n && n <= @max
  end
end