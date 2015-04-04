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
      end

      context "when is a user" do
        let(:user){ create(:user) }
        it{ should_not be_able_to(:manage, Post.new) }

      end
    end
  end
end