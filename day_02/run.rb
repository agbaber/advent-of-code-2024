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
    safe = true
    down = report[0] > report[-1]

    unless down
      report = report.reverse
    end

    report.each.with_index do |floor, i|
      if report[i+1]
        unless [1,2,3].include?(floor - report[i+1])
          safe = false
        end
      end
    end

    puts "#{report}: safe: #{safe}"

    safe
  end
end

TEST_OUTPUT = 2

if Runner.new('test.txt').run == TEST_OUTPUT
  puts Runner.new('input.txt').run
end
