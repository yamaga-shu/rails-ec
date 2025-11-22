class Admin < ApplicationRecord
  devise :authenticatable

  has_one :database_authentication, class_name: "Admin::DatabaseAuthentication"
  has_one :registration, class_name: "Admin::Registration"
end
