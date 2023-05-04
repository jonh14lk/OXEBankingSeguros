module SeguradosController

using GenieAuthentication, Genie.Renderer, Genie.Exceptions, Genie.Renderer.Json, Genie.Router, Genie.Requests
using SearchLight, SearchLight.Validation
using OXEBankingSeguros.Segurados, OXEBankingSeguros.Seguros, OXEBankingSeguros.Veiculos, OXEBankingSeguros.Residencias, OXEBankingSeguros.Viagems

function index()
  segurados = SearchLight.all(Segurado)
  json(segurados)
end

function show()
  segurado = findone(Segurado, id=params(:id))
  if segurado === nothing
    return JSONException(status=NOT_FOUND, message="Item not found") |> json
  end
  json(segurado)
end

function create()
  segurado = SearchLight.createwith(Segurado, jsonpayload())
  save(segurado)
  json(segurado)
end

function update()
  segurado = findone(Segurado, id=params(:id))
  if segurado === nothing
    return JSONException(status=NOT_FOUND, message="Item not found") |> json
  end
  new_segurado = SearchLight.updatewith(segurado, jsonpayload())
  save(new_segurado)
  json(new_segurado)
end


function delete()
  segurado = findone(Segurado, id=params(:id))
  if segurado === nothing
    return JSONException(status=NOT_FOUND, message="Item not found") |> json
  end
  SearchLight.delete(segurado)
  json(Dict(:id => (:value => params(:id))))
end

function listarSeguros()
  segurado = findone(Segurado, id=params(:id))

  if segurado === nothing
    return JSONException(status=NOT_FOUND, message="Segurado não encontrado") |> json
  end
  
  seguros = SearchLight.find(Seguro, SQLWhereExpression("segurado_id = ?", params(:id)))
  
  retorno = []

  for s in seguros
    objeto = nothing
    
    if s.tipo == 1
      objeto = findone(Veiculo, id=s.objeto_id)
    end
    if s.tipo == 2
      objeto = findone(Residencia, id=s.objeto_id)
    end
    if s.tipo == 3
      objeto = findone(Viagem, id=s.objeto_id)
    end
    
    r = Dict(
      "seguro" => s,
      "objeto" => objeto
    )
    push!(retorno, r)
  end

  json(retorno)
end

end
