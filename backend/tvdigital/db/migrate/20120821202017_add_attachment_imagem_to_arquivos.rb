class AddAttachmentImagemToArquivos < ActiveRecord::Migration
  def self.up
    change_table :arquivos do |t|
      t.has_attached_file :imagem
    end
  end

  def self.down
    drop_attached_file :arquivos, :imagem
  end
end
