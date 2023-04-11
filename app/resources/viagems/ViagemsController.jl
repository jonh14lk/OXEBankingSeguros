module ViagemsController

using GenieAuthentication, Genie.Renderer, Genie.Exceptions, Genie.Renderer.Json, Genie.Router, Genie.Requests
using SearchLight, SearchLight.Validation
using OXEBankingSeguros.Viagems

function index()
  viagems = SearchLight.all(Viagem)
  json(viagems)
end

function show()
  viagem = findone(Viagem, id=params(:id))
  if viagem === nothing
    return JSONException(status=NOT_FOUND, message="Item not found") |> json
  end
  json(viagem)
end

function create()
  viagem = SearchLight.createwith(Viagem, jsonpayload())
  save(viagem)
  json(viagem)
end

function update()
  viagem = findone(Viagem, id=params(:id))
  if viagem === nothing
    return JSONException(status=NOT_FOUND, message="Item not found") |> json
  end
  new_viagem = SearchLight.updatewith(viagem, jsonpayload())
  save(new_viagem)
  json(new_viagem)
end


function delete()
  viagem = findone(Viagem, id=params(:id))
  if viagem === nothing
    return JSONException(status=NOT_FOUND, message="Item not found") |> json
  end
  SearchLight.delete(viagem)
  json(Dict(:id => (:value => params(:id))))
end

end
