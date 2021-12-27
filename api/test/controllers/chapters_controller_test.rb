require 'test_helper'

class ChaptersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @chapter = chapters(:one)
  end

  test "should get index" do
    get chapters_url, as: :json
    assert_response :success
  end

  test "should create chapter" do
    assert_difference('Chapter.count') do
      post chapters_url, params: { chapter: { favorite: @chapter.favorite, repository_id: @chapter.repository_id, text: @chapter.text, title: @chapter.title, view: @chapter.view } }, as: :json
    end

    assert_response 201
  end

  test "should show chapter" do
    get chapter_url(@chapter), as: :json
    assert_response :success
  end

  test "should update chapter" do
    patch chapter_url(@chapter), params: { chapter: { favorite: @chapter.favorite, repository_id: @chapter.repository_id, text: @chapter.text, title: @chapter.title, view: @chapter.view } }, as: :json
    assert_response 200
  end

  test "should destroy chapter" do
    assert_difference('Chapter.count', -1) do
      delete chapter_url(@chapter), as: :json
    end

    assert_response 204
  end
end
