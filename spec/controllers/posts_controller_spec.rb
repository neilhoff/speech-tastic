require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe PostsController do

  # This should return the minimal set of attributes required to create a valid
  # Post. As you add validations to Post, be sure to
  # adjust the attributes here as well.
  let(:user) {create :user}
  let(:valid_attributes) { { title: Faker::Lorem.word, content: Faker::Lorem.paragraph, published: true, user_id: user.id  } }
  let(:more_valid_attributes){ { title: Faker::Lorem.word, content: Faker::Lorem.paragraph, published: false, user_id: user.id   } }

  describe "authentication" do
    login_admin
    it "should have a current_user" do
      expect(subject.current_user).to_not be_nil
    end
  end


  describe "GET index" do
    it "assigns all published posts as @posts" do
      post = Post.create!  valid_attributes
      post2 = Post.create! more_valid_attributes # This one is not published show it will not show up in expect
      get :index, {}
      expect(assigns(:posts)).to eq([post])
    end
  end

  describe "GET show" do
    it "assigns the requested post as @post" do
      post = Post.create! valid_attributes
      get :show, {:id => post.to_param}
      expect(assigns(:post)).to eq(post)
    end
  end

  describe "GET new" do
    login_admin
    it "assigns a new post as @post" do
      get :new, {}
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "GET edit" do
    login_admin
    it "assigns the requested post as @post" do
      post = Post.create! valid_attributes
      get :edit, {:id => post.to_param}
      expect(assigns(:post)).to eq(post)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      login_admin
      it "creates a new Post" do
        expect {
          post :create, {:post => valid_attributes}
        }.to change(Post, :count).by(1)

      end

      it "assigns a newly created post as @post" do
        post :create, {:post => valid_attributes}
        expect(assigns(:post)).to be_a(Post)
        expect(assigns(:post)).to be_persisted
      end

      it "redirects to the created post" do
        post :create, {:post => valid_attributes}
        expect(response).to redirect_to(Post.last)
      end
    end

    describe "with invalid params" do
      login_admin
      it "assigns a newly created but unsaved post as @post" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Post).to receive(:save).and_return(false)
        post :create, {:post => { "title" => nil }}
        expect(assigns(:post)).to be_a_new(Post)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Post).to receive(:save).and_return(false)
        post :create, {:post => { "title" => nil }}
        expect(response).to render_template("new")
      end

      it "fails without a user_id" do
        allow_any_instance_of(Post).to receive(:save).and_return(false)
        post :create, {:post => { user_id: nil }}
        expect(assigns(:post)).to be_a_new(Post)

      end
    end
  end

  describe "PUT update" do
    login_admin
    describe "with valid params" do
      it "updates the requested post" do
        post = Post.create! valid_attributes
        # Assuming there are no other posts in the database, this
        # specifies that the Post created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Post).to receive(:update).with({ "title" => "MyString" })
        put :update, {:id => post.to_param, :post => { "title" => "MyString" }}
      end

      it "assigns the requested post as @post" do
        post = Post.create! valid_attributes
        put :update, {:id => post.to_param, :post => valid_attributes}
        expect(assigns(:post)).to eq(post)
      end

      it "redirects to the post" do
        post = Post.create! valid_attributes
        put :update, {:id => post.to_param, :post => valid_attributes}
        expect(response).to redirect_to(post)
      end
    end

    describe "with invalid params" do
      it "assigns the post as @post" do
        post = Post.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Post).to receive(:save).and_return(false)
        put :update, {:id => post.to_param, :post => { "title" => "invalid value" }}
        expect(assigns(:post)).to eq(post)
      end

      it "re-renders the 'edit' template" do
        post = Post.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Post).to receive(:save).and_return(false)
        put :update, {:id => post.to_param, :post => { "title" => "invalid value" }}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    login_admin
    it "destroys the requested post" do
      post = Post.create! valid_attributes
      expect {
        delete :destroy, {:id => post.to_param}
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      post = Post.create! valid_attributes
      delete :destroy, {:id => post.to_param}
      expect(response).to redirect_to(posts_url)
    end
  end

  describe "PUT publish" do
    login_admin
    it "publishes the post" do
      post = Post.create! valid_attributes
      put :publish, {id: post.id}

      expect(post.reload.published).to equal(true)
    end

    it "redirects to the edit post path" do
      post = Post.create! valid_attributes
      put :publish, {id: post.id}

      expect(response).to redirect_to(edit_post_path(post))
    end


  end

  describe "PUT unpublish" do
    login_admin
    it "unplublishes the post" do
      post = Post.create! valid_attributes
      put :unpublish, {id: post.id}

      expect(post.reload.published).to equal(false)
    end

    it "redirects to the edit post path" do
      post = Post.create! valid_attributes
      put :unpublish, {id: post.id}

      expect(response).to redirect_to(edit_post_path(post))
    end
  end

  describe "GET all" do
    login_admin
    it "assigns all published posts as @posts" do
      post = Post.create! valid_attributes
      post2 = Post.create! more_valid_attributes # This one is not published
      get :all, {}
      expect(assigns(:posts)).to eq([post2, post])
    end
  end
end