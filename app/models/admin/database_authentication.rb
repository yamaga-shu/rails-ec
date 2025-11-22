class Admin::DatabaseAuthentication < ApplicationRecord
  belongs_to :admin

  devise :database_authenticatable, :validatable
end
