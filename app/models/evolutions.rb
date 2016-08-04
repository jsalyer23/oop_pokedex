require "pry"
require "sqlite3"
require_relative "pokemon.rb"
require_relative "api.rb"
require_relative "database_orm.rb"

# This class formats and saves evolution data to the database
class Evolutions < PokeapiEvolutions
	attr_reader :id, :evolution_id, :stage1, :stage2, :stage3
	attr_writer :id, :evolution_id, :stage1, :stage2, :stage3
	COLUMNS = "evolution_id, stage1, stage2, stage3"
	VALUES = "(\'#{evolutions.evolution_id}\', \'#{evolutions.stage1}\', \'#{evolutions.stage2}\', \'#{evolutions.stage3}\')"

	def initialize(id=nil, evolution_id=nil, stage1=nil, stage2=nil, stage3=nil)
		@id = id
		@evolution_id = evolution_id
		@stage1 = stage1
		@stage2 = stage2
		@stage3 = stage3
	end

	# # This method formats the columns in the evolutions table
	# #
	# # RETURNS STRING
	# def evolution_columns
	# 	columns = 
	# 	return columns
	# end

	# # This method adds evolution chain id and stages to evoutions table
	# #
	# # RETURNS STRING
	# def evolution_values
	# 	values = 
	# 	return values
	# end

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
	# 
	#
	# RETURNS ASSOCIATIVE ARRAY
	def self.evolution_chain(id)
		evolution_chains = DATABASE.execute("SELECT * FROM evolutions WHERE evolution_id='#{id}';")
		evolutions = evolution_chains[0]
		binding.pry
		Evolutions.new('', evolutions["evolution_id"], evolutions["stage1"].capitalize, evolutions["stage2"].capitalize, evolutions["stage3"].capitalize)
	end

	# This method saves evolution data to the evolutions table in database
	#
	# evolutions = Array returned from PokeapiEvolutions
	#
	# SAVES TO DATABASE (EVOLUTIONS TABLE)
	def self.save_evolution(evolutions)
		DATABASE.execute("INSERT INTO evolutions (#{COLUMNS}) VALUES #{VALUES};")
		evolutions.id = DATABASE.last_insert_row_id
		return evolutions
	end
end