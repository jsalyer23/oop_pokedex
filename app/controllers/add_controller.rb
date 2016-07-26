MyApp.get "/add" do
	@title = "Add New Pok&eacute;mon"
	@name = params[:name]
	@pokemon = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{@name}")

	@new_pokemon = Pokemon.new()

	erb :"pokedex/add"
end