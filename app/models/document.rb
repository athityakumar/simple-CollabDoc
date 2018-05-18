class Document < ApplicationRecord
  belongs_to :template, optional: true

  has_many :user_documents, dependent: :destroy
  has_many :users, through: :user_documents, dependent: :destroy
end
