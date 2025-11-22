module Admin
  def self.table_name_prefix
    "admin_"
  end
end

class Admin < ApplicationRecord
  has_one :admin_admin_database_authentications
end
