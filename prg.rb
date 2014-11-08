require './tools.rb'

Shoes.app :title => "Board Games Tool" do
	background "#000".."#066"
	button "Turn counter" do
		openTurn()
	end
	button "Dice" do
		openDice()
	end
	button "Timer" do
		openTimer()
	end
	button "Coin" do
		openCoin()
	end
	button "Open all tools" do
		openTurn()
		openDice()
		openTimer()
		openCoin()
	end
end