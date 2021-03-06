module UserHelpers
  def sign_up(email: 'test@example.com', user_name: 'PhotoN3rd')
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: email)
    fill_in('User name', with: user_name)
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  def sign_out
    visit('/')
    click_link('Sign out')
  end

  def create_test_user(email: 'test@test.com')
    User.create(email: email, password: 'testtest', password_confirmation: 'testtest', user_name: 'PhotoN3rd')
  end
end
