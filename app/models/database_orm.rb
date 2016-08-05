require "pry"
require "sqlite3"

module InstanceMethods

	# This method adds a Pokemon's type ID numbers to an Array
	#
	# RETURNS ARRAY
	def type_id
		types_id = [self.type1, self.type2]
		return types_id
	end

	# This method finds the Pokemon type names matching the type IDs
	#
	# RETURNS ASSOCIATIVE ARRAY
	def type_names
		types_names = DATABASE.execute("SELECT name FROM types WHERE id='#{self.type_id[0]}' OR id='#{self.type_id[1]}';") 	
		return types_names
	end

	# This method formats the type names to be displayed on the view
	#
	# RETURNS ARRAY
	def display_type_names
		if self.type_names[1] != nil
			type1 = self.type_names[0]["name"]
			type2 = ", " + self.type_names[1]["name"]
		else
			type1 = self.type_names[0]["name"]
			type2 = ""
		end
		names = [type1, type2]
		return names
	end

end

module ClassMethods
	TABLE = ''
	SELECTOR = ''
	# Searches for specific name
	#
	# RETURNS POKEMON OBJECT OR FALSE
	def find(id)
		name_results = DATABASE.execute("SELECT * FROM #{TABLE} WHERE #{SELECTOR} LIKE '%#{id}%';")
		if !name_results.empty?
			traits = name_results[0]
			self.new(traits)
		else
			return false
		end

	end

end