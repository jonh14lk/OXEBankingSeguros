module SeguradosController

using GenieAuthentication, Genie.Renderer, Genie.Exceptions, Genie.Renderer.Html, SearchLight

function index()
  segurados = SearchLight.all(Segurado)
  json(segurados)
end

end
