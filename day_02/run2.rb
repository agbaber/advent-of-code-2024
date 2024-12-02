class Runner
  def initialize(filename)
    @input = File.read(filename)
    @reports = []
    @safe_count = 0
  end

  def run
    parse_input
    @reports.each do |report|
      if report_safe?(report)
        @safe_count += 1
      end
    end

    @safe_count
  end

  private

  def parse_input
    @input.each_line do |line|
      @reports << line.split(' ').map(&:to_i)
    end
  end

  def report_safe?(report)
    safe = false
    output = report.map.with_index do |r, i|
      if report[i+1]
        r - report[i+1]
      end
    end.compact

    pos_array = output.map(&:positive?)
    pos_count = pos_array.count(true)
    neg_count = pos_array.count(false)

    if [0,1].include?(pos_count) || [0,1].include?(neg_count)
      tally = output.tally
      exceptions = tally.except(-3, -2, -1, 0, 1, 2, 3)
      total_exceptions = exceptions.map {|k,v| v }.inject(&:+)

      if total_exceptions.nil? || total_exceptions < 2
        safe = true
      end
    end

    puts report.inspect
    puts "pos count: #{pos_count.inspect}"
    puts "neg count: #{neg_count.inspect}"

    puts "output: #{output.inspect}"
    puts safe

    safe
  end
end

TEST_OUTPUT = 4

if Runner.new('test.txt').run == TEST_OUTPUT
  puts Runner.new('input.txt').run
end

# 394 too high