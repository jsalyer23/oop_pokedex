MyApp.get "/viewall" do
	@all_pokemon = Pokedex.all_pokemon
 
	erb :"pokedex/view_all"
end