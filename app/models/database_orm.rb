require "pry"
require "sqlite3"

module Database

	def all_pokemon
		objects_array = []
		all_pokemon = DATABASE.execute("SELECT * FROM pokemon;")
		all_pokemon.each do |traits|
			objects_array << PokedexAll.new(traits["id"], traits["pokedex_id"], traits["name"], traits["weight"], traits["height"],
				traits["gender"], traits["favorite"], traits["hp"], traits["cp"], traits["date_added"], traits["evolves"],
				traits["type1"], traits["type2"])
		end
		return objects_array
	end

	def search(input)
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

	def find_by_name(input)
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

	def favorites
		favorites_array = DATABASE.execute("SELECT * FROM pokemon WHERE favorite LIKE '%true%';")
		object_array = []
		favorites_array.each do |traits|
			object_array << PokedexSearch.new(traits["id"], traits["pokedex_id"], traits["name"], traits["weight"], traits["height"],
				traits["gender"], traits["favorite"], traits["hp"], traits["cp"], traits["date_added"], traits["evolves"],
				traits["type1"], traits["type2"])
		end
		object_array
	end

	def evolution_chains(name)
		evolution_chains = DATABASE.execute("SELECT * FROM evolutions WHERE stage1='#{name.downcase}' OR stage2='#{name.downcase}' OR stage3='#{name.downcase}';")
		evolutions = evolution_chains[0]
		Evolutions.new('', '', evolutions["stage1"].capitalize, evolutions["stage2"].capitalize, evolutions["stage3"].capitalize)
	
	end

	def save_evolutions(evolutions, id)
		instance = Evolutions.new(evolutions, id)
		if self.chain_exists? == false
			DATABASE.execute("INSERT INTO evolutions (#{instance.evolution_columns}) VALUES #{instance.evolution_values};")
		else
			return false
		end
	end

end