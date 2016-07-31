MyApp.get "/edit" do
	@all_pokemon = PokedexAll.new

	@selected = PokedexSearch.new(params[:name], @all_pokemon.all_pokemon)

	@pokemon = @selected.search_by_name
	

	erb :"pokedex/edit"
end

