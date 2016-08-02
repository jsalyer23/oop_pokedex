require "pry"
require "sqlite3"
require_relative "pokemon.rb"
require_relative "api.rb"
require_relative "database_orm.rb"

# This class saves new Pokemon to flat storage
class PokedexSave < Pokemon

	# pokemon = Array returned from Pokemon.traits
	# file = File to save to
	def initialize(pokemon=nil)
		@pokemon = pokemon
		# @file = file
		
	end

	# This method puts all of the columns for the Pokemon table into a string
	#
	# RETURNS STRING
	def pokemon_columns
		columns = "pokedex_id, name, weight, height, gender, favorite, hp, cp, date_added, evolves, type1, type2"
		return columns
	end

	# This method adds all the traits for a new Pokemon into a string
	#
	# RETURNS STRING
	def pokemon_values
		values = "(\'#{@pokemon[0]}\', \'#{@pokemon[1]}\', \'#{@pokemon[2]}\', \'#{@pokemon[3]}\',
				\'#{@pokemon[4]}\', \'#{@pokemon[5]}\', \'#{@pokemon[6]}\', \'#{@pokemon[7]}\', CURRENT_DATE,
				\'#{@pokemon[8]}\', \'#{@pokemon[9]}\', \'#{@pokemon[10]}\')"
		return values
	end

	# This method saves a new Pokemon as a new row in the Pokemon table
	#
	# SAVES TO DATABASE (POKEMON TABLE)
	def self.save(pokemon)
		instance = PokedexSave.new(pokemon)
		DATABASE.execute("INSERT INTO pokemon (#{instance.pokemon_columns})
			VALUES #{instance.pokemon_values};")
	end

	def self.update_pokemon(hp, cp, gender, favorite, id)
		DATABASE.execute("UPDATE pokemon SET hp=\'#{hp}\', cp=\'#{cp}\', gender=\'#{gender}\', favorite=\'#{favorite}\' 
			WHERE id=\'#{id}\';")
	end

end

# This class retrieves all Pokemon from flat file
class PokedexAll
	attr_reader :id, :pokedex_id, :name, :weight, :height, :gender, :favorite, :hp, :cp, :date_added, :evolves, :type1, :type2
	attr_writer :id, :pokedex_id, :name, :weight, :height, :gender, :favorite, :hp, :cp, :date_added, :evolves, :type1, :type2
	
	def initialize(id=nil, pokedex_id=nil, name=nil, weight=nil, height=nil, gender=nil, favorite=nil, hp=nil, cp=nil,
				 date_added=nil, evolves=nil, type1=nil, type2=nil)
		@id = id
		@pokedex_id = pokedex_id
		@name = name
		@weight = weight
		@height = height
		@gender = gender
		@favorite = favorite
		@hp = hp
		@cp = cp
		@date_added = date_added
		@evolves = evolves
		@type1 = type1
		@type2 = type2
		
	end
	# Adds all Pokemon from database into an Array
	# 
	# RETURNS ASSOCIATIVE ARRAY (HASHES)
	def self.all_pokemon
		require "sqlite3"
		objects_array = []
		all_pokemon = DATABASE.execute("SELECT * FROM pokemon;")
		all_pokemon.each do |traits|
			objects_array << PokedexAll.new(traits["id"], traits["pokedex_id"], traits["name"], traits["weight"], traits["height"],
				traits["gender"], traits["favorite"], traits["hp"], traits["cp"], traits["date_added"], traits["evolves"],
				traits["type1"], traits["type2"])
		end
		return objects_array
		binding.pry
	end

end








