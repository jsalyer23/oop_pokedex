MyApp.get "/viewall" do

	@file = "app/models/pokedex.csv"
	@pokemon = PokedexAll.new(@file)
	@all_pokemon = @pokemon.all_pokemon

	erb :"pokedex/view_all"
end