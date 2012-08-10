---Lua Slide Show: Exibidor de fotos para TV Digital<br/>
---@author Manoel Campos da Silva Filho<br/> 
---Professor do Instituto Federal de Educação, Ciência e Tecnologia do Tocantins<br/>
---http://manoelcampos.com

---Obtêm a lista de imagens existentes no diretório images
--@return Retorna uma tabela contendo o endereço das imagens localizadas no diretório images.
function findImages()
	--A função utiliza o módulo "os" de lua e executa 
	--o comando find (uma aplicação Linux escrita em C)
	--para buscar as imagens no diretório images e gerar 
    --a saída em um arquivo de texto, contendo a lista 
    --de arquivo encontrados.
	os.execute("find images/ -name *.jpg > imagelist.txt")
	os.execute("find images/ -name *.jpeg >> imagelist.txt")
	os.execute("find images/ -name *.bmp >> imagelist.txt")
	os.execute("find images/ -name *.gif >> imagelist.txt")
	os.execute("find images/ -name *.png >> imagelist.txt")

    --Tabela que armazena o endereço de cada imagem localizada pela função 
    local images = {}
    
    --Carrega o arquivo de texto criado e o percorre linha a linha,
    --adicionando em uma tabela, os endereços das imagens encontradas.
	for line in io.lines("imagelist.txt") do
	   print(#images .. " - " .. line)
	   table.insert(images, line)
	end

    return images
end


---Retorna um novo índice de imagem a ser exibida.
--@param images Tabela contendo a lista de endereços das imagens
--a serem exibidas pela aplicação
--@param index Valor do índice da figura atualmente exibida
--@param forward Se igual a true, incrementa o índice em 1,
--senão, decrementa em 1.
--@returns Retorna o novo índice da figura a ser exibida.
function moveImageIndex(images, index, forward)
  if forward then
  	 index = index + 1
  	 if index > #images then
  	    index = 1
  	 end
  else
  	 index = index - 1
  	 if index <= 0 then
  	    index = #images
  	 end;
  end
  return index
end 

---Exibe a imagem cujo endereço está armazenado
--em images[index].
--@param images Tabela contendo a lista de endereços das imagens
--a serem exibidas pela aplicação
--@param index Valor do índice da figura a ser exibida
function showImage(images, index)
  if #images > 0 then
    print(index .. " - " .. images[index]);
  	canvas:attrColor("black")
  	canvas:drawRect('fill', 0, 0, canvas:attrSize());
	canvas:attrColor("yellow")
	canvas:attrFont("vera", 22)
    --Cria um novo canvas para carregar a imagem
    img = canvas:new(images[index])
    --Desenha a imagem na área destinada à aplicação lua,
    --definida automaticamente dentro do arquivo NCL quando 
    --se associa um region à uma mídia lua.
	canvas:compose(10, 10, img)
	canvas:drawText(15, 10, "Imagem " ..index .. " de " .. #images)
    --Exibe os desenhos realizados no canvas
    canvas:flush()
    
    registerTimer()

    --[[
      event.post {
		   class    = 'ncl',
		   type     = 'attribution',
		   property = 'fileName',
		   action   = 'start',
		   value    = images[index],
		 } 
    --]]
  end
end

---Índice da imagem atualmente exibida
local index = 0

---Tabela que armazena a lista de endereços das imagens
--a serem exibidas na aplicação
local images = findImages()

---Avança para a próxima figura.
--Função utilizada para fazer o 
--avanço automático para a próxima figura
--depois de um determinado tempo,
--tendo comportamento de um slide show. 
function autoForward()
	index = moveImageIndex(images, index, true)
	showImage(images, index)  
end

---Função para registrar um timer
--para avanço das fotos de forma automática,
--após um determinado período de tempo
function registerTimer()
	--Tempo de espera, em milissegundos, para que a foto 
	--avance automaticamente,
	--caso o usuário não pressione as setas <-- ou -->
	local timeout = 3000
	
	--Variável que aponta para uma função
	--utilizada para interromper
	--o avanço automático de fotos
	--quando o usuário pressiona uma 
	--tecla e assim, reiniciar
	--a contagem de tempo.
	if cancelTimerFunc then
	   cancelTimerFunc() --cancela o timer anteriormente criado
	end
	cancelTimerFunc = event.timer(timeout, autoForward)
end

---Função tratadora de eventos recebidos a partir
--da aplicação NCL.
function handler(evt)
  print("Evento disparado: " .. evt.class .. " " .. evt.type)
  --Verifica se uma tecla foi pressionada na aplicação NCL
  if (evt.class == 'key' and evt.type == 'press') then
	  print(evt.key)
      --Se a tecla pressionada foi a seta para direita ou esquerda,
      --altera o índice da imagem a ser exibida.
      --Implementa uma "lista circular" para exibição das imagens.
	  if evt.key == "CURSOR_RIGHT" then
	     index = moveImageIndex(images, index, true)
	  elseif evt.key == "CURSOR_LEFT" then
	     index = moveImageIndex(images, index, false)
	  end
		
	  showImage(images, index)	 
  elseif evt.class == "ncl" and evt.type=="presentation" and evt.action=="start" then
      autoForward()
  end
end

--Registra a função handler como tratador de eventos NCL
event.register(handler)

