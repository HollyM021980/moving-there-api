class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :token, :first_name, :last_name, :role
end
