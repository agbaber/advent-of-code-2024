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
        puts "#{report.inspect} safe"
      else
        found = false
        report.size.times.with_index do |i|
          if report_safe?(report.dup.tap{|a| a.delete_at(i)})
            @safe_count += 1
            puts "#{report.inspect} safe, removing #{report[i]} at position #{i}"
            found = true
            break
          end
        end

        unless found
          puts "#{report.inspect} unsafe"
        end
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

    safe
  end
end

TEST_OUTPUT = 4

if Runner.new('test.txt').run == TEST_OUTPUT
  puts Runner.new('input.txt').run
end
