class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes

  def three_most_recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def update_posts_counter
    update(posts_counter: posts.count)
  end
end
