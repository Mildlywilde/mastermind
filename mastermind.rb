class Peg
	attr_reader :color
	attr_reader :matched
	def initialize(color)
		@color = color
		@matched = false
	end

	def matchify
		@matched = true
	end

	def unmatchify
		@matched = false
	end
end

class Code
	attr_reader :val
	def initialize(val= nil)
		unless val == nil
			@val = val
		else
			@val = {}
			random
		end
	end

	def pegs
		self.val.values
	end

	def unmatchedcolors
		unmatched = self.pegs.select { |peg|   peg.matched == false }
		unmatched.map { |peg| peg.color}
	end 

	private

	def random
		4.times do |x|
			color = nil
			num = 1 + rand(6)
			case num
			when 1
				color = "Red"
			when 2
				color = "White"
			when 3
				color = "Blue"
			when 4
				color = "Yellow"
			when 5
				color = "Green"
			when 6
				color = "Pink"
			end
			@val[x+1] = Peg.new(color)
		end
	end
end

class Guess
	def initialize(col1, col2, col3, col4)
		@sequence = {1 => Peg.new(col1), 2 => Peg.new(col2), 3 => Peg.new(col3), 4 => Peg.new(col4)}
	end

	def compare(code)
		code.pegs.each {|peg| peg.unmatchify}
		exact = 0
		misplaced = 0
		@sequence.each do |position, peg|
			if peg.color == code.val[position].color
				exact += 1
				code.val[position].matchify
			end
		end
		@sequence.each do |position, peg|
			if code.unmatchedcolors.include?(peg.color)
				misplaced += 1
			end
		end
		puts "#{exact} correct, #{misplaced} in the wrong place"
	end

end

code = Code.new
victory = false
while victory == false do
	puts "Make a guess"
	guess = Guess.new(gets.chomp.capitalize, gets.chomp.capitalize, gets.chomp.capitalize, gets.chomp.capitalize)
	guess.compare(code)
end