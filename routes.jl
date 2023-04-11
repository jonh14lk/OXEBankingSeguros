using Genie.Router, OXEBankingSeguros.SegurosController, OXEBankingSeguros.SeguradosController
using OXEBankingSeguros.ResidenciasController, OXEBankingSeguros.VeiculosController, OXEBankingSeguros.ViagemsController

route("/") do
    serve_static_file("welcome.html")
end

route("/seguros", SegurosController.index, method=GET)
route("/seguros", SegurosController.create, method=POST)
route("/seguros/:id::Int", SegurosController.update, method=POST)
route("/seguros/:id::Int", SegurosController.show, method=GET)
route("/seguros/:id::Int", SegurosController.delete, method=DELETE)

route("/segurados", SeguradosController.index, method=GET)
route("/segurados", SeguradosController.create, method=POST)
route("/segurados/:id::Int", SeguradosController.update, method=POST)
route("/segurados/:id::Int", SeguradosController.show, method=GET)
route("/segurados/:id::Int", SeguradosController.delete, method=DELETE)

route("/residencias", ResidenciasController.index, method=GET)
route("/residencias", ResidenciasController.create, method=POST)
route("/residencias/:id::Int", ResidenciasController.update, method=POST)
route("/residencias/:id::Int", ResidenciasController.show, method=GET)
route("/residencias/:id::Int", ResidenciasController.delete, method=DELETE)

route("/veiculos", VeiculosController.index, method=GET)
route("/veiculos", VeiculosController.create, method=POST)
route("/veiculos/:id::Int", VeiculosController.update, method=POST)
route("/veiculos/:id::Int", VeiculosController.show, method=GET)
route("/veiculos/:id::Int", VeiculosController.delete, method=DELETE)

route("/viagems", ViagemsController.index, method=GET)
route("/viagems", ViagemsController.create, method=POST)
route("/viagems/:id::Int", ViagemsController.update, method=POST)
route("/viagems/:id::Int", ViagemsController.show, method=GET)
route("/viagems/:id::Int", ViagemsController.delete, method=DELETE)