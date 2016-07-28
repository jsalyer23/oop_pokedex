require "httparty"
require "pry"
require "json"


# This class takes in data about a Pokemon, creating a new Pokemon for the Pokedex

class Pokemon
	# name, cp, hp, favorite, and gender are entered by the user
	#
	# height, weight, stages, and types come from the API request
	def initialize(pokedex_id, name, height, weight, gender, favorite, cp, hp)
		@name = name
		@height = height
		@weight = weight
		@gender = gender
		# @type = type
		@cp = cp
		@hp = hp
		@favorite = favorite
		# @stage1 = stage1
		# @stage2 = stage2
		# @stage3 = stage3
		@pokedex_id = pokedex_id
	end

	def date_today

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
			@favorite, @hp, @cp)
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

	# Save Pokemon to flat file
	#
	# SAVES DATA
	def save_pokemon
		require "csv"
		CSV.open(@file, "a") do |csv|
			csv << @pokemon
		end
	end

	def pokemon_columns
		columns = "pokemon (pokedex_id, name, weight, height, gender, favorite, hp, cp, date_added, evolves)"
		return columns
	end

	def pokemon_values
		values = @pokemon.join(", ")
		return values
	end

	def save_to_database
		require "sqlite3"
		DATABASE.execute("INSERT INTO #{self.pokemon_columns}
			VALUES (#{self.pokemon_values});")
	end
end

# This class retrieves all Pokemon from flat file
class PokedexAll

	# file = Pokedex file (flat storage)
	def initialize(file)
		@file = file
	end

	# Adds all Pokemon from Pokedex into an Array
	# 
	# RETURNS ARRAY
	def all_pokemon
		require "csv"
		pokemon_array= []
		CSV.foreach(@file) do |pokemon|
			pokemon_array.push(pokemon)
		end
		return pokemon_array
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
	# pokemon = Array of all Pokemon in Pokedex
	def initialize(input, pokemon)
		@input = input
		@all_pokemon = pokemon
	end

	# Searches for any matching trait
	# 
	# RETURNS ARRAY
	def search_all
		results_array = []
		found = "no"
		@all_pokemon.each do |pokemon|
			pokemon.each do |trait|
				if trait == @input && found == "no"
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
			if @input.capitalize == pokemon[0]
				return pokemon
			end
		end
		return false
	end

	# Adds favorited Pokemon to Array
	#
	# RETURNS ARRAY
	def search_for_favorites
		favorites = []
		@all_pokemon.each do |pokemon|
			if pokemon[6] == "on"
				favorites.push(pokemon)
			end
		end
		return favorites
	end

	def favorites
		return self.search_for_favorites
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
			return "None"
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
			return "None"
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
	end
end



# new_pokemon = Pokemon.new("Ninetales", 45, 100, "female", 67, 22, "no", "Vulpix", "Ninetales", "", ["fire", "normal"])
# pokedex = PokedexSave.new(new_pokemon, "pokedex.csv")

another_pokemon = Pokemon.new(9, "Blastoise", 423, 100, "Male", true, 67, 22)
pokedex2 = PokedexSave.new(another_pokemon.traits)

pokedex2.save_to_database
# yet_pokemon = Pokemon.new("Vulpix", 45, 100, "female", 67, 22, "no", "Vulpix", "Ninetales", "", ["fire", "normal"])
# pokedex3 = PokedexSave.new(yet_pokemon, "pokedex.csv")

# pokedex2.save_pokemon
# pokedex.save_pokemon
# pokedex3.save_pokemon

# pokemon = PokedexAll.new("pokedex.csv")

# search_results = PokedexSearch.new("Vulpix", pokemon)

# puts search_results.favorites












