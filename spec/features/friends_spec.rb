RSpec.feature "Friends" do

  def sign_up(first_name: 'Ted',
              last_name: 'Barney',
              email: 'tbarney@barney.com',
              password: '456789',
              password_confirmation: '456789')
    visit '/users/sign_up'
    fill_in 'user_first_name', with: first_name
    fill_in 'user_last_name', with: last_name
    fill_in 'user_email' , with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password_confirmation
    click_button 'Sign up'
  end

  def sign_in(email: 'tbarney@barney.com',
              password: '456789')
    visit '/users/sign_in'
    fill_in "user_email", with: email, visible: false
    fill_in "user_password", with: password
    click_button 'Log in'
  end

  before do
    sign_up
    click_link 'Logout'
    sign_up(first_name: 'Gina',
                last_name: 'Best',
                email: 'gina@gina.com',
                password: '456789',
                password_confirmation: '456789')
  end

  it "User has no friends to begin with" do
    visit "/friends"
    expect(page).not_to have_content "Friends"
  end

  it 'User has one friend' do
    visit "/user_list/index"
    click_button "Add friend"
    visit "/friends"
    expect(page).to have_content "Friend 1"
  end

end
