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
	Shoes.app :title => "Turn counter", width: 220, height: 190 do
		background "images/turn_background.png"
		@image_sign = image "images/sign_plus.png"
		@image_sign.click do
			i += 1
			@node.replace "Turn: #{i}"
		end
		@image_sign2 = image "images/sign_minus.png"
		@image_sign2.click do
			i -= 1
			if i == -1
				i = 0
			end
			@node.replace "Turn: #{i}"
		end
		@node = para "Turn: #{i}"
		@node.style(stroke: brown, font: "Calibri", size: 40)
	end
end

def openNote()
	note_hash = Hash.new
#	file = File.new("notes.txt", "w")
#	file.puts("0")
	Shoes.app :title => "Note", width: 300, height: 400 do
		@note = edit_box width: 200, height: 30
		button "Add" do
			current_time = DateTime.now
			if @note.text != ""
				note_hash[@note.text] = current_time.strftime "%d/%m/%Y %H:%M"
				para "#{note_hash.values.last} : #{note_hash.keys.last}\n"
			end
		end
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

def openDPS()
	Shoes.app :width => 370, :height => 280 do
		dps = 0
		resistance = 1
		res_dps = 0
		para "Base damage: "
		@damage = edit_box width: 200, height: 30
		para "\n\n"
		para "Attack speed:   "
		@attack_speed = edit_box width: 200, height: 30
		para "\n\n"
		para "Enemy Resistance (in %): "
		@resistance = edit_box width: 200, height: 30
		button "Calculate" do
			dps = @damage.text.to_f*@attack_speed.text.to_f
			res_dps = dps - (dps / (100 / @resistance.text.to_f))
			para "\n\n"
			@node.replace "Your DPS is #{dps} \nYour DPS including resistance is #{res_dps}"
		end
		para "\n\n"
		@node = para "Your DPS is #{dps} \nYour DPS including resistance is #{res_dps}"
	end
end

def openLife()
	Shoes.app :width => 550, :height =>82 do
		arr = ["Player 1","Player 2"]
		life1 = 20; life2 = 20; p1 = 0; p2 = 0
		@node = para "Player 1: #{life1}\t\tPlayer 2: #{life2}\n\n"
		list_box :items => arr ,width: 200, height: 30 do |list|
			if list.text == "Player 1"
				p1 = 1
				p2 = 0
			else
				p2 = 1
				p1 = 0
			end
		end
		@command = edit_box width: 200, height: 30
		button "Add" do
			if p1 == 1 && 
				@command.text = @command.text.delete('+')
				life1 += @command.text.to_i
				@node.replace "Player 1: #{life1}\t\tPlayer 2: #{life2}\n\n"
			end
			if p2 == 1
				@command.text = @command.text.delete('+')
				life2 += @command.text.to_i
				@node.replace "Player 1: #{life1}\t\tPlayer 2: #{life2}\n\n"
			end
		end
		
		button "Remove" do
			if p1 == 1
				@command.text = @command.text.delete('-')
				life1 -= @command.text.to_i
				@node.replace "Player 1: #{life1}\t\tPlayer 2: #{life2}\n\n"
			end
			if p2 == 1
				@command.text = @command.text.delete('-')
				life2 -= @command.text.to_i
				@node.replace "Player 1: #{life1}\t\tPlayer 2: #{life2}\n\n"
			end
		end
	end
end