class AirplaneSeats
  def self.find_max(input)
    all_ids(input).max
  end

  def self.all_ids(input)
    input.map { |seat| get_id(seat) }
  end

  def self.find_missing(input)
    possibilities = []
    ids = all_ids(input)
    ids.each do |id|
      return id-1 if ids.include?(id-2) && !ids.include?(id-1)
    end
  end

  def self.get_id(seat)
    to_binary(seat).to_i(2)
  end

  def self.to_binary(seat)
    seat.split('').map { |c| (c == 'B' || c == 'R') ? '1' : '0'}.join('')
  end
end