using Genie.Router, OXEBankingSeguros.SegurosController, OXEBankingSeguros.SeguradosController

route("/") do
    serve_static_file("welcome.html")
end

route("/hello") do
    "Welcome to Genie!"
end

route("/seguros", SegurosController.index)

route("/segurados", SeguradosController.index)