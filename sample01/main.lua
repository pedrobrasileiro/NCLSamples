require 'util'


function writeText(text, x, y)
   text = "".. text
   canvas:attrColor(255,255,255,0)
   canvas:attrFont("vera", 30)
   canvas:drawText(x, y, text)
   canvas:flush() 
end


local current_page = 0
local per_page = 6
local images = {"media/_image_01.jpeg", "media/_image_02.jpeg", "media/_image_03.jpeg", "media/_image_04.jpeg", "media/_image_05.jpeg", "media/_image_06.jpeg", "media/_image_07.jpeg", "media/_image_08.jpeg"}
local images_thumb = {"media/_image_01_thumb.jpeg", "media/_image_02_thumb.jpeg", "media/_image_03_thumb.jpeg", "media/_image_04_thumb.jpeg", "media/_image_05_thumb.jpeg", "media/_image_06_thumb.jpeg", "media/_image_07_thumb.jpeg", "media/_image_08_thumb.jpeg"}

local total_pages = #images / 6


local full_screen = false

local popup_image = nil
function drawPanel(page)


	start_index = (page * per_page) + 1
	end_index = start_index + (per_page - 1)
	
	my_index = 1
	for i=start_index, end_index do
		if (images_thumb[i] ~= nil) then 
			local img = canvas:new(images_thumb[i])
			
	    	if (my_index == 1) then
	    		canvas:compose(80,100, img)
				writeText("1", 150, 220)
	    	elseif(my_index == 2) then
	    		canvas:compose(280,100, img)
				writeText("2", 350, 220)
	    	elseif(my_index == 3) then
		    	canvas:compose(480,100, img)
				writeText("3", 550, 220)
	    	elseif(my_index == 4) then
	    		canvas:compose(80,270, img)
				writeText("4", 150, 390)
	    	elseif( my_index == 5) then
				canvas:compose(280,270, img)
				writeText("5", 350, 390)
	    	elseif( my_index == 6) then
				canvas:compose(480,270, img)
				writeText("6", 550, 390)
	    	end
    	end
    	my_index = my_index + 1
    end
	
	canvas:flush()


	
		
	local first = (per_page * page) + 1
	
	
	
	
	
	
	
	

	


end

drawPanel(current_page)



function handler(evt)
	local valid_keys = {"1","2","3","4","5","6"}
  print("Evento disparado: " .. evt.class .. " " .. evt.type)
  --Verifica se uma tecla foi pressionada na aplicação NCL
  if (evt.class == 'key' and evt.type == 'press') then
  	if (evt.key == "CURSOR_RIGHT" and not full_screen) then
  	 	writeText(evt.key, 200, 200)
  		canvas:clear()
  		current_page = current_page + 1
  		drawPanel(current_page)
  	end
  	
  	if (evt.key == "CURSOR_LEFT" and current_page >= 1 and not full_screen) then
  		writeText(evt.key, 200, 200)
  		canvas:clear()
  		current_page = current_page - 1
  		drawPanel(current_page)
  	end 
  	
  	if (evt.key == "RED") then
  		if (full_screen) then 
  			canvas:clear()
  			drawPanel(current_page)
  			full_screen = false
  		end
  	end
  	 
  	if (evt.key == "CURSOR_DOWN") then
  		
  	end
  	
  	if (evt.key == "CURSOR_UP") then
  		-- popup_image = canvas:new("image1.jpg")
   		-- canvas:compose(30,30, popup_image )
   		-- canvas:flush() 
  	end 
  	
  	if (array_has(valid_keys, evt.key)) then
    	if (not full_screen) then
	    	canvas:clear()
	    	local background_image = canvas:new("media/bg_image.png")
			canvas:compose(0,0, background_image)
			canvas:flush()
	     	number_key = tonumber(evt.key)
	     	number_image = (current_page * 6) + number_key
	  		popup_image = canvas:new(images[number_image])
	   		canvas:compose(90,30, popup_image )
	   		canvas:flush() 
	   		full_screen = true
   		end
  	end 
  end
end


--Registra a função handler como tratador de eventos NCL
event.register(handler)