require "pry"
require "sqlite3"

# This class handles the API requests
class ApiRequests

	# This method makes an API request for a specific Pokemon's GENERAL information
	#
	# RETURNS ASSOCIATIVE ARRAY (CONVERTED JSON)
	def pokemon_request(name)
		pokemon_request = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{name}")
		pokemon_data = Pokeapi.new(pokemon_request)
		return pokemon_data
	end

	# This method makes an API request for the Pokemon's SPECIES information
	#
	# pokemon_data = Array returned from pokemon_request()
	#
	# RETURNS ASSOCIATIVE ARRAY (CONVERTED JSON)
	def species_request(pokemon_data)
		species_request = HTTParty.get(pokemon_data.species_url)
		species = PokeapiSpecies.new(species_request)
		return species
	end

	# This method makes an API request for the Pokemon's EVOLUTION information
	#
	# species = Array returned from species_request()
	#
	# RETURNS ASSOCIATIVE ARRAY (CONVERTED JSON)
	def evolution_request(species)
		evolution_request = @evolutions = HTTParty.get("http://pokeapi.co/api/v2/evolution-chain/#{species.evolution_id}")
		evolutions = PokeapiEvolutions.new(evolution_request, @name)
		return evolutions
	end
end