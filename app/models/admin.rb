class Admin < ApplicationRecord
  devise :authenticatable

  has_one :database_authentication, class_name: "Admin::DatabaseAuthentication"
end
