def openTimer()
	Shoes.app :width => 400, :height => 150 do 
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

		@display = stack :margin_left => 100 
		display_time 

		button "Start/Stop", :width => '50%' do 
		@paused = !@paused
		@seconds = 0
		display_time
	end 
	  
		button "Pause", :width => '50%' do 
			@paused = !@paused 
			display_time 
		end 
	   
		button "Reset", :width => '50%' do 
			@seconds = 0 
			display_time 
	  end 

		animate(1) do 
			@seconds += 1 unless @paused 
			display_time 
		end 
	end 
end