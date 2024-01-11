# spec/models/comment_spec.rb
require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'John Doe', posts_counter: 0) }
  let(:post) { Post.create(title: 'Sample Post', author: user) }
  let(:comment) { described_class.new(user:, post:) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'methods' do
    it 'updates comments counter for the associated post' do
      post.save
      user.save
      comment.save
      comment.update_comments_counter

      post.reload

      expect(post.comments_counter).to eq(1)
    end
  end
end
