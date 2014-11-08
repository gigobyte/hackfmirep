def openTimer()
	Shoes.app :title => "Timer", :width => 400, :height => 140 do 
		@seconds = 0
		@paused = true
		
		def is_numeric?(input)
			input.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
		end
		
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
				if @item.text != '' && @item.text != "0" && is_numeric?(@item.text)
					@seconds = @item.text.to_i*60
					@paused = !@paused
					display_time
				end
			end
			button "Pause/Continue", :width => '50%' do
				@paused = !@paused
				display_time
			end
			button "Reset", :width => '50%' do
				if @item.text != '' && @item.text != "0" && is_numeric?(@item.text)
					@seconds = 0
					@paused = !@paused
					display_time
				end
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
	item_array = Array.new
	stat_hash = Hash.new{|key,value| key[value] = []}
	i = 0; k = 0
	Shoes.app :title => "Inventory" do
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

def openDice()
	Shoes.app :title => "Dice", width: 300, height: 100 do
		para "Enter the number of sides:"
		@dice_sides = edit_box width: 200, height: 30, margin_right: 3
		
		button "Generate" do
			if (@dice_sides.text.to_i > 0)
				dice =(rand() * (@dice_sides.text.to_i)).to_i
				@p.clear { para "You rolled: #{dice + 1}"}
			else
				@p.clear{para "Input a number"}
			end
		end
		@p = flow
	end
end