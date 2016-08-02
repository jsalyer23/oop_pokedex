require "pry"
require "sqlite3"
require_relative "pokemon.rb"
require_relative "api.rb"
require_relative "database_orm.rb"

# This class searches all Pokemon from Pokedex
class PokedexSearch < PokedexAll

	attr_reader :input, :pokemon
	# input = search input
	# pokemon = Array of all Pokemon in database (pokedex.rb)
	def initialize(input=nil, pokemon=nil)
		@input = input
		@all_pokemon = pokemon
	end

	# Searches for any matching trait from add Pokemon returned from the database
	# 
	# RETURNS ASSOCIATIVE ARRAY (HASHES)
	def PokedexSearch.search(input)
		search_results = DATABASE.execute("SELECT * FROM pokemon WHERE name LIKE '%#{@input}%'
			OR gender LIKE '%#{@input}%' OR pokedex_id LIKE '%#{@input}%';")

		return search_results
	end

	# Searches for specific name
	#
	# RETURNS STRING OR FALSE
	def PokedexSearch.find_by_name(input)
		name_results = DATABASE.execute("SELECT * FROM pokemon WHERE name LIKE '%#{input}%';")
		if !name_results.empty?
			return name_results
		else
			return false
		end

	end

	# Gets all favorited Pokemon from the database as an Array of Hashes
	#
	# RETURNS ASSOCIATIVE ARRAY (HASHES)
	def PokedexSearch.select_favorites
		favorites = DATABASE.execute("SELECT * FROM pokemon WHERE favorite LIKE '%true%';")
		return favorites
	end

	# This method adds a Pokemon's type ID numbers to an Array
	#
	# RETURNS ARRAY
	def type_id
		types_id = [self.find_by_name["type1"], self.find_by_name["type2"]]
	binding.pry
		return types_id
	end

	# This method finds the Pokemon type names matching the type IDs
	#
	# RETURNS ASSOCIATIVE ARRAY
	def type_names
		types_names = DATABASE.execute("SELECT name FROM types WHERE id='#{self.type_id[0]}' OR id='#{self.type_id[1]}';")
		 	
		return types_names
	end

	# This method formats the type names to be displayed on the view
	#
	# RETURNS ARRAY
	def display_type_names
		if self.type_names[1] != nil
			type1 = self.type_names[0]["name"]
			type2 = ", " + self.type_names[1]["name"]
		else
			type1 = self.type_names[0]["name"]
			type2 = ""
		end
		names = [type1, type2]
		return names
	end

	def favorites
		return self.select_favorites
	end

end


