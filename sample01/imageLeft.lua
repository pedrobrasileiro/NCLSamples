local img = canvas:new("image1.jpg")
canvas:compose(50,200, img )
        canvas:flush()

function handler (evt)
  print(evt.class)
end
event.register(handler) 
