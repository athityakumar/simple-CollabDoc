class UserDocument < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :document, optional: true
end
