require "pry"
require "sqlite3"

DATABASE = SQLite3::Database.new "pokedex.db"
DATABASE.results_as_hash = true

types = DATABASE.execute("SELECT * FROM types;")

types_array = []

types.each do |name|
	types_array.push(name["name"])
end
