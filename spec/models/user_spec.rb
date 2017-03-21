require 'rails_helper'
# TODO refactor codes, DRY out your code
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

    context "given password too short" do
      it "should not save the new user" do
        @user = User.new({
            first_name: "Bob",
            last_name: "Klob",
            email: "bob@email.com",
            password: "qwert",
            password_confirmation: "qwert"
          })
        expect{ @user.save! }.to raise_error(ActiveRecord::RecordInvalid)
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
      end
    end

    context "given password too short" do
      it "should not save the new user" do
        @user = User.new({
            first_name: "Bob",
            last_name: "Klob",
            email: "bob@email.com",
            password: "qwert",
            password_confirmation: "qwert"
          })
        expect{ @user.save! }.to raise_error(ActiveRecord::RecordInvalid)
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
      end
    end

    context "given password is at least 8 characters long" do
      it "should save the new user" do
        @user = User.new({
            first_name: "Bob",
            last_name: "Klob",
            email: "bob@email.com",
            password: "qwertqwerty",
            password_confirmation: "qwertqwerty"
          })
        expect(@user.save!).to be true
      end
    end
  end

  describe ".authenticate_with_credentials" do
    context "given right email and password" do
      it "should return an instance of the user" do
        @user = User.new({
            first_name: "Bib",
            last_name: "Bob",
            email: "beepbeep@email.com",
            password: "qwertyqwerty",
            password_confirmation: "qwertyqwerty"
          })
        @user.save
        @instance_of_user = User.find_by(email: "beepbeep@email.com").try(:authenticate, "qwertyqwerty")
        expect(@instance_of_user).to_not be nil
      end
    end

    context "given wrong email and right password" do
      it "should not return an instance of the user" do
        @user = User.new({
            first_name: "Bib",
            last_name: "Bob",
            email: "beepbeep@email.com",
            password: "qwertyqwerty",
            password_confirmation: "qwertyqwerty"
          })
        @user.save
        @instance_of_user = User.find_by(email: "bepbeep@email.com").try(:authenticate, "qwertyqwerty")
        expect(@instance_of_user).to be nil
      end
    end

    context "given right email and wrong password" do
      it "should not return an instance of the user" do
        @user = User.new({
            first_name: "Bib",
            last_name: "Bob",
            email: "beepbeep@email.com",
            password: "qwertyqwerty",
            password_confirmation: "qwertyqwerty"
          })
        @user.save
        @instance_of_user = User.find_by(email: "beepbeep@email.com").try(:authenticate, "qwertyqwer")
        expect(@instance_of_user).to be false
      end
    end
  end
end
