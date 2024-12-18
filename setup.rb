(1..24).to_a.each do |num|
  day = "%.2i" % num
  Dir.mkdir("day_#{day}")
  File.open("day_#{day}/input.txt", "w")
  File.open("day_#{day}/test.txt", "w")
  File.open("day_#{day}/run2.rb", "w")

  File.open("day_#{day}/run.rb", "w") do |f|
    text = <<~EOF
      class Runner
        def initialize(filename)
          @input = File.read(filename)
          @parsed_input = []
        end

        def run
          parse_input
        end

        private

        def parse_input
          @input.each_line do |line|
            @parsed_input << line # line parsing goes here
          end
        end

      end

      TEST_OUTPUT = 'somevalue'

      if Runner.new('test.txt').run == TEST_OUTPUT
        puts Runner.new('input.txt').run
      end
    EOF

    f.write(text)
  end
end