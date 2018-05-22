class Document < ApplicationRecord
  belongs_to :template, optional: true

  has_many :user_documents, dependent: :destroy
  has_many :users, through: :user_documents, dependent: :destroy

  def has_been_signed_by?(user)
 		can_be_signed_by?(user) ? get_user_mapping(user)[0].submitted : false
  end

	def has_to_be_signed_by?(user)
 		return !has_been_signed_by?(user) if can_be_signed_by?(user)
   	false
	end

	def can_be_signed_by?(user)
 		!get_user_mapping(user).empty?
	end

	def get_user_mapping(user)
		UserDocument.where(user_id: user.id, document_id: self.id)
	end
end
