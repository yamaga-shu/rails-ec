class Admin::Registration < ApplicationRecord
  self.table_name = "admin_registraions"

  belongs_to :admin

  devise :registerable, :confirmable, :validatable
end
