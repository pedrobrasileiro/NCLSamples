class Arquivo < ActiveRecord::Base
  attr_accessible :imagem
  has_attached_file :imagem, :styles => { :thumb => "100x100#", :thumbs_tv => "150x113#", :full_tv => "500x375>" }
end
