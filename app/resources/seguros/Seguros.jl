module Seguros

import SearchLight: AbstractModel, DbId
import Base: @kwdef

export Seguro

@kwdef mutable struct Seguro <: AbstractModel
  id::DbId = DbId()
  valor::Float64 = ""
  cobertura::Float64 = ""
  carencia::Int = ""
  vigencia::Int = ""
  simulacao::Bool = ""
  data::String = ""
end

end
