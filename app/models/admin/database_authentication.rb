class Admin::DatabaseAuthentication < ApplicationRecord
  belongs_to :admin

  devise :database_authenticatable, :registerable, :validatable
end
