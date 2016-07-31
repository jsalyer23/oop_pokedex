require 'test_helper'


class ApiTest < Minitest::Test
	  def setup
	    super

		@name = "gloom"
	    @pokemon_data = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{@name}")
	    @api_data = Pokeapi.new(@pokemon_data)

	    #Use for evolution id basically
	    @species = HTTParty.get(@api_data.species_url)
	    
	    @api_species = PokeapiSpecies.new(@species)
	    # Use for evolutions
	    @evolutions = HTTParty.get("http://pokeapi.co/api/v2/evolution-chain/#{@api_species.evolution_id}")
	    
	    @api_evolution = PokeapiEvolutions.new(@evolutions, "")
		end


	      # -------------Pokeapi TESTS------------------

	  def test_species_url
	    
	    species_url = @api_data.species_url

	    assert_kind_of(String, species_url)
	    refute_nil(species_url)
	  end

	  def test_pokemon_id

	    id = @api_data.id

	    assert_kind_of(Fixnum, id)
	    refute_nil(id)
	  end 

	  def test_types

	    types_array = @api_data.types

	    assert_kind_of(Array, types_array)
	    refute_nil(types_array)
	  end

	  def test_height

	    height = @api_data.height

	    assert_kind_of(Fixnum, height)
	    refute_nil(height)
	  end

	  def test_weight

	    weight = @api_data.weight

	    assert_kind_of(Fixnum, weight)
	    refute_nil(weight)
	  end

	  # -------------PokeapiSpecies TESTS------------------

	  def test_evolution_url
	  	url = @api_species.evolution_url

	  	assert_kind_of(String, url)
	  	refute_nil(url)
	  end

	  def test_evolution_id
	  	id = @api_species.evolution_id

	  	assert_kind_of(String, id)
	  	refute_nil(id)
	  end

	  # -------------PokeapiEvolutions TESTS------------------

	  def test_stage1
	  	stage1 = @api_evolution.stage1

	  	assert_kind_of(String, stage1)
	  	refute_nil(stage1)
	  end

	  def test_stage2
	  	stage2 = @api_evolution.stage2

	  	assert_kind_of(String, stage2)
	  	refute_nil(stage2)
	  end

	  def test_stage3
	  	stage3 = @api_evolution.stage3

	  	assert_kind_of(String, stage3)
	  	refute_nil(stage3)
	  end

end