require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  let!(:event) { create(:event) } # Use FactoryBot or create an event directly
  let!(:comment) { create(:comment, event: event) }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: { event_id: event.id }, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_attributes) { { content: "Great event!", user_name: "Alice" } }

      it "creates a new comment" do
        expect {
          post :create, params: { event_id: event.id, comment: valid_attributes }, format: :json
        }.to change(Comment, :count).by(1)
      end

      it "returns a created status" do
        post :create, params: { event_id: event.id, comment: valid_attributes }, format: :json
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { content: "" } }

      it "does not create a new comment" do
        expect {
          post :create, params: { event_id: event.id, comment: invalid_attributes }, format: :json
        }.not_to change(Comment, :count)
      end

      it "returns an unprocessable entity status" do
        post :create, params: { event_id: event.id, comment: invalid_attributes }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the comment" do
      expect {
        delete :destroy, params: { event_id: event.id, id: comment.id }, format: :json
      }.to change(Comment, :count).by(-1)
    end

    it "returns no content status" do
      delete :destroy, params: { event_id: event.id, id: comment.id }, format: :json
      expect(response).to have_http_status(:no_content)
    end
  end
end
