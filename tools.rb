require 'date'

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

def openNote()
	i = 0
	note_hash = Hash.new
	Shoes.app :title => "Note", width: 300, height: 400 do
		@note = edit_box width: 200, height: 30
		file = File.new("notes.txt", "w")
		button "Add" do
			current_time = DateTime.now
			if @note.text != ""
				note_hash[@note.text] = current_time.strftime "%d/%m/%Y %H:%M"
				para "#{note_hash.values.last} : #{note_hash.keys.last}\n"
				file.puts("#{note_hash.values.last} : #{note_hash.keys.last}\n")
			end
		end
		f1 = File.open("notes.txt")
		f1_read = f1.readlines
		para f1_read
		para "\n\n"
	end
end

def openCalc()
	Shoes.app(title: "My calculator", width: 200, height: 240) do
	  number_field = nil
	  @number = 0
	  @op = nil
	  @previous = 0
	  
	  flow width: 200, height: 240 do
		flow width: 0.7, height: 0.2 do
		  background rgb(0, 0, 0)
		  number_field = para @number, margin: 10, :stroke => white
		end
		
		flow width: 0.3, height: 0.2 do
		  button 'Clr', width: 1.0, height: 1.0 do
			@number = 0
			number_field.replace(@number)
		  end
		end    

		flow width: 1.0, height: 0.8 do
		  background rgb(139, 206, 236)
		  %w(7 8 9 + 4 5 6 - 1 2 3 / 0 . = *).each do |btn|
			button btn, width: 50, height: 50 do
			  case btn
				when /[0-9]/ 
				  @number = @number.to_i * 10 + btn.to_i
				
				when '='
				  @number = @previous.send(@op, @number)
				else
				  @previous, @number = @number, nil
				  @op = btn
			  end
			  number_field.replace(@number)    
			end
		  end      
		end
	  end
	end
end