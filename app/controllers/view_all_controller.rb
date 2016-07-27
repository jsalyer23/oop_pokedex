MyApp.get "/viewall" do

	@file = "app/models/pokedex.csv"
	@all_pokemon = PokdexAll.new.all_pokemon
end