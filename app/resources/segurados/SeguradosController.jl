module SeguradosController

using GenieAuthentication, Genie.Renderer, Genie.Exceptions, Genie.Renderer.Json, Genie.Router, Genie.Requests
using SearchLight, SearchLight.Validation
using OXEBankingSeguros.Segurados

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
  segurado = Segurado(documento=jsonpayload("documento"),
    conta=jsonpayload("conta"),
    nascimento=jsonpayload("nascimento"))
  save(segurado)
  json(segurado)
end

function update()
  segurado = findone(Segurado, id=params(:id))
  if segurado === nothing
    return JSONException(status=NOT_FOUND, message="Item not found") |> json
  end
  segurado.documento = jsonpayload("documento")
  segurado.conta = jsonpayload("conta")
  segurado.nascimento = jsonpayload("nascimento")
  save(segurado)
  json(segurado)
end


function delete()
  segurado = findone(Segurado, id=params(:id))
  if segurado === nothing
    return JSONException(status=NOT_FOUND, message="Item not found") |> json
  end
  SearchLight.delete(segurado)
  json(Dict(:id => (:value => params(:id))))
end

end
