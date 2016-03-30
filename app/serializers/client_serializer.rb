class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :sex, :id_number, :phone, :address, :created_at, :updated_at
end
