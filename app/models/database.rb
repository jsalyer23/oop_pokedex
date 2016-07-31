require "pry"
require "sqlite3"
require_relative "pokemon.rb"
require_relative "api.rb"

# This class saves new Pokemon to flat storage
class PokedexSave < Pokemon

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


end

# This class retrieves all Pokemon from flat file
class PokedexAll

	# Adds all Pokemon from database into an Array
	# 
	# RETURNS ASSOCIATIVE ARRAY (HASHES)
	def all_pokemon
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

# This class searches all Pokemon from Pokedex
class PokedexSearch < PokedexAll

	# input = search input
	# pokemon = Array of all Pokemon in database (pokedex.rb)
	def initialize(input, pokemon)
		@input = input
		@all_pokemon = pokemon
	end

	# Searches for any matching trait from add Pokemon returned from the database
	# 
	# RETURNS ASSOCIATIVE ARRAY (HASHES)
	def search_all
		results_array = []
		found = "no"
		@all_pokemon.each do |pokemon|
			pokemon.each do |trait|
				if pokemon[trait] == @input && found == "no"
					results_array.push(pokemon)
					found = "yes"
				end
			end
		end
		return results_array
	end

	def search_database
		search_results = DATABASE.execute("SELECT * FROM pokemon WHERE name LIKE '%#{@input}%'
			OR gender LIKE '%#{@input}%' OR pokedex_id LIKE '%#{@input}%';")
		return search_results
	end

	# Searches for specific name
	#
	# RETURNS STRING OR FALSE
	def search_by_name
		@all_pokemon.each do |pokemon|
			if @input.capitalize == pokemon["name"]
				return pokemon
			end
		end
		return false
	end

	def search_by_id
		@all_pokemon.each do |pokemon|
			
			if @input.to_i == pokemon["id"]
				return pokemon
			end
		end
		return false

	end

	

	# Gets all favorited Pokemon from the database as an Array of Hashes
	#
	# RETURNS ASSOCIATIVE ARRAY (HASHES)
	def select_favorites
		favorites = DATABASE.execute("SELECT * FROM pokemon WHERE favorite LIKE '%true%';")
		return favorites
	end

	def type_id
		types_id = [self.search_by_name["type1"], self.search_by_name["type2"]]
		return types_id
	end

	def type_names
		types_names = DATABASE.execute("SELECT name FROM types WHERE id='#{self.type_id[0]}' OR id='#{self.type_id[1]}';")
		return types_names
	end

	# Adds favorited Pokemon to Array
	#
	# RETURNS ARRAY
	def favorites_array
		favorites = []
		@all_pokemon.each do |pokemon|
			if pokemon[6] == "on"
				favorites.push(pokemon)
			end
		end
		return favorites
	end

	def favorites
		return self.select_favorites
	end

	def all_results
		return self.search_all
	end

	def name_results
		return self.search_by_name
	end

end



# This class formats and saves evolution data to the database
class DatabaseEvolutions < PokeapiEvolutions

	def initialize(evolutions, evolution_id)
		@evolutions = evolutions
		@id = evolution_id
	end

	# This method formats the columns in the evolutions table
	#
	# RETURNS STRING
	def evolution_columns
		columns = "evolution_id, stage1, stage2, stage3"
		return columns
	end

	# This method adds evolution chain id and stages to evoutions table
	#
	# RETURNS STRING
	def evolution_values
		values = "(\'#{@id}\', \'#{@evolutions[0]}\', \'#{@evolutions[1]}\', \'#{@evolutions[2]}\')"
		return values
	end

	def chain_exists?
		evolution_table = DATABASE.execute("SELECT evolution_id FROM evolutions;")
		evolution_table.each do |row|
			if row["evolution_id"] == @id
				return true
			end
		end
	end

	def evolution_chain
		evolution_chains = DATABASE.execute("SELECT * FROM evolutions WHERE stage1='#{@id.downcase}' OR stage2='#{@id.downcase}' OR stage3='#{@id.downcase}';")
		binding.pry
		return evolution_chains
	end

	# This method saves evolution data to the evolutions table in database
	#
	# SAVES TO DATABASE (EVOLUTIONS TABLE)
	def save_evolution_table
		require "sqlite3"
		if self.chain_exists? != true
			DATABASE.execute("INSERT INTO evolutions (#{self.evolution_columns}) VALUES #{self.evolution_values};")
		end
	end
end







