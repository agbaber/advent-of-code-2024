class Runner
  def initialize(filename)
    @input = File.read(filename)
  end

  def run
  end

  private

end

if Runner.new('test.txt').run == TEST_OUTPUT
  puts Runner.new('input.txt').run
end
