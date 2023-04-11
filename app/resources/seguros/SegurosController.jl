module SegurosController

using GenieAuthentication, Genie.Renderer, Genie.Exceptions, Genie.Renderer.Json, Genie.Router, Genie.Requests
using SearchLight, SearchLight.Validation
using OXEBankingSeguros.Seguros

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

end
