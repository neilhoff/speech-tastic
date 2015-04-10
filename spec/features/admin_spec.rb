require 'spec_helper'

feature "Admin" do
  let(:admin) {create(:admin)}
  let(:post) {create(:post)}
  let(:post2) {create(:post, published: true)}

  scenario "Admin Page has all the posts" do
    # Actually create the posts
    post
    post2

    visit "/admin"
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Sign in'

    expect(page).to have_content post.title
    expect(page).to have_content post2.title
    expect(page).to have_content "Publish"
    expect(page).to have_content "Unpublish"
    expect(page).to have_content "Edit", count: 2

  end

end