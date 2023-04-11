module ResidenciasController

using GenieAuthentication, Genie.Renderer, Genie.Exceptions, Genie.Renderer.Json, Genie.Router, Genie.Requests
using SearchLight, SearchLight.Validation
using OXEBankingSeguros.Residencias

function index()
  residencias = SearchLight.all(Residencia)
  json(residencias)
end

function show()
  residencia = findone(Residencia, id=params(:id))
  if residencia === nothing
    return JSONException(status=NOT_FOUND, message="Item not found") |> json
  end
  json(residencia)
end

function create()
  residencia = SearchLight.createwith(Residencia, jsonpayload())
  save(residencia)
  json(residencia)
end

function update()
  residencia = findone(Residencia, id=params(:id))
  if residencia === nothing
    return JSONException(status=NOT_FOUND, message="Item not found") |> json
  end
  new_residencia = SearchLight.updatewith(residencia, jsonpayload())
  save(new_residencia)
  json(new_residencia)
end


function delete()
  residencia = findone(Residencia, id=params(:id))
  if residencia === nothing
    return JSONException(status=NOT_FOUND, message="Item not found") |> json
  end
  SearchLight.delete(residencia)
  json(Dict(:id => (:value => params(:id))))
end

end
