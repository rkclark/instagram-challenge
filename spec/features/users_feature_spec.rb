require 'rails_helper'

feature "FEATURE: User can sign in and out" do
  context "user not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end
  end

  context "user signed in on the homepage" do
    before do
      sign_up
    end

    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end

    it "can sign out" do
      visit('/')
      click_link('Sign out')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end
  end
end

feature 'FEATURE: Sign up' do
  context 'validations' do
    scenario 'can sign up with a username' do
      sign_up(user_name: 'tt')
      expect(page).to have_content('User name is too short (minimum is 6 characters)')
    end
  end

end
