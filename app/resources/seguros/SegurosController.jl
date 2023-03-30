module SegurosController

using GenieAuthentication, Genie.Renderer, Genie.Exceptions, Genie.Renderer.Html, SearchLight

function index()
  seguros = SearchLight.all(Seguro)
  json(seguros)
end

end
