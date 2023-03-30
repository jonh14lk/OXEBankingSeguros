module CreateTableSegurados

import SearchLight.Migrations: create_table, column, columns, pk, add_index, drop_table, add_indices

function up()
  create_table(:segurados) do
    [
      pk()
      column(:documento, :string)
      column(:conta, :string)
      column(:nascimento, :string)
    ]
  end

  add_index(:segurados, :documento)
end

function down()
  drop_table(:segurados)
end

end
