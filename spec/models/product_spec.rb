require 'spec_helper'

describe Product do
  context "with correct attributes" do
    it "has a valid factory" do
      expect(create(:product)).to be_valid
    end
  end

  context "with invalid attributes" do
    it "fails without a title" do
      expect(build(:product, title: nil)).to have(1).errors_on(:title)
    end
    it "fails without description" do
      expect(build(:product, description: nil)).to have(1).errors_on(:description)
    end
    it "fails without an image_url" do
      expect(build(:product, image_url: nil)).to have(1).errors_on(:image_url)
    end
    it "fails without a link" do
      expect(build(:product, link: nil)).to have(1).errors_on(:link)
    end
    it "fails without a category" do
      expect(build(:product, category: nil)).to have(1).errors_on(:category)
    end
    it "fails without a type" do
      expect(build(:product, kind: nil)).to have(1).errors_on(:kind)
    end

  end



end
