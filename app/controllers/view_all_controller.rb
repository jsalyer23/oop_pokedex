MyApp.get "/viewall" do

	@file = "app/models/pokedex.csv"
	@pokemon = PokedexAll.new
	@all_pokemon = @pokemon.all_pokemon


	erb :"pokedex/view_all"
end