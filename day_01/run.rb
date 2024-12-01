class Runner
  def initialize(filename)
    @input = File.read(filename)
    @left = []
    @right = []
    @diff = 0
  end

  def run
    parse_input
    @left = @left.sort
    @right = @right.sort

    @left.each_with_index do |n, i|
      @diff += (n - @right[i]).abs
    end

    @diff
  end

  private

  def parse_input
    @input.each_line do |line|
      split = line.split('   ')
      @left << split[0].to_i
      @right << split[1].to_i
    end
  end
end

TEST_OUTPUT = 11

if Runner.new('test.txt').run == TEST_OUTPUT
  puts Runner.new('input.txt').run
end
