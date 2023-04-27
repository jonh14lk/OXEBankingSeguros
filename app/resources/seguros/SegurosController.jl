module SegurosController

using GenieAuthentication, Genie.Renderer, Genie.Exceptions, Genie.Renderer.Json, Genie.Router, Genie.Requests
using SearchLight, SearchLight.Validation
using OXEBankingSeguros.Seguros, OXEBankingSeguros.Residencias, OXEBankingSeguros.Veiculos, OXEBankingSeguros.Viagems, OXEBankingSeguros.Segurados
using Dates

function index()
  seguros = SearchLight.all(Seguro)
  json(seguros)
end

function show()
  seguro = findone(Seguro, id=params(:id))
  if seguro === nothing
    return JSONException(status=NOT_FOUND, message="Item not found") |> json
  end
  json(seguro)
end

function create()
  seguro = SearchLight.createwith(Seguro, jsonpayload())
  save(seguro)
  json(seguro)
end

function update()
  seguro = findone(Seguro, id=params(:id))
  if seguro === nothing
    return JSONException(status=NOT_FOUND, message="Item not found") |> json
  end
  new_seguro = SearchLight.updatewith(seguro, jsonpayload())
  save(new_seguro)
  json(new_seguro)
end


function delete()
  seguro = findone(Seguro, id=params(:id))
  if seguro === nothing
    return JSONException(status=NOT_FOUND, message="Item not found") |> json
  end
  SearchLight.delete(seguro)
  json(Dict(:id => (:value => params(:id))))
end


function simularSeguro()

  # Busca segurado
  if haskey(jsonpayload(), "segurado_id")
    segurado_id = jsonpayload("segurado_id")
    s = findone(Segurado, id=segurado_id)
  end

  # Se não achou, vai tentar criar um novo
  if s === nothing
    if !haskey(jsonpayload(), "segurado")
      return JSONException(status=BAD_REQUEST, message="Segurado não informado") |> json
    end

    dados_segurado = Dict(jsonpayload("segurado"))
    s = SearchLight.createwith(Segurado, dados_segurado)
    s |> SearchLight.save!!
    segurado_id = s.id
  end

  # Verifica tipo de seguro / inicializa outros dados
  tipo = jsonpayload("tipo")
  objeto = nothing
  valor_seguro = 1000

  # Tratando seguro de veículo
  if tipo == 1
    if !haskey(jsonpayload(), "veiculo")
      return JSONException(status=BAD_REQUEST, message="Veículo não informado") |> json
    end
    
    dados_veiculo = Dict(jsonpayload("veiculo"))
    v = SearchLight.createwith(Veiculo, dados_veiculo)
    v |> SearchLight.save!!
    println(v)

    # Regra 1: Valor base do seguro = 5% do valor do carro
    valor_seguro = 0.05 * v.valor
    
    # Regra 2: Valor aumenta se carro é do ano ou se tem 10 ou mais anos
    ano_atual = Year(today())
    ano_carro = Year(v.ano)
    diff_anos = ano_atual - ano_carro

    if diff_anos == Year(0) || diff_anos >= Year(10)
      valor_seguro += 0.1 * valor_seguro 
    end

    # Regra 3: Valor aumenta de acordo com a condição do carro
    if v.condicao == 2 # 1 = boa, 2 = ruim ???
      valor_seguro += 0.1 * valor_seguro 
    end
    
    objeto = v
  
  # Tratando seguro residencial
  elseif tipo == 2
    if !haskey(jsonpayload(), "residencia")
      return JSONException(status=BAD_REQUEST, message="Residência não informada") |> json
    end

    dados_residencia = Dict(jsonpayload("residencia"))
    v = SearchLight.createwith(Residencia, dados_residencia)
    v |> SearchLight.save!!
    objeto = v
    
    # Regra 1: valor base de 2,5% da residencia
    valor_seguro = 0.025 * objeto.valor

    # Regra 2: Valor aumenta se residencia tem 25 ou mais anos
    ano_atual = Year(today())
    ano_res = Year(v.ano)
    diff_anos = ano_atual - ano_res

    if diff_anos == Year(0) || diff_anos >= Year(25)
      valor_seguro += 0.15 * valor_seguro 
    end

    # Regra 3: Valor aumenta de acordo com a condição da casa
    if v.condicao == 2 # 1 = boa, 2 = ruim ???
      valor_seguro += 0.1 * valor_seguro 
    end

    # Regra 4: Valor aumenta de acordo com a localização da casa
    if v.condicao == 2 # 1 = comum, 2 = área de risco ???
      valor_seguro += 0.1 * valor_seguro 
    end
  
  # Tratando seguro de viagens
  elseif tipo == 3
    if !haskey(jsonpayload(), "viagem")
      return JSONException(status=BAD_REQUEST, message="Viagem não informada") |> json
    end

    dados_viagem = Dict(jsonpayload("viagem"))
    v = SearchLight.createwith(Viagem, dados_viagem)
    v |> SearchLight.save!!
    objeto = v

    # Regra 1: valor base de 10% da viagem
    valor_seguro = 0.1 * objeto.valor

    # Regra 2: Valor aumenta se for internacional
    if v.internacional
      valor_seguro += 0.5 * valor_seguro 
    end

    # Regra 3: Valor aumenta de acordo com meio de transporte
    if v.meioTransporte == 1 # 1 = rodoviario, 2 = aereo, 3 = maritimo
      valor_seguro += 0.1 * valor_seguro
    elseif v.meioTransporte == 2
      valor_seguro += 0.25 * valor_seguro
    elseif v.meioTransporte == 3
      valor_seguro += 0.2 * valor_seguro
    end

    # Regra 4: Valor aumenta se destino não for seguro
    if !v.destinoSeguro
      valor_seguro += 0.5 * valor_seguro
    end
  
  else
    return JSONException(status=BAD_REQUEST, message="Tipo inválido") |> json
  end

  # Cria e salva o seguro
  seguro = Seguro(valor=valor_seguro, tipo=tipo, data=string(today()), objeto_id=objeto.id, segurado_id=segurado_id)
  seguro |> SearchLight.save!!

  # Atualiza o objeto com a id do seguro
  objeto.seguro_id = seguro.id
  objeto |> SearchLight.save!!

  # Retorna os dados
  retorno = Dict(
    "seguro" => seguro,
    "objeto" => objeto
  )

  json(retorno)
end

end
