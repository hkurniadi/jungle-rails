require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "Validations" do
    context "if password does not match password_confirmation" do
      it "should not save the new user" do
        @user = User.new({
            first_name: "Bob",
            last_name: "Klob",
            email: "bobk@email.com",
            password: "qwertyqwerty",
            password_confirmation: "qwert"
          })
        expect{ @user.save! }.to raise_error(ActiveRecord::RecordInvalid)
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end

    context "if password matches password_confirmation" do
      it "should save the new user" do
        @user = User.new({
            first_name: "Bob",
            last_name: "Klob",
            email: "bobk@email.com",
            password: "qwertyqwerty",
            password_confirmation: "qwertyqwerty"
          })
        expect(@user.save!).to be true
      end
    end

    context "given email already exists and and not case sensitive" do
      it "should not save the new user" do
        @user1 = User.new({
            first_name: "Bob",
            last_name: "Klob",
            email: "bobk@email.com",
            password: "qwertyqwerty",
            password_confirmation: "qwertyqwerty"
          })
        @user1.save
        @user2 = User.new({
          first_name: "Bob",
          last_name: "Klap",
          email: "Bobk@email.com",
          password: "qwertyqwerty",
          password_confirmation: "qwertyqwerty"
          })
        expect{ @user2.save! }.to raise_error(ActiveRecord::RecordInvalid)
        expect(@user2.errors.full_messages).to include("Email has already been taken")
      end
    end

    context "given the three field set except email" do
      it "should not save the new user" do
        @user = User.new({
            first_name: "Bob",
            last_name: "Klob",
            password: "qwertyqwerty",
            password_confirmation: "qwertyqwerty"
          })
        expect{ @user.save! }.to raise_error(ActiveRecord::RecordInvalid)
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
    end

    context "given the three field set except first name" do
      it "should not save the new user" do
        @user = User.new({
            last_name: "Klob",
            email: "bob@email.com",
            password: "qwertyqwerty",
            password_confirmation: "qwertyqwerty"
          })
        expect{ @user.save! }.to raise_error(ActiveRecord::RecordInvalid)
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
    end

    context "given the three field set except last name" do
      it "should not save the new user" do
        @user = User.new({
            first_name: "Bob",
            email: "bob@email.com",
            password: "qwertyqwerty",
            password_confirmation: "qwertyqwerty"
          })
        expect{ @user.save! }.to raise_error(ActiveRecord::RecordInvalid)
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
    end
  end
end
