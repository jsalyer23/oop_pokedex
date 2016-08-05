require "pry"
require "sqlite3"
require_relative "pokemon.rb"
require_relative "api.rb"
require_relative "database_orm.rb"

# This class formats and saves evolution data to the database
class Evolutions < PokeapiEvolutions
	COLUMNS = "evolutions (evolution_id, stage1, stage2, stage3)"
	
	# TABLE = "evolutions"
	# SELECTOR = "evolution_id"
	
	extend ClassMethods
	attr_reader :id, :evolution_id, :stage1, :stage2, :stage3
	attr_writer :id, :evolution_id, :stage1, :stage2, :stage3

	def initialize(attrs=nil)
		@id = attrs["id"]
		@evolution_id = attrs["evolution_id"]
		@stage1 = attrs["stage1"]
		@stage2 = attrs["stage2"]
		@stage3 = attrs["stage3"]
	end

	def self.table
		"evolutions"
	end

	def self.selector
		"evolution_id"
	end

	# This method checks if a new Pokemon's evolution chain exists in the database
	#
	# RETURNS BOOLEAN IF EXISTS
	def chain_exists?
		evolution_table = DATABASE.execute("SELECT evolution_id FROM evolutions;")
		evolution_table.each do |row|
			if row["evolution_id"] == @evolution_id.to_i
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
	# def self.evolution_chain(id)
	# 	evolution_chains = DATABASE.execute("SELECT * FROM #{TABLE} WHERE #{SELECTOR}='#{id}';")
	# 	evolutions = evolution_chains[0]
	# 	Evolutions.new(evolutions)
	# end

	# This method saves evolution data to the evolutions table in database
	#
	# evolutions = Array returned from PokeapiEvolutions
	#
	# SAVES TO DATABASE (EVOLUTIONS TABLE)
	def self.save_evolution(evolutions)
		DATABASE.execute("INSERT INTO #{COLUMNS} VALUES (\'#{evolutions.evolution_id}\', \'#{evolutions.stage1}\', \'#{evolutions.stage2}\', \'#{evolutions.stage3}\');")
		evolutions.id = DATABASE.last_insert_row_id
		binding.pry
		return evolutions
	end
end