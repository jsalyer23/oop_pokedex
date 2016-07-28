require 'test_helper'


class PokemonTest < Minitest::Test
  def setup
    super
    require "csv"
    @file = "tests/unit/test_pokedex.csv"
    @input = "Oddish"
    @pokemon = Pokemon.new("Vulpix", 45, 100, "female", 67, 22, "no", "Vulpix", "Ninetales", "", ["fire", "normal"])
    @all_pokemon = PokedexAll.new(@file)
    @search = PokedexSearch.new(@input, @all_pokemon.all_pokemon)


   
 
    # This setup will automatically be run before each test below.
  end

  # -------------Pokemon TESTS------------------

  def test_traits
  	
  	traits = @pokemon.traits

  	assert_kind_of(Array, traits)
    assert_equal(traits, ["Vulpix", 45, 100, "female", 67, 22, "no", "Vulpix", "Ninetales", "", "fire,normal"])
  end

  # -------------PokedexAll TESTS------------------

  def test_all_pokemon
    pokedex_pokemon = @all_pokemon.all_pokemon

    assert_kind_of(Array, pokedex_pokemon)
    assert_equal(4, pokedex_pokemon.count)
  end

  def test_pokemon_array
    pokedex_pokemon = @all_pokemon.pokemon_array

    assert_kind_of(Array, pokedex_pokemon)
    assert_equal(4, pokedex_pokemon.count)
  end

  # -------------PokedexSearch TESTS------------------

  def test_search_all
    all_results = @search.search_all

    assert_kind_of(Array, all_results)
    assert_equal(1, all_results.count)
  end

  def test_all_results
    all_results = @search.all_results

    assert_kind_of(Array, all_results)
    assert_equal(1, all_results.count)
  end

  def test_search_name
    name_results = @search.search_by_name

    assert_kind_of(Array, name_results)
    assert_equal(11, name_results.count)
  end

  def test_name_results
    name_results = @search.name_results

    assert_kind_of(Array, name_results)
    assert_equal(11, name_results.count)
  end

  def test_favorites
    favorites = @search.favorites

    assert_kind_of(Array, favorites)
    assert_equal(2, favorites.count)
  end

  def test_search_for_favorites
    favorites = @search.search_for_favorites

    assert_kind_of(Array, favorites)
    assert_equal(2, favorites.count)
  end


end