local img = canvas:new("cartoon.png")
canvas:compose(0,0, img )
        canvas:flush()
function printText()

  print("Ola!")
  event.post ('in', { class='user', data='mydata' })
end
event.timer(1000,printText)
