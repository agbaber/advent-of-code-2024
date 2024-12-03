class Runner
  def initialize(filename)
    @input = File.read(filename)
    @tally = 0
  end

  def run
    puts @input
    split_on_dont = @input.split("don't()")
    first_instructions = split_on_dont[0]

    split_on_dont[1..-1].each do |split|
      split.split("do()")[1..-1].each do |valid|
        @tally += sum_muls(valid)
      end
    end

    @tally += sum_muls(first_instructions)
  end

  private

  def sum_muls(input)
    input.scan(/(mul\(\d+,\d+\))/).map do |r|
      r[0].match(/(\d+),(\d+)/)
    end.map do |md|
      md[1].to_i * md[2].to_i
    end.inject(&:+)
  end
end

TEST_OUTPUT = 48

if Runner.new('test2.txt').run == TEST_OUTPUT
  puts Runner.new('input.txt').run
end

# 58357782 too low
# 76911921 just right
# 97765677 too high
# 101939581 too high