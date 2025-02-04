require "test_helper"
require 'mocha/minitest'
class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @project = projects(:one)
    @comment_params = { comment: { body: "New comment" } }
  end

  test "should require authentication for create" do
    post project_comments_url(@project), params: @comment_params
    assert_redirected_to new_user_session_url
  end

  test "should create comment" do
    sign_in @user
    assert_difference('Comment.count') do
      post project_comments_url(@project), params: @comment_params
    end
    assert_redirected_to project_url(@project)
    assert_equal 'Comment added.', flash[:notice]
  end

  test "should not create comment with invalid params" do
    sign_in @user
    invalid_comment_params = { comment: { comment: "" } }
    assert_no_difference('Comment.count') do
      post project_comments_url(@project), params: invalid_comment_params
    end
    assert_redirected_to project_url(@project)
  end
end
