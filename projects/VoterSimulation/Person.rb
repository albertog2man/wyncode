class Voter
attr_accessor :name, :party
	def initialize(name,party)
		@name,@party  = name, party
	end
end

class Politician < Voter
	attr_accessor :votes
	def initialize(name,party)
		@votes = 1
		super
	end
end