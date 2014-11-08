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
				if @item.text.to_i != 0 then
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
				if @seconds != 0 && @item.to_i != 0 then
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
		@display = stack :margin_left => 100 
		display_time
		@item = edit_box width: 200, height: 40, margin_right: 3, margin_top: 10
		buttons
	end
end

def openCoin()
	Shoes.app :title =>"Coin Flip", width: 180, height: 34 do
		@push = button "Flip"
		@note = para "You feel lucky?"
		@push.click {
			side =(rand() * (2)).to_i
			if side==0
				side = "tails"
			else
				side = "heads"
			end
			@note.replace "#{side}"
		}
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

def openTurn()
	i = 0
	Shoes.app :title => "Turn counter", width: 150, height: 35 do
		button "+" do
			i += 1
			@node.replace "Turn: #{i}"
		end
		button "-" do
			i -= 1
			if i == -1
				i = 0
			end
			@node.replace "Turn: #{i}"
		end
		@node = para "Turn: #{i}"
	end
end