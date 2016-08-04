require "pry"
require "sqlite3"
require_relative "pokemon.rb"
require_relative "api.rb"
require_relative "database_orm.rb"



# This class searches all Pokemon from Pokedex
class Pokedex
	include InstanceMethods
	attr_accessor :id, :pokedex_id, :name, :weight, :height, :gender, :favorite, :hp, :cp, :date_added, :evolves, :type1, :type2, :evolution_id
	attr_reader :input
	TABLE = "pokemon"
	SELECTOR = "id"
	# input = search input
	# pokemon = Array of all Pokemon in database (pokedex.rb)
	def initialize(attrs=nil)
		@id = attrs["id"]
		@pokedex_id = attrs["pokedex_id"]
		@name = attrs["name"]
		@weight = attrs["weight"]
		@height = attrs["height"]
		@gender = attrs["gender"]
		@favorite = attrs["favorite"]
		@hp = attrs["hp"]
		@cp = attrs["cp"]
		@date_added = attrs["date_added"]
		@evolves = attrs["evolves"]
		@type1 = attrs["type1"]
		@type2 = attrs["type2"]
		@evolution_id = attrs["evolution_id"]
		
	end

	# Adds all Pokemon from database into an Array
	# 
	# RETURNS ASSOCIATIVE ARRAY (HASHES)
	def self.all_pokemon
		require "sqlite3"
		objects_array = []
		all_pokemon = DATABASE.execute("SELECT * FROM pokemon;")

		all_pokemon.each do |traits|
			objects_array << Pokedex.new(traits["id"], traits["pokedex_id"], traits["name"], traits["weight"], traits["height"],
				traits["gender"], traits["favorite"], traits["hp"], traits["cp"], traits["date_added"], traits["evolves"],
				traits["type1"], traits["type2"], traits["evolution_id"])
		end
		return objects_array
	end

	# Searches for any matching trait from a Pokemon returned from the database
	# 
	# RETURNS POKEMON OBJECT
	def self.search(input)
		object_array = []
		search_results = DATABASE.execute("SELECT * FROM pokemon WHERE name LIKE '%#{input}%'
			OR gender LIKE '%#{input}%' OR pokedex_id LIKE '%#{input}%';")
		search_results.each do |traits|

			object_array << Pokedex.new(traits["id"], traits["pokedex_id"], traits["name"], traits["weight"], traits["height"],
				traits["gender"], traits["favorite"], traits["hp"], traits["cp"], traits["date_added"], traits["evolves"],
				traits["type1"], traits["type2"], traits["evolution_id"])
		end
		object_array

	end



	# Searches for specific name
	#
	# RETURNS POKEMON OBJECT OR FALSE
	def self.find(id)
		name_results = DATABASE.execute("SELECT * FROM #{TABLE} WHERE #{SELECTOR} LIKE '%#{id['id']}%';")
		if !name_results.empty?
			traits = name_results[0]
			Pokedex.new(traits["id"], traits["pokedex_id"], traits["name"], traits["weight"], traits["height"],
				traits["gender"], traits["favorite"], traits["hp"], traits["cp"], traits["date_added"], traits["evolves"],
				traits["type1"], traits["type2"], traits["evolution_id"])
			binding.pry
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
			object_array << Pokedex.new(traits["id"], traits["pokedex_id"], traits["name"], traits["weight"], traits["height"],
				traits["gender"], traits["favorite"], traits["hp"], traits["cp"], traits["date_added"], traits["evolves"],
				traits["type1"], traits["type2"], traits["evolution_id"])
		end
		object_array
	end

end

