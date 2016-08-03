require "httparty"
require "pry"
require "json"

require_relative "api.rb"
require_relative "database_orm.rb"


# This class takes in data about a Pokemon, creating a new Pokemon for the Pokedex

class Pokemon
	attr_reader :name, :height, :weight, :gender, :type1, :type2, :cp, :hp, :favorite, :pokedex_id, :evolves
	attr_writer :name, :height, :weight, :gender, :type1, :type2, :cp, :hp, :favorite, :pokedex_id, :evolves
	# name, cp, hp, favorite, and gender are entered by the user
	#
	# height, weight, stages, and types come from the API request
	def initialize(pokedex_id=nil, name=nil, height=nil, weight=nil, gender=nil, favorite=nil, hp=nil, cp=nil, evolves=nil, type1=nil, type2=nil)
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
		# @pokemon = pokemon
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

	# This method saves a new Pokemon as a new row in the Pokemon table
	#
	# SAVES TO DATABASE (POKEMON TABLE)
	def self.save(pokemon)
		DATABASE.execute("INSERT INTO pokemon (pokedex_id, name, weight, height, gender, favorite, hp, cp, date_added, evolves, type1, type2)
			VALUES (\'#{pokemon.pokedex_id}\', \'#{pokemon.name}\', \'#{pokemon.height}\', \'#{pokemon.weight}\',
				\'#{pokemon.gender}\', \'#{pokemon.favorite}\', \'#{pokemon.hp}\', \'#{pokemon.cp}\', CURRENT_DATE,
				\'#{pokemon.evolves}\', \'#{pokemon.type1}\', \'#{pokemon.type2}\');")
	end

	def self.update(hp, cp, gender, favorite, id)
		DATABASE.execute("UPDATE pokemon SET hp=\'#{hp}\', cp=\'#{cp}\', gender=\'#{gender}\', favorite=\'#{favorite}\' 
			WHERE id=\'#{id}\';")
	end

end

