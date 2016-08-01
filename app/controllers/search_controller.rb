MyApp.get "/searchresults" do

	@title = "Pok&eacute;mon Search Results"

	@all_pokemon = PokedexAll.all_pokemon

	@existing = PokedexSearch.new(params[:search], @all_pokemon)

	@search_results = @existing.search_database

	# if @existing.type_names[1] != nil
	# 	@type1 = @existing.type_names[0]["name"]
	# 	@type2 = ", " + @existing.type_names[1]["name"]
	# else
	# 	@type1 = @existing.type_names[0]["name"]
	# 	@type2 = ""
	# end
	@search_error = "The Pokemon you're searching for does not exist.\n
					Are you sure you spelled things right?\n
					Capitilization matters!"
	

	erb :"pokedex/search_results"
end