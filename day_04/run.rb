class Runner
  def initialize(filename)
    @input = File.read(filename)
    @matrix = []
    @xmas_count = 0
    @lines_to_check = []
  end

  def run
    @input.each_line do |line|
      @matrix << line.chomp.split('')
    end

    # rows, forward and back
    rows = @matrix

    # columns, forward and back
    columns = @matrix.transpose

    # puts @matrix.inspect
    # puts @matrix.size
    # diagonals, forward and back
    padding = @matrix.size - 1
    padded_matrix_1 = []

    @matrix.each do |row|
      inverse_padding = @matrix.size - padding
      padded_matrix_1 << ([nil] * inverse_padding) + row + ([nil] * padding)
      padding -= 1    
    end

    # puts padded_matrix_1.transpose.map(&:compact).inspect

    padding = @matrix.size - 1
    padded_matrix_2 = []
    @matrix.each do |row|
      inverse_padding = @matrix.size - padding
      padded_matrix_2 << ([nil] * inverse_padding) + row.reverse + ([nil] * padding)
      padding -= 1    
    end

    @lines_to_check << [
      rows.map(&:join),
      rows.map(&:reverse).map(&:join),
      columns.map(&:join),
      columns.map(&:reverse).map(&:join),
      padded_matrix_1.transpose.map(&:compact).map(&:join),
      padded_matrix_1.transpose.map(&:compact).map(&:reverse).map(&:join),
      padded_matrix_2.transpose.map(&:compact).map(&:join),
      padded_matrix_2.transpose.map(&:compact).map(&:reverse).map(&:join)
    ].compact

    @lines_to_check.flatten.each do |line|
      puts line
      puts line.scan(/(?=XMAS)/).count
      @xmas_count += line.scan(/(?=XMAS)/).count
    end

    # puts padded_matrix_2.transpose.map(&:compact).inspect

    @xmas_count
  end

  private
end

TEST_OUTPUT = 18

if Runner.new('test.txt').run == TEST_OUTPUT
  puts Runner.new('input.txt').run
end
