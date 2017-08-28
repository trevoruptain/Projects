require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  subject(:user) do
    User.create!(
    username: "coolguy3000",
    password: "abc123")
  end

  describe "GET #show" do
    it "renders the show template" do
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of the username and password" do
        post :create, params: {
          user: {
            username: "coolguy3000",
            password: ""
          }
        }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end

      it "validates the length of the password" do
        post :create, params: {
          user: {
            username: "coolguy3000",
            password: "123"
          }
        }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "redirects user to user show on success" do
        post :create, params: {
          user: {
            username: "coolguy3000",
            password: "abc123"
          }
        }
        expect(response).to redirect_to(user_url(User.last))
      end
    end
  end

end
