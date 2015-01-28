class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :blog
  validates :title, presence: true
end
