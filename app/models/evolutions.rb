require "pry"
require "sqlite3"
require_relative "pokemon.rb"
require_relative "api.rb"
require_relative "database_orm.rb"

# This class formats and saves evolution data to the database
class DatabaseEvolutions < PokeapiEvolutions

	def initialize(evolutions, evolution_id)
		@evolutions = evolutions
		@id = evolution_id
	end

	# This method formats the columns in the evolutions table
	#
	# RETURNS STRING
	def evolution_columns
		columns = "evolution_id, stage1, stage2, stage3"
		return columns
	end

	# This method adds evolution chain id and stages to evoutions table
	#
	# RETURNS STRING
	def evolution_values
		values = "(\'#{@id}\', \'#{@evolutions[0]}\', \'#{@evolutions[1]}\', \'#{@evolutions[2]}\')"
		return values
	end

	# This method checks if a new Pokemon's evolution chain exists in the database
	#
	# RETURNS BOOLEAN IF EXISTS
	def chain_exists?
		evolution_table = DATABASE.execute("SELECT evolution_id FROM evolutions;")
		evolution_table.each do |row|
			if row["evolution_id"] == @id.to_i
				return true
			end
		end
		return false
	end

	# This method gets the evolution chain from the database
	#
	# RETURNS ASSOCIATIVE ARRAY
	def evolution_chain
		evolution_chains = DATABASE.execute("SELECT * FROM evolutions WHERE stage1='#{@id.downcase}' OR stage2='#{@id.downcase}' OR stage3='#{@id.downcase}';")
		return evolution_chains
	end

	# This method formats the name of the Pokemon's first stage
	#
	# RETURNS STRING
	def stage1
		stages = self.evolution_chain
		stage1 = stages[0]["stage1"].capitalize
		return stage1
	end

	# This method formats the name of the Pokemon's second stage if it exists
	#
	# RETURNS STRING
	def stage2
		stages = self.evolution_chain
		if stages[0]["stage2"] != nil
			stage2 = stages[0]["stage2"].capitalize
		else
			stage2 = ""
		end
		return stage2
	end

	# This method formats the name of the Pokemon's third stage if it exists
	#
	# RETURNS STRING
	def stage3
		stages = self.evolution_chain
		if stages[0]["stage3"] != nil
			stage3 = stages[0]["stage3"].capitalize
		else
			stage3 = ""
		end
		return stage3
	end

	# This method saves evolution data to the evolutions table in database
	#
	# SAVES TO DATABASE (EVOLUTIONS TABLE)
	def save_evolution_table
		require "sqlite3"
		if self.chain_exists? == false
			DATABASE.execute("INSERT INTO evolutions (#{self.evolution_columns}) VALUES #{self.evolution_values};")
		else
			return false
		end
	end
end