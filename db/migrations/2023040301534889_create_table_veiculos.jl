module CreateTableVeiculos

import SearchLight.Migrations: create_table, column, columns, pk, add_index, drop_table, add_indices

function up()
  create_table(:veiculos) do
    [
      pk()
      column(:valor, :float)
      column(:ano, :int)
      column(:condicao, :int)
      column(:seguro_id, :int)
    ]
  end

end

function down()
  drop_table(:veiculos)
end

end
