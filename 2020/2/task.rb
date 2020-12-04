class PasswordValidator

  def validate_list(list)
    list.select { |item| validate(item) }.length
  end

  def validate(string)
    parts = string.split(" ")
    letter = parts[1][0]
    n = parts[2].split('').select {|l| l == letter }.length
    limits = parts[0].split('-').map(&:to_i)
    n >= limits[0] && n <= limits[1]
  end

  def validate_list_b(list)
    list.select { |item| validate_b(item) }.length
  end

  def validate_b(string)
    parts = string.split(" ")
    letter = parts[1][0]
    limits = parts[0].split('-').map(&:to_i)
    a = parts[2][limits[0]-1]
    b = parts[2][limits[1]-1]
    (a == letter || b == letter) && a != b
  end
end