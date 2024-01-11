# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { described_class.new(name: 'John Doe', posts_counter: 0) }

  describe 'associations' do
    it { should have_many(:posts).with_foreign_key('author_id') }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should allow_value('John Doe').for(:name) }
    it { should_not allow_value('').for(:name) }
    it { should_not allow_value(nil).for(:name) }

    it { should validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0).allow_nil }
  end

  describe 'methods' do
    describe '#three_most_recent_posts' do
      it 'returns three most recent posts' do
        user.save
        user.posts.create(title: 'Post 1', text: 'Content 1')
        user.posts.create(title: 'Post 2', text: 'Content 2')
        user.posts.create(title: 'Post 3', text: 'Content 3')

        user.posts.each(&:save!)

        expect(user.three_most_recent_posts.count).to eq(3)
      end
    end

    describe '#update_posts_counter' do
      it 'updates posts counter' do
        user.save
        user.posts.create(title: 'Post 1', text: 'Content 1')
        user.posts.create(title: 'Post 2', text: 'Content 2')

        user.update_posts_counter

        expect(user.reload.posts_counter).to eq(2)
      end
    end
  end
end
