class Admin::DatabaseAuthentication < ApplicationRecord
  self.table_name = "admin_database_authentications"

  belongs_to :admin

  devise :database_authenticatable, :validatable
end
