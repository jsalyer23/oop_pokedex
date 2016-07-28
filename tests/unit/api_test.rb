require 'test_helper'


class ApiTest < Minitest::Test
	  def setup
	    super

		@name = "gloom"
	    @pokemon_data = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{@name}")
	    @api_data = Pokeapi.new(@pokemon_data)

	       # Use for evolution id basically
	    # @species = HTTParty.get(@api_data.species_url)
	    
	    # @api_species = PokeapiSpecies.new(@species)
	    # # Use for evolutions
	    # @evolutions = HTTParty.get("http://pokeapi.co/api/v2/evolution-chain/#{@api_species.evolution_id}")
	    
	    # @api_evolution = PokeapiEvolutions.new(@evolutions)
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

	  def test_abilities

	    ability_array = @api_data.abilities

	    assert_kind_of(Array, ability_array)
	    refute_nil(ability_array)
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
end