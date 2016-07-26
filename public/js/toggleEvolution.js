window.addEventListener("load", function(){
	var show = document.getElementById("showText");

	show.addEventListener("click", function(){

		var evolutionImages = document.getElementById("toggle");
		var hide = document.getElementById("hideText");
		if (evolutionImages.style.display === "none"){
				evolutionImages.style.display = "block";
			}

			else {
				evolutionImages.style.display = "none";
			}

	});

});