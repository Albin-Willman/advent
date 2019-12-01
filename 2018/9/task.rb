class MarbleGame
  attr_accessor :current_index, :players, :circle, :last_marble

  def initialize(num_players, last_marble)
    @last_marble = last_marble
    @players = Array.new(num_players, 0)
    @circle = [0]
    @current_index = 0
  end

  def run
    (1..@last_marble).each do |i|
      (i % 23 == 0) ? add_score(i) : add_marble(i)
      puts "#{i} - #{@current_index} - #{@players.max}" if i % 100_000 == 0
    end
  end

  def add_score(i)
    index = (@current_index - 7) % @circle.length
    @players[i % @players.length] += (i + @circle[index])
    @circle.delete_at(index)
    @current_index = (index) % @circle.length
  end

  def add_marble(i)
    @current_index = ((@current_index + 1) % @circle.length + 1)
    @circle.insert(@current_index, i)
  end
end