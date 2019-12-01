class Assembler
  attr_accessor :steps, :workers
  def initialize(input, no_workers)
    @steps = {}
    @workers = []
    no_workers.times { |_| @workers << Worker.new }
    input.each do |str|
      id = find_id(str)
      @steps[id] ||= Step.new(id)
      req_id = find_required_id(str)
      @steps[req_id] ||= Step.new(req_id)
      @steps[id].add_requirment(req_id)
    end
  end

  def run
    res = []
    ids = @steps.keys.sort
    done = []
    order = build_order(res, ids, done)
    puts order.join('')
    build(order)
  end

  def build(order)
    done = []
    delegated_steps = []
    1.step do |time|
      while (worker = free_worker) && (step = find_buildable?(order, delegated_steps, done))
        worker.start(step, time)
        delegated_steps << step.id
      end
      write_state(time, done)
      @workers.each do |w|
        step = w.is_done?(time)
        done << step if step
      end
      return time if done.length == order.length
    end
  end

  def find_buildable?(order, delegated_steps, done)
    order.each do |step|
      next if delegated_steps.include?(@steps[step].id)
      return @steps[step] if is_buildable?(@steps[step], done)
    end
    false
  end

  def write_state(time, done)
    puts "#{time} - #{@workers.map { |w| w.step || '.' }.join(' - ')} - #{done.join('')}"
  end

  def free_worker
    @workers.detect { |w| !w.busy? }
  end

  def build_order(res, ids, done)
    ids.each do |id|
      if is_buildable?(steps[id], done)
        res << id
        ids.delete(id)
        done << id
        return build_order(res, ids, done)
      end
    end
    res
  end

  def is_buildable?(step, done)
    return false unless step
    (step.requirements - done).empty?
  end

  def find_id(str)
    str[36]
  end

  def find_required_id(str)
    str[5]
  end
end

class Worker
  attr_accessor :done_at, :step

  def busy?
    !!@step
  end

  def is_done?(time)
    return false unless done_at == time
    @done_at = nil
    tmp = @step
    @step = nil
    tmp
  end

  def start(step, time)
    throw 'Busy' if busy?
    @step = step.id
    @done_at = time + @step.ord - 65 + 60
  end
end

class Step

  attr_accessor :requirements, :id

  def initialize(id)
    @id = id
    @requirements = []
  end

  def add_requirment(step)
    @requirements << step
  end
end