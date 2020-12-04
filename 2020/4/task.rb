class PassportValidator
  
  EXPECTED_FIELDS = ['byr', 'iyr','eyr','hgt','hcl','ecl','pid']
  def self.validate(batch)
    passports(batch).select { |p| valid?(p) }.length
  end

  def self.validate_b(batch)
    passports(batch).select { |p| valid_b?(p) }.length
  end

  def self.valid_b?(passport)
    fields_with_values(passport).select { |field| valid_field?(field.first, field.last) }.length == 7
  end

  def self.valid?(passport)
    (fields(passport) & EXPECTED_FIELDS).length == 7
  end

  private

  def self.valid_field?(name, value)
    case name
    when 'byr'
      return value.length == 4 && (1920..2020).include?(value.to_i)
    when 'iyr'
      return value.length == 4 && (2010..2020).include?(value.to_i)
    when 'eyr'
      return value.length == 4 && (2020..2030).include?(value.to_i)
    when 'hgt'
      if value.end_with?('in')
        return (59..76).include?(value.to_i)
      elsif value.end_with?('cm')
        return (150..193).include?(value.to_i)
      end
      return false
    when 'hcl'
      return value.match(/^#([\da-f]){6}$/)
    when 'ecl'
      return ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].include?(value)
    when 'pid'
      return value.match(/^\d{9}$/)
    else
      return false
    end
  end

  def self.fields(passport)
    passport.split(/\s/).map {|s| s.split(':').first }
  end

  def self.fields_with_values(passport)
    passport.split(/\s/).map {|s| s.split(':') }
  end

  def self.passports(batch)
    batch.join('').split("\n\n")
  end
end


# byr (Birth Year)
# iyr (Issue Year)
# eyr (Expiration Year)
# hgt (Height)
# hcl (Hair Color)
# ecl (Eye Color)
# pid (Passport ID)
# cid (Country ID)