require './tools.rb'

Shoes.app :title => "Board Games Tool" do
	button "Inventory" do
		openInventoryEditor()
	end
	para "\n\n"
	button "Timer" do
		openTimer()
	end
	para "\n\n"
	button "Dice" do
		openDice()
	end
	para "\n\n"
end