require './tools.rb'

Shoes.app :title => "Board Games Tool", width: 800, height: 550  do
	background "images/background.png"
	
	@image_counter = image "images/button_counter.png"
	@image_counter.click do
			openTurn()
	end
	@image_dice = image "images/button_dice.png"
	@image_dice.click do
			openDice()
	end
	button "Timer" do
		openTimer()
	end
	button "Coin" do
		openCoin()
	end
	button "Notes" do
		openNote()
	end
	button "Calculator" do
		openCalc()
	end
	button "DPS Calculator" do
		openDPS()
	end
	button "Life Calculator" do
		openLife()
	end
end