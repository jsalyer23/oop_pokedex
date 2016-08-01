require "pry"
require "sqlite3"

module Database

	def self.save_pokemon
		require "sqlite3"
		DATABASE.execute("INSERT INTO pokemon (#{self.pokemon_columns})
			VALUES #{self.pokemon_values};")
	end

	def self.all_pokemon
		require "sqlite3"
		all_pokemon = DATABASE.execute("SELECT * FROM pokemon;")
		return all_pokemon
	end

	def self.search_database(input)
		search_results = DATABASE.execute("SELECT * FROM pokemon WHERE name LIKE '%#{input}%'
			OR gender LIKE '%#{input}%' OR pokedex_id LIKE '%#{input}%';")
		return search_results
	end

	def self.favorites
		favorites = DATABASE.execute("SELECT * FROM pokemon WHERE favorite LIKE '%true%';")
		return favorites
	end

	def self.type_names
		types_names = DATABASE.execute("SELECT name FROM types WHERE id='#{self.type_id[0]}' OR id='#{self.type_id[1]}';")	
		return types_names
	end

	def self.chain_exists?
		evolution_table = DATABASE.execute("SELECT evolution_id FROM evolutions;")
		evolution_table.each do |row|
			if row["evolution_id"] == @id
				return true
			end
		end
		return false
	end

	def self.evolution_chains
		evolution_chains = DATABASE.execute("SELECT * FROM evolutions WHERE stage1='#{@id.downcase}' OR stage2='#{@id.downcase}' OR stage3='#{@id.downcase}';")
		return evolution_chains
	end

	def self.save_evolutions
		require "sqlite3"
		if self.chain_exists? != true
			DATABASE.execute("INSERT INTO evolutions (#{self.evolution_columns}) VALUES #{self.evolution_values};")
		end
	end

end