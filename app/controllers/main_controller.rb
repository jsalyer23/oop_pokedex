MyApp.get "/" do
	@title = "Personal Pok&eacute;dex"

	@file = "app/models/pokedex.csv"
	
	@pokedex = PokedexAll.new(@file)
	@favorites = PokedexSearch.new("", @pokedex.all_pokemon)
	@random_favorite = @favorites.favorites.sample
	@no_pokemon_error = "Visit the Add Pokemon page to start building your Pokedex"

	@name = @random_favorite[0]
	@height = @random_favorite[1].to_f / 10 * 3.28
	@height = @height.round(2)
	@weight = @random_favorite[2].to_i / 4.54
	@weight = @weight.round(2)
	@gender = @random_favorite[3]
	@cp = @random_favorite[4]
	@hp = @random_favorite[5]
	@favorite = @random_favorite[6]
	@stage1 = @random_favorite[7]
	@stage2 = @random_favorite[8]
	@stage3 = @random_favorite[9]
	@type = @random_favorite[10]

	if @favorite == "on"
		@favorite = "yes"
	end

	erb :"pokedex/home"
end