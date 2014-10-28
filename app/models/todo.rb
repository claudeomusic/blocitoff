class Todo < ActiveRecord::Base
    validates :description, length: {minimum: 1}
end
