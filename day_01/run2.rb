class Runner
  def initialize(filename)
    @input = File.read(filename)
    @left = []
    @right = []
    @similarity_score = 0
  end

  def run
    parse_input
    @left = @left.tally
    @right = @right.tally

    @left.each do |n,t|
      t.times do
        if @right[n]
          @similarity_score += n * @right[n]
        end
      end
    end

    @similarity_score
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

TEST_OUTPUT = 31

if Runner.new('test.txt').run == TEST_OUTPUT
  puts Runner.new('input.txt').run
end
