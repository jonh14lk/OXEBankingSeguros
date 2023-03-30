module SeguradosController

using GenieAuthentication, Genie.Renderer, Genie.Exceptions, Genie.Renderer.Json, SearchLight
using OXEBankingSeguros.Segurados

function index()
  segurados = SearchLight.all(Segurado)
  json(segurados)
end

end
