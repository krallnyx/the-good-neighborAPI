require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @userOne = users(:one)
  end

  test "should not create user without first name" do
    assert_no_difference('User.count') do
      pic = fixture_file_upload('files/photo.jpg','image/jpg')
      post users_url, params: { first_name: '', last_name: 'Doe', image: pic, email: 'kim@gmail.com', password: @userOne.password_digest }     
    end
    assert_response 422
  end

  test "should not create user without last name" do
    assert_no_difference('User.count') do
      pic = fixture_file_upload('files/photo.jpg','image/jpg')
      post users_url, params: { first_name: 'John', last_name: '', image: pic, email: 'kim@gmail.com', password: @userOne.password_digest }     
    end
    assert_response 422
  end

  test "should not create user without email" do
    assert_no_difference('User.count') do
      pic = fixture_file_upload('files/photo.jpg','image/jpg')
      post users_url, params: { first_name: 'John', last_name: 'Doe', image: pic, email: '', password: @userOne.password_digest }     
    end
    assert_response 422
  end

  test "should not create user with invalid email" do
    assert_no_difference('User.count') do
      pic = fixture_file_upload('files/photo.jpg','image/jpg')
      post users_url, params: { first_name: 'John', last_name: 'Doe', image: pic, email: 'hello@gmail', password: @userOne.password_digest }     
    end
    assert_response 422
  end

  test "should not create user without image" do
    assert_no_difference('User.count') do
      pic = fixture_file_upload('files/photo.jpg','image/jpg')
      post users_url, params: { first_name: 'John', last_name: 'Doe', image: {}, email: 'kim@gmail.com', password: @userOne.password_digest }     
    end
    assert_response 422
  end

  test "should not create user with wrong file types" do
    assert_no_difference('User.count') do
      pic = fixture_file_upload('files/photo.bmp','image/bmp')
      post users_url, params: { first_name: 'John', last_name: 'Doe', image: pic, email: 'kim@gmail.com', password: @userOne.password_digest }    
    end
    assert_response 422
  end

  test "should create user with valid data" do
    assert_difference('User.count') do
      pic = fixture_file_upload('files/photo.jpg','image/jpg')
      post users_url, params: { first_name: 'John', last_name: 'Doe', image: pic, email: 'kim@gmail.com', password: @userOne.password_digest }     
    end
    #puts response.body
    #puts response.status
    assert_response 201
  end

  test "should login with valid email and password" do
    post login_users_url, params: { user: { email: @userOne.email, password: '123123' } }, as: :json

    user = JSON.parse(response.body)

    assert_response 200
    assert_equal 'Arnaud', user['first_name']
  end

  test "should not login without email" do
    post login_users_url, params: { user: { email: '', password: '123123' } }, as: :json
    assert_response 401
  end

  test "should not login with invalid email" do
    post login_users_url, params: { user: { email: 'jack@gmail', password: '123123' } }, as: :json
    assert_response 401
  end

  test "should not login without password" do
    post login_users_url, params: { user: { email: @userOne.email, password: '' } }, as: :json
    assert_response 401
  end

end
