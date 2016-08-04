# require 'test_helper'

# class ApiRequestsTest < Minitest::Test
#   def setup
#     super

#     DATABASE.execute("DELETE FROM pokemon;")

#     DATABASE.execute("INSERT INTO pokemon (pokedex_id, name, height, weight, gender, favorite, hp, cp, date_added, evolves, type1, type2)
#      VALUES (7, 'Squirtle', 5, 90, 'Male', 'true', 398, 39, CURRENT_DATE, 'true', 3, ''),
#     (43, 'Oddish', 5, 54, 'Female', 'false', 100, 34, CURRENT_DATE, 'true', 5, 8),
#     (25, 'Pikachu', 4, 60, 'Female', 'true', 99, 58, CURRENT_DATE, 'true', 4, ''),
#     (9, 'Blastoise', 16, 855, 'Male', 'false', 93, 485, CURRENT_DATE, 'false', 3, ''),
#     (37, 'Vulpix', 6, 99, 'Female', 'true', 499, 89, CURRENT_DATE, 'true', 2, ''),
#     (74, 'Geodude', 4, 200, 'Male', 'true', 100, 23, CURRENT_DATE, 'true', 9, 13);")
#     @name = "oddish"
#     @api = ApiRequests.new
# 	@api_data = @api.pokemon_request(@name)
# 	@api_species = @api.species_request(@api_data)
# 	@api_evolution	= @api.evolution_request(@api_species, @name)

#     # This setup will automatically be run before each test below.
#   end

#   # Your tests are defined here. Tests must be contained in a method
#   # that begins with test_ or it won't work. An example test:

#   def test_pokemon_request
#   	refute_nil(@api_data)
#   	assert_kind_of(Object, @api_data)
#   end

#   def test_species_request
#   	refute_nil(@api_species)
#   	assert_kind_of(Object, @api_species)
#   end

#   def test_evolutions_request
#   	refute_nil(@api_evolution)
#   	assert_kind_of(Object, @api_evolution)
#   end
# end