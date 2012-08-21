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
local images = {"media/image01.jpeg", "media/image01.jpeg", "media/image01.jpeg", "cartoon.png",  "media/MER_640_480.jpeg"}
local total_pages = #images / 6

local popup_image = nil
function drawPanel(page)

	-- for i=1, 1000 do
    --  a[i] = 0
    -- end



	local img = canvas:new("media/image01.jpeg")
		
	local first = (per_page * page) + 1
	
	canvas:compose(80,100, img )
	canvas:flush()
	writeText(first, 150, 220)
	
	canvas:compose(280,100, img )
	canvas:flush()
	writeText(first + 1, 350, 220)
	
	canvas:compose(480,100, img )
	canvas:flush()
	writeText(first + 2, 550, 220)
	
	canvas:compose(80,270, img )
	canvas:flush()
	writeText(first + 3, 150, 390)
	
	canvas:compose(280,270, img )
	canvas:flush()
	writeText(first + 4, 350, 390)
	
	canvas:compose(480,270, img )
	canvas:flush()
	writeText(first + 5, 550, 390)
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
  	
  	if (evt.key == "CURSOR_DOWN") then
  		canvas:clear()
  		drawPanel(current_page)
  	end 
  	
  	if (evt.key == "CURSOR_UP") then
  		popup_image = canvas:new("image1.jpg")
   		canvas:compose(30,30, popup_image )
   		canvas:flush() 
  	end 
  	
  	if (array_has(valid_keys, evt.key)) then
  		popup_image = canvas:new(images[tonumber(evt.key)])
   		canvas:compose(30,30, popup_image )
   		canvas:flush() 
  	end 
	 
  end
end


--Registra a função handler como tratador de eventos NCL
event.register(handler)