require "pry"
require "sqlite3"
require_relative "pokemon.rb"
require_relative "api.rb"
require_relative "database_orm.rb"

# This class saves new Pokemon to flat storage
class PokedexSave < Pokemon
	include Database
	# pokemon = Array returned from Pokemon.traits
	# file = File to save to
	def initialize(pokemon)
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
	def save_to_database
		require "sqlite3"
		DATABASE.execute("INSERT INTO pokemon (#{self.pokemon_columns})
			VALUES #{self.pokemon_values};")
	end

	def self.update_pokemon(hp, cp, gender, favorite, id)
		DATABASE.execute("UPDATE pokemon SET hp=\'#{hp}\', cp=\'#{cp}\', gender=\'#{gender}\', favorite=\'#{favorite}\' 
			WHERE id=\'#{id}\';")
	end

end

# This class retrieves all Pokemon from flat file
class PokedexAll
	include Database
	# Adds all Pokemon from database into an Array
	# 
	# RETURNS ASSOCIATIVE ARRAY (HASHES)
	def self.all_pokemon
		require "sqlite3"
		all_pokemon = DATABASE.execute("SELECT * FROM pokemon;")
		return all_pokemon
	end

	# Returns all Pokemon
	#
	# RETURNS ARRAY
	def pokemon_array
		return self.all_pokemon
	end

end








