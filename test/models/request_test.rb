require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  
  test "is valid with required data" do
    request = Request.new(title: "Dog Walking", user_id: '1', location: "Tower Bridge, London", latitude: 51.505484, longitude: -0.075337,  description: "Please Walk my Retriever, it smells", category: 'service')
    assert request.valid?
  end

  test "is invalid with description over 300 characters" do
    request = Request.new(title: "Dog Walking", user_id: '1', location: "Tower Bridge, London", latitude: 51.505484, longitude: -0.075337,  description: "Please Walk my Retriever, it smells so baaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaad", category: 'service')
    refute request.valid?
    assert_not_nil request.errors[:description]
  end

  test "is invalid without title" do
    request = Request.new(title: "", user_id: '1', location: "Tower Bridge, London", latitude: 51.505484, longitude: -0.075337, description: "Please Walk my Retriever, it smells", category: 'service')
    refute request.valid?
    assert_not_nil request.errors[:title]
  end

  test "is invalid without user_id" do
    request = Request.new(title: "Dog Walking", user_id: '', location: "Tower Bridge, London", latitude: 51.505484, longitude: -0.075337, description: "Please Walk my Retriever, it smells", category: 'service')
    refute request.valid?
    assert_not_nil request.errors[:user_id]
  end

  test "is invalid without location coordinates" do
    request = Request.new(title: "Dog Walking", user_id: '1', location: "", latitude: '', longitude: '', description: "Please Walk my Retriever, it smells", category: 'service')
    refute request.valid?
    assert_not_nil request.errors[:location]
    assert_not_nil request.errors[:latitude]
    assert_not_nil request.errors[:longitude]
  end

  test "is invalid without category" do
    request = Request.new(title: "Dog Walking", user_id: '1', location: "Tower Bridge, London", latitude: 51.505484, longitude: -0.075337, description: "Please Walk my Retriever, it smells", category: '')
    refute request.valid?
    assert_not_nil request.errors[:category]
  end

end
