module Residencias

import SearchLight: AbstractModel, DbId
import Base: @kwdef

export Residencia

@kwdef mutable struct Residencia <: AbstractModel
  id::DbId = DbId()
  valor::Float64 = 0.0
  ano::Int = 2000
  condicao::Int = 1
  localizacao::Int = 1
  seguro_id::Int = 0
end

end
