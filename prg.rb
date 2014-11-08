item_array = Array.new
stat_hash = Hash.new
i = 0 
k = 0

Shoes.app :title => "Board Games Tool" do
	background "#F3F".."#F90"
	@item = edit_box width: 200, height: 30, margin_right: 3
	
	button "Add" do
		item_array[i] = @item.text
		i += 1
	end
	button "Remove" do
		for i in 0..item_array.size
			if item_array[i] == @item.text
				item_array.delete_at(i)
			end
		end
	end
	
	button "Show inventory" do
		Shoes.app :width => 200, :height => 200 do
			stack do
				item_array.each do |item|
					button "#{item}" do
						Shoes.app :width => 350, :height => 350 do
							para "Add stat:\n"
							@stat = edit_box width: 200, height: 30, margin_bottom: 3
							button "Add" do
								stat_hash[item] = Hash.new
								stat_hash[item][k] = @stat.text
								para stat_hash[key].values
								k += 1
							end
							para "\n\n"
							para "Stats for this item:\n"
							stat_hash[key]values.each do |val|
								para "#{val}\n"
							end
						end
					end
				end
			end
		end
	end
end