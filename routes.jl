using Genie.Router, OXEBankingSeguros.SegurosController, OXEBankingSeguros.SeguradosController

route("/") do
    serve_static_file("welcome.html")
end

route("/hello") do
    "Welcome to Genie!"
end

route("/seguros", SegurosController.index)

route("/segurados", SeguradosController.index, method=GET)
route("/segurados", SeguradosController.create, method=POST)
route("/segurados/:id::Int", SeguradosController.update, method=POST)
route("/segurados/:id::Int", SeguradosController.show, method=GET)
route("/segurados/:id::Int", SeguradosController.delete, method=DELETE)