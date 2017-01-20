class Micropost < ActiveRecord::Base
  belongs_to :user
  
  has_many :favorites, class_name: "Favorite",
                       dependent: :destroy
                           
  has_many :favorite_users, through: :favorites, source: :user
                           
                           
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
