require 'spec_helper'

describe Post do
  context "with correct attributes" do
    it "has a valid factory" do
      expect(create(:post)).to be_valid
    end
  end

  context "with invalid attributes" do
    it "fails without a title" do
      expect(build(:post, title: nil)).to have(1).errors_on(:title)
    end
    it "fails without content" do
      expect(build(:post, content: nil)).to have(1).errors_on(:content)
    end
  end



end
