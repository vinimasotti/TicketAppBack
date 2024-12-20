require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one) # Use a fixture or factory to create an event
    @comment = comments(:one) # Use a fixture or factory to create a comment for the event
  end

  test "should get index" do
    get event_comments_url(@event), as: :json
    assert_response :success
  end

  test "should create comment" do
    assert_difference("Comment.count") do
      post event_comments_url(@event), params: { comment: { content: "Great event!", user_name: "Alice" } }, as: :json
    end
    assert_response :created
  end

  test "should not create comment with invalid data" do
    post event_comments_url(@event), params: { comment: { content: "" } }, as: :json
    assert_response :unprocessable_entity
  end

  test "should destroy comment" do
    assert_difference("Comment.count", -1) do
      delete event_comment_url(@event, @comment), as: :json
    end
    assert_response :no_content
  end
end
