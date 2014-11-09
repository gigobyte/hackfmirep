require 'date'

def openTimer()
	Shoes.app :width => 370, :height => 170 do
		background "images/turn_background.png"
		@seconds = 0 
		@paused = true 

		def display_time 
				@display.clear do
					title "%02d:%02d:%02d" % [ 
					@seconds / (60*60), 
					@seconds / 60 % 60, 
					@seconds % 60 
				  ], :stroke => @paused ? brown : black 
				end
		end 
		def buttons
			@image_start = image "images/sign_start.png", margin_left: 27
			@image_start.click do
				if @item.text.to_i != 0 then
					@seconds = @item.text.to_i*60
					@paused = !@paused
					display_time
				end
			end
			@image_pause = image "images/sign_pause.png"
			@image_pause.click do
				if @seconds != 0 then 
					@paused = !@paused 
				end
				display_time 
			end 
			@image_reset = image "images/sign_reset.png"
			@image_reset.click do
					if @seconds != 0 then
						@paused = !@paused
					end
					@seconds = 0
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
		@item = edit_box width: 370, height: 40, margin_right: 3, margin_top: 10
		para "\n"
		buttons
	end
end

def openCoin()
	Shoes.app :title =>"Coin Flip", width: 150, height: 150 do
		background "images/turn_background.png"
		@image_flip = image "images/sign_flip.png", margin_left: 22
		@image_flip.click {
			side =(rand() * (2)).to_i
			if side==0
				side = "tails"
				@p.path = "images/coin_tails.png"
			else
				side = "heads"
				@p.path = "images/coin_heads.png"
			end
		}
		para "     "
		@p = image "images/empty.png"
	end
end

def openDice()
	Shoes.app :title => "Dice", width: 245, height: 200 do
		background "images/turn_background.png"
		@node = para "Enter the number of sides:\n"
		@node.style(size:15)
		@dice_sides = edit_box width: 200, height: 30, margin_left: 40
		
		@image_sign = image "images/sign_generate.png", margin_left: 70
		@image_sign.click do
			if (@dice_sides.text.to_i > 0)
				dice =(rand() * (@dice_sides.text.to_i)).to_i
				@node2.replace "You rolled: #{dice + 1}"
			else
			@node2.replace "Input a number"
			end
		end
		para "\n\n\n"
		@node2 = para ""
		@node2.style(size:15, margin_left: 65)
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
	save_array = Array.new
	i = 0
	exception = 0
	Shoes.app :title => "Note", width: 500, height: 380 do
		background "images/turn_background.png"
		@note = edit_box width: 250, height: 30, margin_left: 40, margin_top: 5
		@image_add = image "images/sign_add.png", margin_top: 1
		@image_add.click do
			current_time = DateTime.now
			if @note.text != ""
				note_hash[@note.text] = current_time.strftime "%d/%m/%Y %H:%M"
				if exception == 0
					para "\n\n"
					exception = 1
				end
				para "\t#{note_hash.values.last} : #{note_hash.keys.last}\n"
				save_array[i] = note_hash.values.last + " : " + note_hash.keys.last
				i += 1
			end
		end
		@image_save = image "images/sign_savefile.png", margin_top: 1
		@image_save.click do
			if save_array[0] != nil
				File.open("notes.txt", "w+") do |f|
					save_array.each { |element| f.puts(element) }
				end
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
	Shoes.app :width => 400, :height => 240 do
		background "images/turn_background.png"
		dps = 0
		resistance = 1
		res_dps = 0
		para "Base damage:\t\t      "
		@damage = edit_box width: 200, height: 30
		para "\n\n"
		para "Attack speed:\t\t      "
		@attack_speed = edit_box width: 200, height: 30
		para "\n\n"
		para "Enemy Resistance (in %): "
		@resistance = edit_box width: 200, height: 30
		puts "\n\n"
		@image_calc = image "images/sign_calculate.png", margin_left: 150
		@image_calc.click do
			dps = @damage.text.to_f*@attack_speed.text.to_f
			res_dps = dps - (dps / (100 / @resistance.text.to_f))
			@node.replace "Your DPS is #{dps} \nYour DPS including resistance is #{res_dps}"
		end
		para "\n\n"
		@node = para "Your DPS is #{dps} \nYour DPS including resistance is #{res_dps}"
	end
end

def openLife()
	Shoes.app :width => 590, :height =>95 do
		background "images/turn_background.png"
		arr = ["Player 1","Player 2"]
		life1 = 20; life2 = 20; p1 = 0; p2 = 0
		@node = para "\t\t\tPlayer 1: #{life1}\t\tPlayer 2: #{life2}\n\n"
		@node.style(size: 16)
		list_box :items => arr ,width: 200, height: 30, margin_left: 12 do |list|
			if list.text == "Player 1"
				p1 = 1
				p2 = 0
			else
				p2 = 1
				p1 = 0
			end
		end
		@command = edit_box width: 200, height: 30
		@image_add = image "images/block_add.png"
		@image_add.click do
			if p1 == 1 && 
				@command.text = @command.text.delete('+')
				life1 += @command.text.to_i
				@node.replace "\t\t\tPlayer 1: #{life1}\t\tPlayer 2: #{life2}\n\n"
			end
			if p2 == 1
				@command.text = @command.text.delete('+')
				life2 += @command.text.to_i
				@node.replace "\t\t\tPlayer 1: #{life1}\t\tPlayer 2: #{life2}\n\n"
			end
		end
		
		@image_remove = image "images/block_remove.png"
		@image_remove.click do
			if p1 == 1
				@command.text = @command.text.delete('-')
				life1 -= @command.text.to_i
				@node.replace "\t\t\tPlayer 1: #{life1}\t\tPlayer 2: #{life2}\n\n"
			end
			if p2 == 1
				@command.text = @command.text.delete('-')
				life2 -= @command.text.to_i
				@node.replace "\t\t\tPlayer 1: #{life1}\t\tPlayer 2: #{life2}\n\n"
			end
		end
	end
end