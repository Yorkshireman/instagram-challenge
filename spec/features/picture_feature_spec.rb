require 'rails_helper'

feature "Picture Features" do
  it "can't be created without an image" do
    sign_up_user
    visit new_picture_path
    fill_in 'Title', with: "Smiley Face"
    click_button 'Create Picture'
    expect(current_path).to eq new_picture_path
    expect(page).to have_content "You must provide an image file to upload"
  end

  it "can upload a picture" do
    upload_picture
    expect(page.status_code).to be 200
    expect(page).to have_content "Picture successfully posted"
  end

  it "uploaded picture title is seen on page" do
    upload_picture
    expect(page).to have_content "Smiley Face"
  end

  it "can't be uploaded without a title" do
    sign_up_user
    visit new_picture_path
    attach_file "Image", 'spec/smiley.png'
    click_button 'Create Picture'

    expect(current_path).not_to eq root_path
    expect(page).to have_content "You must provide an image file to upload"
  end

private
  def upload_picture
    sign_up_user
    visit new_picture_path
    fill_in 'Title', with: "Smiley Face"
    attach_file "Image", 'spec/smiley.png'
    click_button 'Create Picture'
  end

  def sign_up_user
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: "user@email.com"
    fill_in 'Password', with: "passwordpassword"
    fill_in 'Password confirmation', with: "passwordpassword"
    click_button 'Sign up'
  end

  def sign_out
    visit '/'
    click_link 'Sign out'
  end
end