require "pry"
require "sqlite3"
require_relative "pokemon.rb"
require_relative "api.rb"
require_relative "database_orm.rb"

# This class formats and saves evolution data to the database
class Evolutions < PokeapiEvolutions
	attr_reader :stage1, :stage2, :stage3
	attr_writer :stage1, :stage2, :stage3

	def initialize(evolutions=nil, id=nil, stage1=nil, stage2=nil, stage3=nil)
		@evolutions = evolutions
		@id = id
		@stage1 = stage1
		@stage2 = stage2
		@stage3 = stage3
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
	# name = Pokemon's name
	#
	# RETURNS ASSOCIATIVE ARRAY
	def self.evolution_chain(name)
		evolution_chains = DATABASE.execute("SELECT * FROM evolutions WHERE stage1='#{name.downcase}' OR stage2='#{name.downcase}' OR stage3='#{name.downcase}';")
		evolutions = evolution_chains[0]
		Evolutions.new('', '', evolutions["stage1"].capitalize, evolutions["stage2"].capitalize, evolutions["stage3"].capitalize)
	end

	# This method saves evolution data to the evolutions table in database
	#
	# evolutions = Array returned from PokeapiEvolutions
	#
	# SAVES TO DATABASE (EVOLUTIONS TABLE)
	def self.save_evolution(evolutions, id)
		instance = Evolutions.new(evolutions, id)
		if instance.chain_exists? == false
			DATABASE.execute("INSERT INTO evolutions (#{instance.evolution_columns}) VALUES #{instance.evolution_values};")
		else
			return false
		end
	end
end