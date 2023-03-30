module Segurados

import SearchLight: AbstractModel, DbId
import Base: @kwdef

export Segurado

@kwdef mutable struct Segurado <: AbstractModel
  id::DbId = DbId()
  documento::String = ""
  conta::String = ""
  nascimento::String = ""
end

end
