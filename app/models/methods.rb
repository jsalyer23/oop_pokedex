require "httparty"
require "pry"
require "json"


# This class takes in data about a Pokemon, creating a new Pokemon for the Pokedex

class Pokemon
	# name, cp, hp, favorite, and gender are entered by the user
	#
	# height, weight, stages, and types come from the API request
	def initialize(pokedex_id, name, height, weight, gender, favorite, hp, cp, evolves, type1, type2)
		@name = name
		@height = height
		@weight = weight
		@gender = gender
		@type1 = type1
		@type2 = type2
		@cp = cp
		@hp = hp
		@favorite = favorite
		@pokedex_id = pokedex_id
		@evolves = evolves
	end

	# Converts Array into String
	#
	# RETURNS STRING
	def type
		@type.join(",")
	end

	# Adds all traits to Array
	#
	# RETURNS ARRAY
	def traits
		pokemon = []
		pokemon.push(@pokedex_id, @name, @height, @weight, @gender,
			@favorite, @hp, @cp, @evolves, @type1, @type2)
		return pokemon
	end

end

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

	# Gets all favorited Pokemon from the database as an Array of Hashes
	#
	# RETURNS ASSOCIATIVE ARRAY (HASHES)
	def select_favorites
		favorites = DATABASE.execute("SELECT * FROM pokemon WHERE favorite LIKE '%true%';")
		return favorites
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

# This class deals with the initial API request using name
class Pokeapi

	def initialize(api_request)
		@api = api_request
	end

	# This method finds the species URL from within the request
	#
	# RETURNS STRING (URL)
	def species_url
		return @api["species"]["url"]
	end

	# This method finds the Pokemon's Pokedex number
	#
	# RETURNS INTEGER (FIXNUM)
	def id
		return @api["id"]
	end

	# This method adds the abilities to an Array to be used for our API
	#
	# RETURNS ARRAY
	def abilities
		abilities = []
		@api["abilities"].each do |i|
			abilities.push(i["ability"]["name"])
		end
		return abilities
	end

	# This method adds the Pokemon's type(s) to an Array
	#
	# RETURNS ARRAY
	def types
		types = []
		@api["types"].each do |i|
			types.push(i["type"]["name"].capitalize)
		end
		return types
	end

	def database_types
		types_table = DATABASE.execute("SELECT id FROM types WHERE name='#{self.types[0]}' OR name='#{self.types[1]}';")
		return types_table
	end

	def get_type_id
		type_ids = [self.database_types[0]["id"]]

		if self.database_types[1] == nil
			type_ids[1] = nil
		else
			type_ids[1] = self.database_types[1]["id"]
		end
		return type_ids

	end

	# This method finds the height from the API request
	#
	# RETURNS INTEGER (FIXNUM)
	def height
		return @api["height"]
	end

	# This method finds the weight from the API request
	#
	# RETURNS INTEGER (FIXNUM)
	def weight
		return @api["weight"]
	end
end

# This class deals with the species info from species API request
class PokeapiSpecies

	def initialize(species_request)
		@api_species = species_request
	end

	# This method selects the evolution chain URL
	#
	# RETURNS STRING (URL)
	def evolution_url
		@api_species["evolution_chain"]["url"]
	end

	# This method selects the evolution chain ID from the evolution chain URL
	#
	# RETURNS STRING (INTEGER)
	def evolution_id
		species2 = self.evolution_url.split("n/")
		id = species2[1].split("/")
		return id.join("")
	end
end

# This class gathers the evolution stages for a Pokemon, takes in evolution request from API
class PokeapiEvolutions

	def initialize(evolution_request)
		@api_evolution = evolution_request
	end

	# This method selects the name of the first stage
	#
	# RETURNS STRING
	def stage1
		return @api_evolution["chain"]["species"]["name"]
	end

	# This method selects the name of the second stage if it exists
	#
	# RETURNS STRING
	def stage2
		if @api_evolution["chain"]["evolves_to"][0] == nil ||
			@api_evolution["chain"]["evolves_to"][0]["species"] == nil ||
			@api_evolution["chain"]["evolves_to"][0]["species"]["name"] == nil
			return nil
		else
			return @api_evolution["chain"]["evolves_to"][0]["species"]["name"]
		end
	end

	# This method selects the name of the third stage if it exists
	#
	# RETURNS STRING
	def stage3
		if @api_evolution["chain"]["evolves_to"][0] == nil ||
			@api_evolution["chain"]["evolves_to"][0]["evolves_to"][0] == nil ||
			@api_evolution["chain"]["evolves_to"][0]["evolves_to"][0]["species"] == nil ||
			@api_evolution["chain"]["evolves_to"][0]["evolves_to"][0]["species"]["name"] == nil
			return nil
		else
			return @api_evolution["chain"]["evolves_to"][0]["evolves_to"][0]["species"]["name"]
		end
	end

	# This method adds the results of stage1, stage2, and stage3 to an Array
	#
	# RETURNS ARRAY
	def evolutions
		evolutions = []
		evolutions.push(self.stage1, self.stage2, self.stage3)
		return evolutions
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

	# This method saves evolution data to the evolutions table in database
	#
	# SAVES TO DATABASE (EVOLUTIONS TABLE)
	def save_evolution_table
		require "sqlite3"
		DATABASE.execute("INSERT INTO evolutions (#{self.evolution_columns}) VALUES #{self.evolution_values};")
	end
end





# new_pokemon = Pokemon.new("Ninetales", 45, 100, "female", 67, 22, "no", "Vulpix", "Ninetales", "", ["fire", "normal"])
# pokedex = PokedexSave.new(new_pokemon, "pokedex.csv")

# another_pokemon = Pokemon.new(9, "Blastoise", 423, 100, "Male", true, 67, 22, true)
# pokedex2 = PokedexSave.new(another_pokemon.traits)

# pokedex2.save_to_database
# yet_pokemon = Pokemon.new("Vulpix", 45, 100, "female", 67, 22, "no", "Vulpix", "Ninetales", "", ["fire", "normal"])
# pokedex3 = PokedexSave.new(yet_pokemon, "pokedex.csv")

# pokedex2.save_pokemon
# pokedex.save_pokemon
# pokedex3.save_pokemon

# pokemon = PokedexAll.new("pokedex.csv")

# search_results = PokedexSearch.new("Vulpix", pokemon)

# puts search_results.favorites












