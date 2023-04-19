module Veiculos

import SearchLight: AbstractModel, DbId
import Base: @kwdef

export Veiculo

@kwdef mutable struct Veiculo <: AbstractModel
  id::DbId = DbId()
  valor::Float64 = 0.0
  ano::Int = 2000
  condicao::Int = 1
  seguro_id::Int = 0
  modelo::String = ""
end

end
