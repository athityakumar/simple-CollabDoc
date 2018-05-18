class User < ApplicationRecord
	has_secure_password

	validates :name, presence: true
	validates :email, presence: true

  has_many :templates, dependent: :destroy

  has_many :user_documents, dependent: :destroy
  has_many :documents, through: :user_documents, dependent: :destroy
end
