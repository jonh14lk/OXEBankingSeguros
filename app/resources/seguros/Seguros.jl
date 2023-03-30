module Seguros

import SearchLight: AbstractModel, DbId
import Base: @kwdef

export Seguro

@kwdef mutable struct Seguro <: AbstractModel
  id::DbId = DbId()
  valor::Float64 = 0.0
  cobertura::Float64 = 1
  carencia::Int = 30
  vigencia::Int = 365
  simulacao::Bool = 1
  data::String = ""
end

end
