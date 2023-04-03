module CreateTableResidencias

import SearchLight.Migrations: create_table, column, columns, pk, add_index, drop_table, add_indices

function up()
  create_table(:residencias) do
    [
      pk()
      column(:valor, :float)
      column(:ano, :int)
      column(:condicao, :int)
      column(:localizacao, :int)
      column(:seguro_id, :int)
    ]
  end

end

function down()
  drop_table(:residencias)
end

end
