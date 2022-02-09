require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "should save user given all fields" do
      @user = User.new
      @user.first_name = "jim"
      @user.last_name = "testman"
      @user.email = "jim@testman.com"
      @user.password = "hunter2"
      @user.password_confirmation = "hunter2"
      @user.save
      expect(@user.valid?).to be true
    end

    it "should validate that passwords match" do
      @user = User.new
      @user.first_name = "jim"
      @user.last_name = "testman"
      @user.email = "jim@testman.com"
      @user.password = "hunter2"
      @user.password_confirmation = "2retnuh"
      @user.save
      expect(@user.errors.messages[:password_confirmation]).to include "doesn't match Password"
    end

    it "should validate that passwords are 6 or more characters" do
      @user = User.new
      @user.first_name = "jim"
      @user.last_name = "testman"
      @user.email = "jim@testman.com"
      @user.password = "12345"
      @user.password_confirmation = "12345"
      @user.save
      expect(@user.errors.messages[:password]).to include "is too short (minimum is 6 characters)"
    end

    it "should validate that the password exists" do
      @user = User.new
      @user.first_name = "jim"
      @user.last_name = "testman"
      @user.email = "jim@testman.com"
      @user.save
      expect(@user.errors.messages[:password]).to include "can't be blank"
    end

    it "should validate that email is unique" do
      @user1 = User.create(first_name: 'Jim', last_name: 'Testman', email: "jim@testman.com", password: "hunter2", password_confirmation: "hunter2")
      expect(@user1.valid?).to be true
      @user2 = User.create(first_name: 'Jim', last_name: 'Testman', email: "JIM@TESTMAN.com", password: "hunter2", password_confirmation: "hunter2")
      expect(@user2.errors.messages[:email]).to include "has already been taken"
    end

    it "should validate that the email exists" do
      @user = User.new
      @user.first_name = "jim"
      @user.last_name = "testman"
      @user.password = "hunter2"
      @user.password_confirmation = "hunter2"
      @user.save
      expect(@user.errors.messages[:email]).to include "can't be blank"
    end

    it "should validate that the first_name exists" do
      @user = User.new
      @user.last_name = "testman"
      @user.email = "jim@testman.com"
      @user.password = "hunter2"
      @user.password_confirmation = "hunter2"
      @user.save
      expect(@user.errors.messages[:first_name]).to include "can't be blank"
    end

    it "should validate that the last_name exists" do
      @user = User.new
      @user.first_name = "jim"
      @user.email = "jim@testman.com"
      @user.password = "hunter2"
      @user.password_confirmation = "hunter2"
      @user.save
      expect(@user.errors.messages[:last_name]).to include "can't be blank"
    end
  end

  describe '.authenticate_with_credentials' do
    it "should return instance of user if user exists and authentication is successful" do
      @user = User.create(first_name: 'Jim', last_name: 'Testman', email: "jim@testman.com", password: "hunter2", password_confirmation: "hunter2")
      expect(@user.authenticate_with_credentials('jim@testman.com', 'hunter2')).to be_instance_of(User)
    end

    it "should return nil if authentication is unsuccessful" do
      @user = User.create(first_name: 'Jim', last_name: 'Testman', email: "jim@testman.com", password: "2retnuh", password_confirmation: "hunter2")
      expect(@user.authenticate_with_credentials('jim@testman.com', 'hunter2')).to be nil
    end
  end
end
