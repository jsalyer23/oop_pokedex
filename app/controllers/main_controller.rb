MyApp.get "/" do
	@title = "Personal Pok&eacute;dex"

	@file = "app/models/pokedex.csv"
	
	@pokedex = PokedexAll.new
	@favorites = PokedexSearch.new("", @pokedex.all_pokemon)
	@random_favorite = @favorites.favorites.sample
	@no_pokemon_error = "Visit the Add Pokemon page to start building your Pokedex"
	@existing = PokedexSearch.new(@random_favorite["name"], @pokedex.all_pokemon)

	if @existing.type_names[1] != nil
		@type1 = @existing.type_names[0]["name"]
		@type2 = ", " + @existing.type_names[1]["name"]
	else
		@type1 = @existing.type_names[0]["name"]
		@type2 = ""
	end

	@name = @random_favorite["name"]
	@height = @random_favorite["height"]

	@weight = @random_favorite["weight"]
	
	@gender = @random_favorite["gender"]
	@cp = @random_favorite["cp"]
	@hp = @random_favorite["hp"]
	@favorite = @random_favorite["favorite"]
	@stage1 = @random_favorite[7]
	@stage2 = @random_favorite[8]
	@stage3 = @random_favorite[9]
	

	if @favorite == "true"
		@favorite = "yes"
	end

	erb :"pokedex/home"
end