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
local total_pages = #images / 6

local popup_image = nil
function drawPanel(page)


	start_index = (page * per_page) + 1
	end_index = start_index + (per_page - 1)
	
	my_index = 1
	for i=start_index, end_index do
		local img = canvas:new(images[i])
    	if (my_index == 1) then
    		canvas:compose(80,100, img)
			canvas:flush()
			writeText("1", 150, 220)
    	elseif(my_index == 2) then
    		canvas:compose(280,100, img)
			canvas:flush()
			writeText("2", 350, 220)
    	elseif(my_index == 3) then
	    	canvas:compose(480,100, img)
			canvas:flush()
			writeText("3", 550, 220)
    	elseif(my_index == 4) then
    		canvas:compose(80,270, img)
			canvas:flush()
			writeText("4", 150, 390)
    	elseif( my_index == 5) then
			canvas:compose(280,270, img)
			canvas:flush()
			writeText("5", 350, 390)
    	elseif( my_index == 6) then
			canvas:compose(480,270, img)
			canvas:flush()
			writeText("6", 550, 390)
    	end
    	my_index = my_index + 1
    end



	
		
	local first = (per_page * page) + 1
	
	
	
	
	
	
	
	

	


end

drawPanel(current_page)



function handler(evt)
	local valid_keys = {"1","2","3","4","5","6"}
  print("Evento disparado: " .. evt.class .. " " .. evt.type)
  --Verifica se uma tecla foi pressionada na aplicação NCL
  if (evt.class == 'key' and evt.type == 'press') then
  	if (evt.key == "CURSOR_RIGHT") then
  	 	writeText(evt.key, 200, 200)
  		canvas:clear()
  		current_page = current_page + 1
  		drawPanel(current_page)
  	end
  	
  	if (evt.key == "CURSOR_LEFT" and current_page >= 1) then
  		writeText(evt.key, 200, 200)
  		canvas:clear()
  		current_page = current_page - 1
  		drawPanel(current_page)
  	end 
  	
  	if (evt.key == "RED") then
  		canvas:clear()
  		drawPanel(current_page)
  	end 
  	
  	if (evt.key == "CURSOR_UP") then
  		popup_image = canvas:new("image1.jpg")
   		canvas:compose(30,30, popup_image )
   		canvas:flush() 
  	end 
  	
  	if (array_has(valid_keys, evt.key)) then
      canvas:clear()
      number_key = tonumber(evt.key)
      number_image = (current_page * 6) + number_key
  		popup_image = canvas:new(images[number_image])
   		canvas:compose(30,30, popup_image )
   		canvas:flush() 
  	end 
	 
  end
end


--Registra a função handler como tratador de eventos NCL
event.register(handler)