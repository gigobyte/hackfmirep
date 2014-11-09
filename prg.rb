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
	@image_timer = image "images/button_timer.png"
	@image_timer.click do
		openTimer()
	end
	@image_coin = image "images/button_coin.png"
	@image_coin.click do
		openCoin()
	end
	@image_note = image "images/button_note.png"
	@image_note.click do
		openNote()
	end
	@image_calc = image "images/button_calc.png"
	@image_calc.click do
		openCalc()
	end
	@image_dps = image "images/button_dps.png"
	@image_dps.click do
		openDPS()
	end
	@image_life = image "images/button_life.png"
	@image_life.click do
		openLife()
	end
end