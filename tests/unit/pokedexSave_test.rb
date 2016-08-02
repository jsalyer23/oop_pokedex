require 'test_helper'

class PokedexSaveTest < Minitest::Test
  def setup
    super
    test_pokemon = DATABASE.execute("SELECT * FROM pokemon WHERE id='6';")
    if test_pokemon != nil
    	DATABASE.execute("DELETE FROM pokemon WHERE id='6';")
    end
    
    @pokemon = Pokemon.new(74, 'Geodude', 4, 200, 'Male', true, 299, 78, true, 9, 13)
    @pokedex = PokedexSave.save(@pokemon.traits)
    
    # @all_pokemon = PokedexAll.all_pokemon
    # @search_results = PokedexSearch.new("Geodude", @all_pokemon)
    # @geodude = @search_results.search_by_name
    # This setup will automatically be run before each test below.
  end

  # Your tests are defined here. Tests must be contained in a method
  # that begins with test_ or it won't work. An example test:

  def test_for_saved_pokemon
    @geodude = PokedexSearch.find_by_name("Geodude")

    assert_kind_of(Object, @geodude)
    refute_nil(@geodude)
    assert_equal(6, @geodude.id)
  end

  def test_pokemon_columns
    new_instance = PokedexSave.new(@pokemon)
  	columns = "pokedex_id, name, weight, height, gender, favorite, hp, cp, date_added, evolves, type1, type2"
  	test = new_instance.pokemon_columns

  	assert_equal(columns, test)
  	assert_kind_of(String, test)
  	refute_nil(test)
  end

  def test_updating_pokemon
  	PokedexSave.update_pokemon(100, 23, 'Male', true, 6)
  	new_geodude = PokedexSearch.find_by_name("Geodude")

  	refute_nil(new_geodude)
  	assert_kind_of(Object, new_geodude)
  	assert_equal("Male", new_geodude.gender)
  end
end



# 74, 'Geodude', 4, 200, 'Male', true, 299, 78, true, 9, 13
