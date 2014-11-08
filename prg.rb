require './tools.rb'


i = 0 
k = 0

Shoes.app :title => "Board Games Tool" do
	button "Inventory" do
		openInventoryEditor()
	end
	para "\n\n"
	button "Timer" do
		openTimer()
	end
	para "\n\n"
end