module Seguros

import SearchLight: AbstractModel, DbId
import Base: @kwdef

export Seguro

@kwdef mutable struct Seguro <: AbstractModel
  id::DbId = DbId()
  valor::Float64 = 0.0
  cobertura::Float64 = 0.0
  carencia::Int = 30
  vigencia::Int = 365
  simulacao::Bool = 1
  data::String = ""
  tipo::Int = 1 # 1 = auto, 2 = residencial, 3 = viagem
  objeto_id::Int = 0
  segurado_id::Int = 0
end

end
