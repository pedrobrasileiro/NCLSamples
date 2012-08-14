local img = canvas:new("media/image01.jpeg")
canvas:compose(100,150, img )
canvas:flush()

function handler(evt)
  print("Evento disparado: " .. evt.class .. " " .. evt.type)
  --Verifica se uma tecla foi pressionada na aplicação NCL
  if (evt.class == 'key' and evt.type == 'press') then
	  print(evt.key)
  end
end

--Registra a função handler como tratador de eventos NCL
event.register(handler)