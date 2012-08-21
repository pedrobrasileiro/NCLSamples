class CreateArquivos < ActiveRecord::Migration
  def change
    create_table :arquivos do |t|
      t.string :nome

      t.timestamps
    end
  end
end
