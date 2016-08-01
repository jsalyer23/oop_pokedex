require "pry"
require "sqlite3"

DATABASE = SQLite3::Database.new "pokedex.rb"
DATABASE.results_as_hash = true


evolution_table = DATABASE.execute("SELECT evolution_id FROM evolutions;")
binding.pry
		evolution_table.each do |row|
			if row["evolution_id"] == @id
				return true
			end
		end