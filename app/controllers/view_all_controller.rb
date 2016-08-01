MyApp.get "/viewall" do
	@all_pokemon = PokedexAll.all_pokemon
 
	erb :"pokedex/view_all"
end