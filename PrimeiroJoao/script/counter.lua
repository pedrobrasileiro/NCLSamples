local counter = 0
local dx, dy = canvas:attrSize()         -- dimensoes do canvas

function handler (evt)
    if evt.class =='ncl' and evt.type=='attribution' and evt.name=='inc' then 
        if evt.value ~= 'FIM' then 
           counter = counter + evt.value
        else
           canvas:attrColor ('black')
   	     canvas:drawRect('fill',0,0,dx,dy)
           canvas:attrColor ('yellow')
           canvas:attrFont ('vera', 24, 'bold')
           canvas:drawText (10,10, 'O número de vezes que você trocou de ritmo foi: '..counter)
           canvas:flush()
        end
        event.post {
           class   = 'ncl',
           type    = 'attribution',
           name    = 'inc',
           action  = 'stop',
           value   = counter,
        }
    end
end

event.register(handler)
