require "./Person.rb"
class VoterSimulation
	def initialize 
		@list_of_politicians = []
		@list_of_voters = []
	end
	def  main_menu 
		puts "What would you like to do?"
		puts "(C)reate, (L)ist, (U)pdate, or (V)ote"
		options_select(create: "C", list: "L", update: "U", vote: "V")
	end
	def create
		puts "What wpuld you like to create?"
		puts "(P)oltican or (V)oter"
		options_select(create_politician: "P", create_voter: "V")
	end
	def create_politician
		puts "Enter name"
		get_name
		puts "Enter political party"
		puts "(R)epublican or (D)emocrat"
		@party = political_party(get_input("create_politician","R","D"))
		@list_of_politicians << Politician.new(@name,@party)
		puts "You've created #{@name} the #{@party}"
		main_menu
	end
	def create_voter
		puts "Enter name"
		get_name
		puts "Enter political affiliation"
		puts "(L)iberal, (C)onservative, (T)ea Party, (S)ocialist, or (N)eutral"
		@party = political_party(get_input("create_voter","L","C","T","S","N"))
		@list_of_voters << Voter.new(@name,@party)
		puts "You've created #{@name} the #{@party}"
		main_menu
	end
	def political_party(party_entered)
		case party_entered
		when "R"
			"Republican"
		when "D"
			"Democrat"
		when "L"
			"Liberal"
		when "C"
			"Conservative"
		when "T"
			"Tea Party"
		when "S"
			"Socialist"
		when "N"
			"Neutral"
		end
	end
	def list
		puts "----Voters---"
		@list_of_voters.each do |i|
			puts "#{i.name}, #{i.party}"
		end
		puts ''
		puts "--Politicians--"
		@list_of_politicians.each do |i|
			puts "#{i.name}, #{i.party}"
		end
		sleep(1)
		main_menu
	end
	def update
		puts "who would you like to update?"
		@name = gets.chomp
		@list_of_politicians.each do |i|
			if @name = i.name
				puts "New name?"
				i.name = gets.chomp
				puts "New Party?"
				puts "(R)epublican or (D)emocrat"
				i.party = political_party(get_input("update","R","D"))
				main_menu
			end
		end
		@list_of_voters.each do |i|
			if @name = i.name
				puts "New name?"
				i.name = gets.chomp
				puts "New Party?"
				puts "(C)reate, (L)ist, (U)pdate, or (V)ote"
				get_input("C","L","U","V")
				i.party = political_party(get_input("update","R","D"))
				main_menu
			end
		end
		puts "No one by that name found!"
		main_menu
	end
	def vote 
		@democrats =[]
		@republicans =[]
		@list_of_politicians.each do |i|
			if i.party == "Democrat"
				@democrats << i
			else 
				@republicans << i
			end
		end
		@list_of_voters.each do |i|
			vote_odds(i.party)
		end
		vote_results
	end
	def vote_odds(partys)
		case partys
		when "Socialist"
			do_vote(90)
		when "Liberal"
			do_vote(75)
		when "Conservative"
			do_vote(25)
		when "Tea Party"
			do_vote(10)
		when "Neutral"
			do_vote(50)
		end
	end
	def do_vote(probability)
		if (Random.rand(100)+1) < probability
			vote_random_democrat
		else
			vote_random_republican
		end
	end
	def vote_random_republican
		@republicans[Random.rand(@republicans.length)].votes += 1
	end
	def vote_random_democrat
		@democrats[Random.rand(@democrats.length)].votes += 1
	end
	def vote_results
		puts "--Politicians--"
		@list_of_politicians.each do |i|
			puts "#{i.name}, #{i.party} #{i.votes}"
		end
	end
	def options_select(options = {})
		answers = options.values
		@input = gets.chomp.capitalize
		if answers.any? { |i| @input == i }
			send(options.key(@input))
		else
			puts "Invalid Answer!"
			main_menu
		end
	end
	def get_input(from,*args)
		@input = gets.chomp.capitalize
		if args.any? { |i| @input == i }
			@input
		else
			puts "Invalid Answer!"
			send(from)
		end
	end
	def get_name
		@input = gets.chomp.capitalize
		if !@input.chars.any? { |i| (i >="A" && i <= "z")|| i == " " }
			puts "invalid character, only enter letters and spaces"
			puts "Enter name"
			get_name
		end
		@name = @input
	end
end
vote = VoterSimulation.new
vote.main_menu