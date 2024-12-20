require "test_helper"

class CommentTest < ActiveSupport::TestCase #inherited class
  setup do #preparing for the test 
    @event = events(:one) # Assuming a fixture or factory for events exists
    @valid_comment_params = { content: "Good Event", user_name: "Vinny", event: @event }
  end

  test "should be valid with valid attributes" do
    comment = Comment.new(@valid_comment_params)
    assert comment.valid?
  end

  test "should not be valid without content" do
    comment = Comment.new(@valid_comment_params.merge(content: ""))
    assert_not comment.valid?
    assert_includes comment.errors[:content], "can't be blank"
  end

  test "should not be valid without user_name" do
    comment = Comment.new(@valid_comment_params.merge(user_name: ""))
    assert_not comment.valid?
    assert_includes comment.errors[:user_name], "can't be blank"
  end

  test "should belong to an event" do
    comment = Comment.new(@valid_comment_params.merge(event: nil))
    assert_not comment.valid?
    assert_includes comment.errors[:event], "must exist"
  end
end
