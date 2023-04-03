module Viagems

import SearchLight: AbstractModel, DbId
import Base: @kwdef

export Viagem

@kwdef mutable struct Viagem <: AbstractModel
  id::DbId = DbId()
  meioTransporte::Int = 1
  destino::String = ""
  internacional::Bool = false
  destinoSeguro::Bool = false
  seguro_id::Int = 0
end

end
