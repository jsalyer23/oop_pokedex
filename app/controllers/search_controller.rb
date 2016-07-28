MyApp.get "/searchresults" do

	@title = "Pok&eacute;mon Search Results"
	@file = 'app/models/pokedex.csv'

	@all_pokemon = PokedexAll.new(@file)

	@existing = PokedexSearch.new(params[:search], @all_pokemon.pokemon_array)

	
	@search_results = @existing.search_all
	@search_error = "The Pokemon you're searching for does not exist.\n
					Are you sure you spelled things right?\n
					Capitilization matters!"
	

	erb :"pokedex/search_results"
end