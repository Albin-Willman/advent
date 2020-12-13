class Form
  def self.evaluate(input, yes_answers)
     group_answers(input).map { |a| (a & yes_answers).length }.sum
  end
  def self.evaluate_b(input, yes_answers)
     groups(input).map { |g| evaluate_group(g, yes_answers).length }.sum
  end
  def self.evaluate_group(group, yes_answers)
    answers = yes_answers
    group.split("\n").each do |a|
      answers = answers & a.split('').uniq
    end
    answers
  end
  def self.group_answers(input)
    groups(input).map {|g| (g.split('').uniq) }
  end
  def self.groups(batch)
    batch.join('').split("\n\n")
  end
end