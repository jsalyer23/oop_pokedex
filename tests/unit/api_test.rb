# require 'test_helper'


# class ApiTest < Minitest::Test
# 	  def setup
# 	    super

# 	DATABASE.execute("DELETE FROM pokemon;")
    # DATABASE.execute("DELETE FROM evolutions;")
    # DATABASE.execute("INSERT INTO evolutions (evolution_id, stage1, stage2, stage3) VALUES (3, 'squirtle', 'wartortle', 'blastoise');")
#     DATABASE.execute("INSERT INTO pokemon (pokedex_id, name, height, weight, gender, favorite, hp, cp, date_added, evolves, type1, type2, evolution_id)
    #  VALUES (7, 'Squirtle', 5, 90, 'Male', 'true', 398, 39, CURRENT_DATE, 'true', 3, '', 3),
    # (43, 'Oddish', 5, 54, 'Female', 'false', 100, 34, CURRENT_DATE, 'true', 5, 8, ''),
    # (25, 'Pikachu', 4, 60, 'Female', 'true', 99, 58, CURRENT_DATE, 'true', 4, '', ''),
    # (9, 'Blastoise', 16, 855, 'Male', 'false', 93, 485, CURRENT_DATE, 'false', 3, '', 3),
    # (37, 'Vulpix', 6, 99, 'Female', 'true', 499, 89, CURRENT_DATE, 'true', 2, '', ''),
    # (74, 'Geodude', 4, 200, 'Male', 'true', 100, 23, CURRENT_DATE, 'true', 9, 13, '');"

# 		@name = "gloom"
# 	    @pokemon_data = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{@name}")
# 	    @api_data = Pokeapi.new(@pokemon_data)

# 	    #Use for evolution id basically
# 	    @species = HTTParty.get(@api_data.species_url)
	    
# 	    @api_species = PokeapiSpecies.new(@species)
# 	    # Use for evolutions
# 	    @evolutions = HTTParty.get("http://pokeapi.co/api/v2/evolution-chain/#{@api_species.evolution_id}")
	    
# 	    @api_evolution = PokeapiEvolutions.new(@evolutions, "")
# 		end


# 	      # -------------Pokeapi TESTS------------------

# 	  def test_species_url
	    
# 	    species_url = @api_data.species_url

# 	    assert_kind_of(String, species_url)
# 	    refute_nil(species_url)
# 	  end

# 	  def test_pokemon_id

# 	    id = @api_data.id

# 	    assert_kind_of(Fixnum, id)
# 	    refute_nil(id)
# 	  end 

# 	  def test_types

# 	    types_array = @api_data.types

# 	    assert_kind_of(Array, types_array)
# 	    refute_nil(types_array)
# 	  end

# 	  def test_height

# 	    height = @api_data.height

# 	    assert_kind_of(Fixnum, height)
# 	    refute_nil(height)
# 	  end

# 	  def test_weight

# 	    weight = @api_data.weight

# 	    assert_kind_of(Fixnum, weight)
# 	    refute_nil(weight)
# 	  end

# 	  # -------------PokeapiSpecies TESTS------------------

# 	  def test_evolution_url
# 	  	url = @api_species.evolution_url

# 	  	assert_kind_of(String, url)
# 	  	refute_nil(url)
# 	  end

# 	  def test_evolution_id
# 	  	id = @api_species.evolution_id

# 	  	assert_kind_of(String, id)
# 	  	refute_nil(id)
# 	  end

# 	  # -------------PokeapiEvolutions TESTS------------------

# 	  def test_stage1
# 	  	stage1 = @api_evolution.stage1

# 	  	assert_kind_of(String, stage1)
# 	  	refute_nil(stage1)
# 	  end

# 	  def test_stage2
# 	  	stage2 = @api_evolution.stage2

# 	  	assert_kind_of(String, stage2)
# 	  	refute_nil(stage2)
# 	  end

# 	  def test_stage3
# 	  	stage3 = @api_evolution.stage3

# 	  	assert_kind_of(String, stage3)
# 	  	refute_nil(stage3)
# 	  end

# end