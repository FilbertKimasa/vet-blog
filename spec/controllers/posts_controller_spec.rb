RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) } # Assuming you have FactoryBot configured
  let(:post) { create(:post, user:) }
  let(:comment) { create(:comment, post:) }

  describe 'GET #index' do
    it 'assigns the requested user as @user' do
      get :index, params: { user_id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'assigns all posts with comments for the requested user as @posts' do
      get :index, params: { user_id: user.id }
      expect(assigns(:posts)).to eq(user.posts.includes(:comments))
    end

    it 'renders the index template' do
      get :index, params: { user_id: user.id }
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested user as @user' do
      get :show, params: { user_id: user.id, id: post.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'assigns the requested post as @post' do
      get :show, params: { user_id: user.id, id: post.id }
      expect(assigns(:post)).to eq(post)
    end

    it 'assigns all comments for the requested post as @comments' do
      get :show, params: { user_id: user.id, id: post.id }
      expect(assigns(:comments)).to eq(post.comments)
    end

    it 'renders the show template' do
      get :show, params: { user_id: user.id, id: post.id }
      expect(response).to render_template(:show)
    end
  end
end
