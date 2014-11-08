def openTimer()
	Shoes.app :width => 400, :height => 140 do 
		@seconds = 0 
		@paused = true 

		def display_time 
				@display.clear do
					title "%02d:%02d:%02d" % [ 
					@seconds / (60*60), 
					@seconds / 60 % 60, 
					@seconds % 60 
				  ], :stroke => @paused ? red : black 
				end
		end 
		def buttons
			button "Start", :width => '50%' do
				@seconds = @item.text.to_i*60
				@paused = !@paused
				display_time
			end
			button "Pause/Continue", :width => '50%' do 
				@paused = !@paused 
				display_time 
			end 
			button "Reset", :width => '50%' do 
				@seconds = 0
				@paused = !@paused
				display_time 
			end 
		end
			animate(1) do 
				@seconds -= 1 unless @paused 
				display_time 
			end 
		#main
		@display = stack :margin_left => 100 
		display_time
		@item = edit_box width: 200, height: 40, margin_right: 3, margin_top: 10
		buttons
	end
end

def openInventoryEditor()
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
									if @stat.text != ""
										stat_hash[item][k] = @stat.text + "\n"
									end
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
	end
end

