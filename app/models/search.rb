require "pry"
require "sqlite3"
require_relative "pokemon.rb"
require_relative "api.rb"
require_relative "database_orm.rb"



# This class searches all Pokemon from Pokedex
class PokedexSearch
	attr_writer :id, :pokedex_id, :name, :weight, :height, :gender, :favorite, :hp, :cp, :date_added, :evolves, :type1, :type2
	attr_reader :input, :id, :pokedex_id, :name, :weight, :height, :gender, :favorite, :hp, :cp, :date_added, :evolves, :type1, :type2
	# input = search input
	# pokemon = Array of all Pokemon in database (pokedex.rb)
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

	# Searches for any matching trait from a Pokemon returned from the database
	# 
	# RETURNS POKEMON OBJECT
	def self.search(input)
		object_array = []
		search_results = DATABASE.execute("SELECT * FROM pokemon WHERE name LIKE '%#{input}%'
			OR gender LIKE '%#{input}%' OR pokedex_id LIKE '%#{input}%';")
		search_results.each do |traits|

			object_array << PokedexSearch.new(traits["id"], traits["pokedex_id"], traits["name"], traits["weight"], traits["height"],
				traits["gender"], traits["favorite"], traits["hp"], traits["cp"], traits["date_added"], traits["evolves"],
				traits["type1"], traits["type2"])
		end
		object_array

	end



	# Searches for specific name
	#
	# RETURNS POKEMON OBJECT OR FALSE
	def self.find_by_name(input)
		instance = PokedexSearch.new
		name_results = DATABASE.execute("SELECT * FROM pokemon WHERE name LIKE '%#{input}%';")
		if !name_results.empty?
			traits = name_results[0]
			PokedexSearch.new(traits["id"], traits["pokedex_id"], traits["name"], traits["weight"], traits["height"],
				traits["gender"], traits["favorite"], traits["hp"], traits["cp"], traits["date_added"], traits["evolves"],
				traits["type1"], traits["type2"])
		else
			return false
		end

	end

	# Gets all favorited Pokemon from the database as an Array of Hashes
	#
	# RETURNS POKEMON OBJECTS
	def self.favorites
		favorites_array = DATABASE.execute("SELECT * FROM pokemon WHERE favorite LIKE '%true%';")
		object_array = []
		favorites_array.each do |traits|
			object_array << PokedexSearch.new(traits["id"], traits["pokedex_id"], traits["name"], traits["weight"], traits["height"],
				traits["gender"], traits["favorite"], traits["hp"], traits["cp"], traits["date_added"], traits["evolves"],
				traits["type1"], traits["type2"])
		end
		object_array
	end

	# This method adds a Pokemon's type ID numbers to an Array
	#
	# RETURNS ARRAY
	def type_id
		types_id = [self.type1, self.type2]
	
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

end

