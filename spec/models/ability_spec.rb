require 'spec_helper'
require "cancan/matchers"

describe Ability do
  describe "User" do
    describe "abilities" do
      subject(:ability){ Ability.new(user) }
      let(:user){ nil }

      context "when is an admin" do
        let(:user){ create(:admin) }
        it{ should be_able_to(:manage, Post.new) }
        it{ should be_able_to(:manage, Product.new) }
      end

      context "when is a user" do
        let(:user){ create(:user) }
        it{ should_not be_able_to(:manage, Post.new) }
        it{ should_not be_able_to(:read, Post.new(published: false)) }
        it{ should be_able_to(:read, Post.new(published: true)) }

        it{ should_not be_able_to(:manage, Product.new) }
        it{ should be_able_to(:read, Product.new) }
      end
    end
  end
end