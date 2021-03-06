require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

user = User.new
  user.first_name            = "Jon"
  user.last_name             = "Doe"
  user.email                 = "jd@example.com"
  user.password              = "password"
  user.password_confirmation = "password"
  user.save


describe 'user', type: :feature do

  before do
    page.visit '/signin'
    page.fill_in "Email", with: "jd@example.com"
    page.fill_in "Password", with: "password"
    page.click_on "Signin"
  end

  it 'I can delete a listing' do
    # as a business after I login
    # I can click on a create listing button
    page.visit new_listing_path
    # I fill in the appropriate information
    page.fill_in "Title", with: "Barista"
    page.fill_in "Description", with: "Grinding dem beans"
    page.fill_in "Pay rate", with: "8.00/hr"
    page.choose "part-time"
    # I click the submit button
    # When i got to my listing page I expect to see that job listing
    page.click_on "Create Listing"
    page.visit listings_path
    expect(page).to have_content("Barista")
    page.click_on "Delete"
    page.visit listings_path
    expect(page).not_to have_content("Barista")
  end
end
