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

    coordinates = @matrix.first.each_index.to_a.product(@matrix.each_index.to_a)
    locs = coordinates.select { |x, y| @matrix[y][x] == 'A' }
    
    locs.each do |x,y|
      if check_x_mas(x,y)
        @xmas_count += 1
      end
    end

    puts @xmas_count

    @xmas_count
  end

  private

  def check_x_mas(y,x)
    if @matrix[x-1] && @matrix[x+1]
      if @matrix[x-1][y-1] && @matrix[x-1][y+1] && @matrix[x+1][y-1] && @matrix[x+1][y+1]
        puts "#{@matrix[x-1][y-1]}.#{@matrix[x+1][y-1]}"
        puts ".A."
        puts "#{@matrix[x-1][y+1]}.#{@matrix[x+1][y+1]}"
        puts ""

        if (['M','S'].sort == [@matrix[x-1][y-1], @matrix[x+1][y+1]].sort) && (['M','S'].sort == [@matrix[x-1][y+1], @matrix[x+1][y-1]].sort)
          puts "coords #{x},#{y}"
          true
        end
      end
    end
  end
end

TEST_OUTPUT = 9

if Runner.new('test.txt').run == TEST_OUTPUT
  puts Runner.new('input.txt').run
end
