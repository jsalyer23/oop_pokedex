MyApp.get "/searchresults" do
	@title = "Pok&eacute;mon Search Results"

	@search_results = Pokedex.search(params[:search])
	@search_error = "The Pokemon you're searching for does not exist.\n
					Are you sure you spelled things right?\n
					Capitilization matters!"

	erb :"pokedex/search_results"
end