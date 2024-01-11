# spec/models/like_spec.rb
require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'John Doe', posts_counter: 0) }
  let(:post) { Post.create(title: 'Sample Post', author: user) }
  let(:like) { described_class.new(user:, post:) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'methods' do
    it 'updates likes counter for the associated post' do
      post.save
      user.save
      like.save
      like.update_likes_counter

      post.reload

      expect(post.likes_counter).to eq(1)
    end
  end
end
