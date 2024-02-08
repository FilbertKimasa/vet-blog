RSpec.describe UsersController, type: :controller do
  let!(:users) { create_list(:user, 3) } # Assuming you have FactoryBot configured

  describe 'GET #index' do
    it 'assigns all users as @users' do
      get :index
      expect(assigns(:users)).to eq(users)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #posts' do
    let(:user) { users.first }
    let!(:posts) { create_list(:post, 3, user:) }

    it 'assigns the requested user as @user' do
      get :posts, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'assigns the posts for the requested user as @posts' do
      get :posts, params: { id: user.id }
      expect(assigns(:posts)).to eq(user.posts)
    end

    it 'renders the posts template' do
      get :posts, params: { id: user.id }
      expect(response).to render_template(:posts)
    end
  end
end
