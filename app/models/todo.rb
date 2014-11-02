class Todo < ActiveRecord::Base
  require 'date'
    
  validates :description, length: {minimum: 1}
  belongs_to :user

  default_scope {order('created_at DESC')}

  def days_left
    date_created_at =  Date.parse(self.created_at.to_s)
    (date_created_at + 7 - Date.today).to_i
  end

end
