require "httparty"
require "pry"
require "json"

require_relative "api.rb"
require_relative "database_orm.rb"


# This class takes in data about a Pokemon, creating a new Pokemon for the Pokedex

class Pokemon
	include InstanceMethods
	# extend ClassMethods
	attr_accessor :id, :name, :height, :weight, :gender, :type1, :type2, :cp, :hp, :favorite, :pokedex_id, :evolves, :evolution_id

	COLUMNS = "pokemon (pokedex_id, name, weight, height, gender, favorite, hp, cp, date_added, evolves, type1, type2, evolution_id)"
	# name, cp, hp, favorite, and gender are entered by the user
	#
	# height, weight, stages, and types come from the API request
	def initialize(attrs)
		@id = attrs["id"]
		@pokedex_id = attrs["pokedex_id"]
		@name = attrs["name"]
		@weight = attrs["weight"]
		@height = attrs["height"]
		@gender = attrs["gender"]
		@favorite = attrs["favorite"]
		@hp = attrs["hp"]
		@cp = attrs["cp"]
		@evolves = attrs["evolves"]
		@type1 = attrs["type1"]
		@type2 = attrs["type2"]
		@evolution_id = attrs["evolution_id"]
		
	end

	# This method saves a new Pokemon as a new row in the Pokemon table
	#
	# SAVES TO DATABASE (POKEMON TABLE)
	def self.save(pokemon)
		DATABASE.execute("INSERT INTO #{COLUMNS} VALUES (\'#{pokemon.pokedex_id}\', \'#{pokemon.name}\', \'#{pokemon.height}\', \'#{pokemon.weight}\',
				\'#{pokemon.gender}\', \'#{pokemon.favorite}\', \'#{pokemon.hp}\', \'#{pokemon.cp}\', CURRENT_DATE,
				\'#{pokemon.evolves}\', \'#{pokemon.type1}\', \'#{pokemon.type2}\', \'#{pokemon.evolution_id}\');")
		pokemon.id = DATABASE.last_insert_row_id
		return pokemon
	
	end

	def self.update(attrs)
		DATABASE.execute("UPDATE pokemon SET hp=\'#{@hp}\', cp=\'#{@cp}\', gender=\'#{@gender}\', favorite=\'#{@favorite}\' 
			WHERE id=\'#{@id}\';")
	end

end

