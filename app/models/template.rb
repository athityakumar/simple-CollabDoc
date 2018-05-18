class Template < ApplicationRecord
	has_one_attached :pdf

  has_many :documents

  validates :number_of_signees, presence: true

  def user
    user_id = self.user_id
    User.find(user_id)
  end

  def number_of_pages
  	Dir.entries(self.abs_dir_path).count - 2
  end

  def abs_dir_path
  	Rails.root.join('storage', self.filepath).to_s
  end

  def abs_image_paths
  	(0..self.number_of_pages-1).map do |i|
  		"file://#{self.abs_dir_path}/#{i}.png"
  	end
  end

  def rel_image_paths
  	(0..self.number_of_pages-1).map do |i|
  		"#{i}.png"
  	end
  end
end
