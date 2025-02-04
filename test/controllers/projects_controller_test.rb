require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @project = projects(:one)
    sign_in @user
  end

  test "should get index" do
    get projects_url
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should show project" do
    get project_url(@project)
    assert_response :success
    assert_not_nil assigns(:comments)
  end

  test "should update project with valid params" do
    previous_status = @project.status
    patch project_url(@project), params: { project: { status: 'completed' } }
    assert_redirected_to project_url(@project)
    assert_equal 'completed', @project.reload.status
    assert_equal "changed status from #{previous_status} to #{@project.status}", @project.comment_threads.last.comment
  end

  test "should not update project with invalid params" do
    patch project_url(@project), params: { project: { status: nil } }
    assert_template :show
    assert_not_equal nil, @project.reload.status
  end

  test "should get show" do
    get project_url(@project)
    assert_response :success
  end

  test "should not update project if unauthorized" do
    sign_out @user
    patch project_url(@project), params: { project: { status: 'completed' } }
    assert_redirected_to new_user_session_url
  end

  test "should create comment on status change" do
    previous_status = @project.status
    assert_difference('@project.comment_threads.count') do
      patch project_url(@project), params: { project: { status: 'completed' } }
    end
    assert_equal "changed status from #{previous_status} to #{@project.reload.status}", @project.comment_threads.last.comment
  end

  test "should not create comment if update fails" do
    assert_no_difference('@project.comment_threads.count') do
      patch project_url(@project), params: { project: { status: nil } }
    end
  end

  test "should get index only for current user projects" do
    other_user = users(:two)
    other_project = projects(:two)
    other_project.update(users: [other_user])

    get projects_url
    assert_response :success
    assert_not_includes assigns(:projects), other_project
  end
end
