
require 'test_helper'
require "pry"
class PokedexSearchTest < Minitest::Test
  def setup
    super

    @all_pokemon = PokedexAll.new
    @search_results = PokedexSearch.new("Vulpix", @all_pokemon.all_pokemon)
    @false_results = PokedexSearch.new("Mewtwo", @all_pokemon.all_pokemon)
    @gender_results = PokedexSearch.new("Female", @all_pokemon.all_pokemon)
    @favorites = PokedexSearch.new("", @all_pokemon.all_pokemon)
    @two_types = PokedexSearch.new("Oddish", @all_pokemon.all_pokemon)
    # This setup will automatically be run before each test below.
  end

  # Your tests are defined here. Tests must be contained in a method
  # that begins with test_ or it won't work. An example test:

  def test_all_pokemon
    pokedex_pokemon = @all_pokemon.all_pokemon

    assert_kind_of(Array, pokedex_pokemon)
    assert_equal(pokedex_pokemon.count, 5)
    refute_nil(pokedex_pokemon)
  end

  def test_pokemon_array
  	pokedex_pokemon = @all_pokemon.pokemon_array

  	assert_kind_of(Array, pokedex_pokemon)
  	assert_equal(pokedex_pokemon.count, 5)
  	refute_nil(pokedex_pokemon)
  end

  def test_search_by_name
  	name_results = @search_results.search_by_name

  	assert_kind_of(Hash, name_results)
  	assert_equal({"id"=>5, "pokedex_id"=>37, "name"=>"Vulpix", "weight"=>6.0, "height"=>99.0, "gender"=>"Female", "favorite"=>"true", "hp"=>499,
  			"cp"=>89, "date_added"=>"2016-08-01", "evolves"=>"true", "type1"=>"2", "type2"=>"", 0=>5, 1=>37, 2=>"Vulpix", 3=>6.0, 4=>99.0, 5=>"Female",
  			6=>"true", 7=>499, 8=>89, 9=>"2016-08-01", 10=>"true", 11=>"2", 12=>""}, name_results)
  	refute_nil(name_results)
  end

  def test_search_by_name_false
  	name_results = @false_results.search_by_name

  	assert_kind_of(FalseClass, name_results)
  	assert_equal(false, name_results)
  	refute_nil(name_results)
  end

  def test_search_database_for_gender
  	gender_results = @gender_results.search_database

  	assert_kind_of(Array, gender_results)
  	assert_equal(3, gender_results.count)
  	refute_nil(gender_results)
  end

  def test_select_favorites
  	favorites = @favorites.select_favorites

  	assert_kind_of(Array, favorites)
  	assert_equal(favorites.count, 3)
  	refute_nil(favorites)
  end

  def test_display_type_names
  	display_names = @search_results.display_type_names

  	assert_equal("Fire", display_names[0])
  	assert_kind_of(Array, display_names)
  	refute_nil(display_names)
  end

  def test_2_type_ids
  	two_ids = @two_types.type_id

  	assert_equal(5, two_ids[0])
  	assert_equal(8, two_ids[1])
  	assert_kind_of(Array, two_ids)
  	refute_nil(two_ids)
  end

  def test_2_type_names
  	two_names = @two_types.type_names

  	assert_equal("Grass", two_names[0]["name"])
  	assert_equal("Poison", two_names[1]["name"])
  	assert_kind_of(Array, two_names)
  	refute_nil(two_names)
  end

  def test_show_2_names
  	two_names = @two_types.display_type_names

  	assert_equal("Grass", two_names[0])
  	assert_equal(", Poison", two_names[1])
  	assert_kind_of(Array, two_names)
  	refute_nil(two_names)
  end

end
