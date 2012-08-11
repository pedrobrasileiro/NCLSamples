local img = canvas:new("image1.jpg")
canvas:compose(0,0, img )
        canvas:flush()

function handler (evt)
  print(evt.class)
end
event.register(handler) 
