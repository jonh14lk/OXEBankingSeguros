module VeiculosController

using GenieAuthentication, Genie.Renderer, Genie.Exceptions, Genie.Renderer.Json, Genie.Router, Genie.Requests
using SearchLight, SearchLight.Validation
using OXEBankingSeguros.Veiculos

function index()
  veiculos = SearchLight.all(Veiculo)
  json(veiculos)
end

function show()
  veiculo = findone(Veiculo, id=params(:id))
  if veiculo === nothing
    return JSONException(status=NOT_FOUND, message="Item not found") |> json
  end
  json(veiculo)
end

function create()
  veiculo = SearchLight.createwith(Veiculo, jsonpayload())
  save(veiculo)
  json(veiculo)
end

function update()
  veiculo = findone(Veiculo, id=params(:id))
  if veiculo === nothing
    return JSONException(status=NOT_FOUND, message="Item not found") |> json
  end
  new_veiculo = SearchLight.updatewith(veiculo, jsonpayload())
  save(new_veiculo)
  json(new_veiculo)
end


function delete()
  veiculo = findone(Veiculo, id=params(:id))
  if veiculo === nothing
    return JSONException(status=NOT_FOUND, message="Item not found") |> json
  end
  SearchLight.delete(veiculo)
  json(Dict(:id => (:value => params(:id))))
end

end
