class Runner
  def initialize(filename)
    @input = File.read(filename)
  end

  def run
    @input.scan(/(mul\(\d+,\d+\))/).map do |r|
      r[0].match(/(\d+),(\d+)/)
    end.map do |md|
      md[1].to_i * md[2].to_i
    end.inject(&:+)
  end

  private

end

TEST_OUTPUT = 161

if Runner.new('test.txt').run == TEST_OUTPUT
  puts Runner.new('input.txt').run
end
