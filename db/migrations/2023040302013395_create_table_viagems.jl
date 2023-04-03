module CreateTableViagems

import SearchLight.Migrations: create_table, column, columns, pk, add_index, drop_table, add_indices

function up()
  create_table(:viagems) do
    [
      pk()
      column(:valor, :float)
      column(:meioTransporte, :int)
      column(:destino, :string)
      column(:internacional, :bool)
      column(:destinoSeguro, :bool)
      column(:seguro_id, :int)
    ]
  end

end

function down()
  drop_table(:viagems)
end

end
