require "httparty"
require "pry"
require "json"

class Pokemon

	def initialize(name, height, weight, gender, cp, hp, favorite, stage1, stage2, stage3, type)
		@name = name
		@height = height
		@weight = weight
		@gender = gender
		@type = type
		@cp = cp
		@hp = hp
		@favorite = favorite
		@stage1 = stage1
		@stage2 = stage2
		@stage3 = stage3
	end

	def name
		@name
	end

	def height
		@height
	end

	def weight
		@weight
	end

	def gender
		@gender
	end

	def type
		@type.join(",")
	end

	def cp
		@cp
	end

	def hp
		@hp
	end

	def favorite
		@favorite
	end

	def stage1
		@stage1
	end

	def stage2
		@stage2
	end

	def stage3
		@stage3
	end

	def traits
		pokemon = []
		pokemon.push(self.name, self.height, self.weight, self.gender,
			self.cp, self.hp, self.favorite, self.stage1,
			self.stage2, self.stage3, self.type)
		return pokemon
	end

end

class PokedexSave < Pokemon

	def initialize(pokemon, file)
		@pokemon = pokemon.traits
		@file = file
		
	end

	def save_pokemon
		require "csv"
		CSV.open(@file, "a") do |csv|
			csv << @pokemon
		end
	end
end

class PokedexAll

	def initialize(file)
		@file = file
	end

	def all_pokemon
		require "csv"
		pokemon_array= []
		CSV.foreach(@file) do |pokemon|
			pokemon_array.push(pokemon)
		end
		return pokemon_array
	end

	def pokemon_array
		return self.all_pokemon
	end

end

class PokedexSearch < PokedexAll

	def initialize(input, pokemon)
		@input = input
		@all_pokemon = pokemon.pokemon_array
	end

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

	def search_by_name
		@all_pokemon.each do |pokemon|
			if @input.capitalize == pokemon[0]
				return pokemon
			end
		end
		return false
	end

	def search_for_favorites
		favorites = []
		@all_pokemon.each do |pokemon|
			if pokemon[6] == "yes"
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

new_pokemon = Pokemon.new("Ninetales", 45, 100, "female", 67, 22, "no", "Vulpix", "Ninetales", "", ["fire", "normal"])
pokedex = PokedexSave.new(new_pokemon, "pokedex.csv")

pokedex.save_pokemon

pokemon = PokedexAll.new("pokedex.csv")

search_results = PokedexSearch.new("Vulpix", pokemon)

puts search_results.favorites














