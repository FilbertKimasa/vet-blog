# spec/models/post_spec.rb
require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John Doe', posts_counter: 0) }
  let(:post) { described_class.new(title: 'Sample Post', text: 'Sample content', author: user) }

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should allow_value('Sample Post').for(:title) }
    it { should_not allow_value('').for(:title) }
    it { should_not allow_value(nil).for(:title) }
    it { should validate_length_of(:title).is_at_most(250) }

    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'methods' do
    it 'returns five most recent comments' do
      user.save
      post.save
      post.comments.create(text: 'Comment 1', user:)
      post.comments.create(text: 'Comment 2', user:)
      post.comments.create(text: 'Comment 3', user:)
      post.comments.create(text: 'Comment 4', user:)
      post.comments.create(text: 'Comment 5', user:)
      post.comments.create(text: 'Comment 6', user:)

      post.comments.each(&:save!)
      post.reload

      expect(post.five_most_recent_comments.count).to eq(5)
    end

    it 'updates comments counter' do
      user.save
      post.save
      post.comments.create(text: 'Comment 1', user:)
      post.comments.create(text: 'Comment 2', user:)

      post.comments.each(&:save!)
      post.update_comments_counter

      expect(post.reload.comments_counter).to eq(2)
    end

    it 'updates likes counter' do
      post.save

      post.likes.create(user:)
      post.likes.create(user:)
      post.likes.each(&:save!)

      post.update_likes_counter

      expect(post.reload.likes_counter).to eq(2)
    end
  end
end
