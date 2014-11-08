require './timer.rb'

item_array = Array.new
stat_hash = Hash.new{|key,value| key[value] = []}
i = 0 
k = 0

Shoes.app :title => "Board Games Tool" do
	background "#000".."#066"
	@item = edit_box width: 200, height: 40, margin_right: 3, margin_top: 10
	button "Add", :margin_top => 10 do
		if @item.text != ""
			item_array[i] = @item.text
			i += 1
		end
	end
	button "Remove", :margin_top => 10 do
		for i in 0..item_array.size
			if item_array[i] == @item.text
				item_array.delete_at(i)
			end
		end
	end
	
	button "Show inventory", :margin_top => 10 do
		Shoes.app :width => 200, :height => 200 do
			stack do
				item_array.each do |item|
					button "#{item}" do
						Shoes.app :width => 350, :height => 350 do
							para "Add stat:\n"
							@stat = edit_box width: 200, height: 30, margin_bottom: 3
							button "Add" do
								stat_hash[item][k] = @stat.text + "\n"
								stat_hash.values.each do |val|
									@p.clear { para val }
									para "\n"
								end
								k += 1
							end
							@p = flow
							para "\n\n"
							stat_hash.values.each do |val|
								@p.clear { para val }
								para "\n"
							end
						end
					end
				end
			end
		end
	end
	para "\n\n"
	button "Timer" do
		openTimer()
	end
	para "\n\n"
end