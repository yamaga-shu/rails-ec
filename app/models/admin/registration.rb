class Admin::Registration < ApplicationRecord
  self.table_name = "admin_registrations"

  belongs_to :admin

  devise :confirmable
end
