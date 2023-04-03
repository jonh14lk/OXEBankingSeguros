module CreateTableSeguros

import SearchLight.Migrations: create_table, column, columns, pk, add_index, drop_table, add_indices

function up()
  create_table(:seguros) do
    [
      pk()
      column(:valor, :float)
      column(:cobertura, :float)
      column(:carencia, :int)
      column(:vigencia, :int)
      column(:simulacao, :bool)
      column(:data, :string)
      column(:tipo, :int)
      column(:objeto_id, :int)
      column(:segurado_id, :int)
    ]
  end
end

function down()
  drop_table(:seguros)
end

end
