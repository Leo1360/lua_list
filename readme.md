# Lua List
Adiciona a classe List com algumas funcionalidades para listas como map, reduce e foreach. 

## Utilização
Para criar uma lista basta adicionar chamar o metodo `new()`:

    lista = List:new()

Podemos também passar uma table em formato de array para que o dados ja sejam incluídos na lista:

    tabela = {1,2,3,4,5,6,7,8,9}
    lista = List:new(tabela)
    
Itens também podem ser adicionados ao final da lista com o método `add()`e removido com `pop()`;

    lista:add(10)
	    -- lista = {1,2,3,4,5,6,7,8,9,10}
    lista:pop()
	    -- lista = {1,2,3,4,5,6,7,8,9}
	lista:pop(3)
	    -- lista = {1,2,4,5,6,7,8,9}
Podemos acessar os itens utilizando brackets "[]" ou com o método `get()`:

	    -- lista = {1,2,3,4,5,6,7,8,9}
    lista[2]
	    -- 2
    lista:get(7)
	    -- 7
O tamanho da lista pode ser obtida com o `#lista`:

    #lista
	    -- 9

Podemos utilizar outros metodos conforme forem necessários como map por exemplo:

	    -- lista = {1,2,3,4,5,6,7,8,9}
    lista:map(function(val) return 2*val end)
	    -- lista = {2,4,6,8,10,12,14,16,18}

## Instalação
Para instalar basta colocar o arquivo `List.lua` no seu projeto. Essa biblioteca depende da lib [Simple_Lua_Class](https://github.com/Leo1360/Simple_Lua_Class) então ela tambem precisa ser adicionada ao seu projeto.