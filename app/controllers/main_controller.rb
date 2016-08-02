MyApp.get "/" do
	@title = "Personal Pok&eacute;dex"

	@favorite = PokedexSearch.favorites.sample
	@no_pokemon_error = "Visit the Add Pokemon page to start building your Pokedex"
	@existing = PokedexSearch.find_by_name(@favorite.name)

	if @existing.type_names[1] != nil
		@type1 = @existing.type_names[0]["name"]
		@type2 = ", " + @existing.type_names[1]["name"]
	else
		@type1 = @existing.type_names[0]["name"]
		@type2 = ""
	end
	
	if @favorite == "true"
		@favorite = "yes"
	end

	erb :"pokedex/home"
end