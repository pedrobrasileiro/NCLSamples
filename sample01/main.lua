require 'util'
require 'parse_xml'
require 'comm/tcp'
require 'comm/rest'

 address = "http://tvdigital.herokuapp.com"
-- address = "http://192.168.1.12:3000"
function writeText(text, x, y)
   text = "".. text
   canvas:attrColor(255,255,255,0)
   canvas:attrFont("vera", 25)
   canvas:drawText(x, y, text)
   canvas:flush() 
end

function logger(text) 
	canvas:attrColor(0,0,0,0)
	canvas:drawRect('fill', 40, 430, 720, 30)
	-- canvas:clear(10, 450, 600, 30)
	writeText(text, 40, 430)
end

local conexao = Rest:new()
local current_page = 0
local per_page = 6
local images = {"media/_image_01.jpeg", "media/_image_02.jpeg", "media/_image_03.jpeg", "media/_image_04.jpeg", "media/_image_05.jpeg", "media/_image_06.jpeg", "media/_image_07.jpeg", "media/_image_08.jpeg"}
local images_thumb = {}
local table_json 


local total_pages = #images / 6

json = require("json")

 -- testString = [[ { "one":1 , "two":2, "primes":[2,3,5,7] } ]]
 

local full_screen = false

local popup_image = nil


function drawItem(my_index, i)
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
    	elseif(my_index == 5) then
			canvas:compose(280,270, img)
			writeText("5", 350, 390)
    	elseif(my_index == 6) then
			canvas:compose(480,270, img)
			writeText("6", 550, 390)
    	end
	end
end


function drawPanel(page)

	logger("Estamos desenhando a pagina: " .. page)
	start_index = (page * per_page) + 1
	end_index = start_index + (per_page - 1)
	
	my_index = 1
	for i=start_index, end_index do
		if (images_thumb[i] ~= nil) then 
			logger("Imagem: " .. images_thumb[i] .. " a desenhar")
			
			drawItem(my_index,i)
		end 
    	my_index = my_index + 1
    end
	canvas:flush()
	local first = (per_page * page) + 1
end

-- drawPanel(current_page)

function handler(evt)
	local valid_keys = {"1","2","3","4","5","6"}
  logger("Evento disparado: " .. evt.class .. " " .. evt.type)
  --Verifica se uma tecla foi pressionada na aplicação NCL
  if (evt.class == 'key' and evt.type == 'press') then
  	if (evt.key == "CURSOR_RIGHT" and not full_screen) then
  	 	-- writeText(evt.key, 200, 200)
  		canvas:clear()
  		current_page = current_page + 1
  		conexao:request("GET", address .. "/full.json?page=" .. current_page, callback)
  		-- drawPanel(current_page)
  	end
  	
  	if (evt.key == "CURSOR_LEFT" and current_page >= 1 and not full_screen) then
  		writeText(evt.key, 200, 200)
  		canvas:clear()
  		current_page = current_page - 1
  		conexao:request("GET", address .. "/full.json?page=" .. current_page, callback)
  		-- drawPanel(current_page)
  	end 
  	
  	if (evt.key == "RED") then
  		if (full_screen) then 
  			canvas:clear()
  			drawPanel(0)
  			full_screen = false
  		end
  	end
  	 
  	if (evt.key == "CURSOR_DOWN") then
  		logger("pra baixo")
  	end
  	
  	if (evt.key == "CURSOR_UP") then
  		logger("pra cima") 
  	end 
  	
  	if (array_has(valid_keys, evt.key)) then
    	if (not full_screen) then
	    	canvas:clear()
	    	
	    	url_full_tv = address .. table_json[tonumber(evt.key)]["url_full_tv"]
	    	conexao:request("GET", url_full_tv, full_show_image)
	    	
	    	
	   		full_screen = true
   		end
  	end 
  end
end

local contador = 1



function full_show_image(data)
	logger("Recebemos a imagem completa")
    -- depurador("Parabens vamos renderizar a imagem!", 320, 20, 1)
    local name_file =  "full.png"
    createFile(data,name_file, true)
    local background_image = canvas:new("media/bg_image.png")
	canvas:compose(0,0, background_image)
	canvas:flush()
	popup_image = canvas:new("full.png")
	canvas:compose(90,30, popup_image )
	canvas:flush() 
end



function showLocalImage(name)

	
	array_push(images_thumb,name)
	drawItem(contador, contador)

    -- local img = canvas:new(name)
    -- canvas:compose(contador * 50, contador * 50, img)
    -- canvas:flush()
    logger("contador: " .. contador .. " ->> Tamanho tabela: " .. #table_json)
    if (contador < #table_json)  then
    	contador = contador + 1
    	logger("Vamos requisitar: " .. address .. table_json[contador]["url_thumbs_tv"])
    	conexao:request("GET",address .. table_json[contador]["url_thumbs_tv"], showImageFile)
    else
    	drawPanel(0)
    end
end

function showImageFile(data)
	logger("Recebemos a imagem")
    -- depurador("Parabens vamos renderizar a imagem!", 320, 20, 1)
    local name_file =  "imagem_" .. contador .. ".png"
    createFile(data,name_file, true)
    logger("Vamos exibir a imagem!")
    showLocalImage(name_file)
end

function showImageFileTwo(data)
	logger("Recebemos a imagem")
    -- depurador("Parabens vamos renderizar a imagem!", 320, 20, 1)
    createFile(data, "imagem2.png", true)
    logger("Vamos exibir a imagem!")
    local img = canvas:new("imagem2.png")
    canvas:compose(100,100, img)
    canvas:flush()
end

function callback(e)
	table_json = json.decode(e)
	-- for k,v in pairs(table_json) do 
	--	if (k == 1) then
	--		conexao:request("GET",address .. v["url_thumbs_tv"], showImageFile)
	--	end 
		
	--end
	if (#table_json > 0) then 
		logger("Vamos requisitar: " .. address .. table_json[1]["url_thumbs_tv"])
		contador = 1
		images_thumb = {}
		
		conexao:request("GET",address .. table_json[1]["url_thumbs_tv"], showImageFile)
		logger("Recebemos!")
	end
 	-- table.foreach(o,print)
 	-- print ("Primes are:")
 	-- table.foreach(o.primes,print)
	
	-- conexao:request("GET","/system/arquivos/imagems/000/000/017/thumbs_tv/cc_CG2011_w0701_Leanna_Decker_00_Profile.jpg", showImageFile)
	
end

 conexao:request("GET", address .. "/full.json", callback)
 logger("Requisitando listagem de imagens.")

--Registra a função handler como tratador de eventos NCL
event.register(handler)