require "pry"
require "sqlite3"
# require_relative "database.rb"
# require_relative "pokemon.rb"

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

	def initialize(evolution_request, name)
		@api_evolution = evolution_request
		@name = name
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

	def evolves?
		if (self.evolutions[0] == @name && self.evolutions[1] == nil) ||
			(self.evolutions[1] == @name && self.evolutions[2] == nil) ||
			(self.evolutions[2] == @name && self.evolutions[3] == nil)
			return false
		else
			return true
		end
	end
	
end