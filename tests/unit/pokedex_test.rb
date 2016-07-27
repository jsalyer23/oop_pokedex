require 'test_helper'


class PokemonTest < Minitest::Test
  def setup
    super

    # @file = "test_pokedex.csv"
    @pokemon = Pokemon.new("Vulpix", 45, 100, "female", 67, 22, "no", "Vulpix", "Ninetales", "", ["fire", "normal"])

    binding.pry
    # This setup will automatically be run before each test below.
  end

  # Your tests are defined here. Tests must be contained in a method
  # that begins with test_ or it won't work. An example test:

  def test_traits
  	
  	traits = @pokemon.traits
  	binding.pry
  	assert_kind_of(Array, traits)
    assert_equal(traits, ["Vulpix", 45, 100, "female", 67, 22, "no", "Vulpix", "Ninetales", "", "fire", "normal"])
  end
end