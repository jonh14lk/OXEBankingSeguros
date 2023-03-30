module SegurosController

using GenieAuthentication, Genie.Renderer, Genie.Exceptions, Genie.Renderer.Json, SearchLight
using OXEBankingSeguros.Seguros

function index()
  seguros = SearchLight.all(Seguro)
  json(seguros)
end

end
