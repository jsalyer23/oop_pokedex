require 'test_helper'

class ApiRequestsTest < Minitest::Test
  def setup
    super
    @name = "oddish"
    @api = ApiRequests.new
	@api_data = @api.pokemon_request(@name)
	@api_species = @api.species_request(@api_data)
	@api_evolution	= @api.evolution_request(@api_species)

    # This setup will automatically be run before each test below.
  end

  # Your tests are defined here. Tests must be contained in a method
  # that begins with test_ or it won't work. An example test:

  def test_pokemon_request
  	refute_nil(@api_data)
  	assert_kind_of(Object, @api_data)
  end

  def test_species_request
  	refute_nil(@api_species)
  	assert_kind_of(Object, @api_species)
  end

  def test_evolutions_request
  	refute_nil(@api_evolution)
  	assert_kind_of(Object, @api_evolution)
  end
end