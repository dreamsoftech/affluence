require 'spec_helper'

describe EventsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "for admin" do
    before (:each) do
      @user = Factory.create(:admin)
      sign_in @user
    end
    describe "GET 'new'" do
      it "returns http success" do
        get 'new'
        response.should be_success
      end
    end

    describe "GET 'create'" do
      it "returns http success" do
        get 'create'
        response.should be_success
      end
    end

    describe "GET 'edit'" do
      it "returns http success" do
        get 'edit'
        response.should be_success
      end
    end

    describe "GET 'update'" do
      it "returns http success" do
        get 'update'
        response.should be_success
      end
    end

    describe "GET 'delete'" do
      it "returns http success" do
        get 'delete'
        response.should be_success
      end
    end
  end
end