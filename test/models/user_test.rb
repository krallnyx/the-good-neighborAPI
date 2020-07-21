require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "is valid with required data" do
    user = User.new(first_name: "John", last_name: "Doe", email: "john@doe.com", password: BCrypt::Password.create('password') )
    user.image.attach(io: File.open(Rails.root.to_s + '/test/fixtures/files/photo.jpg'),  filename: 'image.jpg' , content_type: "image/jpg")
    assert user.valid?
  end

  test "is invalid without first name" do
    user = User.new(first_name: "", last_name: "Doe", email: "john@doe.com", password: BCrypt::Password.create('password') )
    user.image.attach(io: File.open(Rails.root.to_s + '/test/fixtures/files/photo.jpg'),  filename: 'image.jpg' , content_type: "image/jpg")
    refute user.valid?
    assert_not_nil user.errors[:first_name]
  end

  test "is invalid without last name" do
    user = User.new(first_name: "John", last_name: "", email: "john@doe.com", password: BCrypt::Password.create('password') )
    user.image.attach(io: File.open(Rails.root.to_s + '/test/fixtures/files/photo.jpg'),  filename: 'image.jpg' , content_type: "image/jpg")
    refute user.valid?
    assert_not_nil user.errors[:last_name]
  end

  test "is invalid with invalid email" do
    user = User.new(first_name: "John", last_name: "Doe", email: "john.doe@com", password: BCrypt::Password.create('password') )
    user.image.attach(io: File.open(Rails.root.to_s + '/test/fixtures/files/photo.jpg'),  filename: 'image.jpg' , content_type: "image/jpg")
    refute user.valid?
  end

  test "is invalid with already used email" do
    user = User.new(first_name: "Arnaud", last_name: "Jeanroch", email: "arnaud@jeanroch.fr", password: BCrypt::Password.create('password') )
    user.image.attach(io: File.open(Rails.root.to_s + '/test/fixtures/files/photo.jpg'),  filename: 'image.jpg' , content_type: "image/jpg")
    refute user.valid?
    assert_not_nil user.errors[:email]
  end

  test "is invalid with wrong file format" do
    user = User.new(first_name: "John", last_name: "Doe", email: "john.doe@com", password: BCrypt::Password.create('password') )
    user.image.attach(io: File.open(Rails.root.to_s + '/test/fixtures/files/photo.bmp'),  filename: 'medal.svg' , content_type: "image/svg")
    refute user.valid?
    assert_not_nil user.errors[:image]
  end  

  test "is invalid with large file over 3MB" do
    user = User.new(first_name: "John", last_name: "Doe", email: "john.doe@com", password: BCrypt::Password.create('password') )
    user.image.attach(io: File.open(Rails.root.to_s + '/test/fixtures/files/photoBig.jpg'),  filename: 'image2.jpg' , content_type: "image/jpg")
    refute user.valid?
    assert_not_nil user.errors[:image]
  end 

  test "is invalid without password" do
    user = User.new(first_name: "John", last_name: "Doe", email: "john.doe@com", password: '' )
    user.image.attach(io: File.open(Rails.root.to_s + '/test/fixtures/files/photo.jpg'),  filename: 'image.jpg' , content_type: "image/jpg")
    refute user.valid?
    assert_not_nil user.errors[:password]
  end   

end
