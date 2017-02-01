class Micropost < ActiveRecord::Base
  belongs_to :user
  
  has_many :favorites, class_name: "Favorite",
                       dependent: :destroy
                           
  has_many :favorite_users, through: :favorites, source: :user

  has_many :retweets, class_name: "Micropost", foreign_key: "original_id"
  
  belongs_to :original_micropost, class_name: "Micropost", foreign_key: 'original_id'
  
  def original_user_name
    return '' if original_id.blank?
    original_micropost.user.name
  end

  # リツイートする
  def self.retweet(micropost, user)
    params = {
      user_id: user.id,
      content: micropost.content,
      original_id: micropost.id
    }
    create(params)
    # remicroposts.find_or_create_by(original_id: micropost.id)
  end
      
  # あるマイクロポストをリツイートしているか？
  def retweet_to?(micropost)
    original_id == micropost.id
  end

  def retweet?
    original_id.present?
  end
    
                           
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
