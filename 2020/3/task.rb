class Slope
  def self.check_slopes(input, slopes)
    slopes.map { |slope| self.descend(input, slope[0], slope[1]) }
      .inject(&:*)
  end

  def self.descend(input, m, n)
    trees, i, j = 0, 0, 0
    length = input.first.length
    height = input.length
    while j < height
      trees += 1 if input[j][i] == '#'
      j += m
      i = (i + n)% length
    end
    trees
  end
end