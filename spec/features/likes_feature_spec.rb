require 'rails_helper'

feature 'FEATURE: Likes' do

  let(:image_title) { "Beast and Magneto" }
  let(:image_desc) { "Two cheeky Rabbits" }
  let(:image_file_jpeg) { File.new('spec/fixture/test_rabbits.jpeg') }

  context 'viewing likes on home page' do

    context 'image has no likes' do
      before do
        test_user = create_test_user
        test_image = test_user.images.create(title: image_title, description: image_desc, image_file: image_file_jpeg)
      end

      context 'not signed in' do
        scenario 'can see like counter is 0' do
          visit('/')
          within('.likes-container') do
            expect(page).to have_content('0')
          end
        end
      end
      context 'signed in' do
        scenario 'can see likes counter is 0' do
          sign_up
          visit('/')
          within('.likes-container') do
            expect(page).to have_content('0')
          end
        end
      end
    end

    context 'image has likes' do
      before do
        test_user = create_test_user
        test_image = test_user.images.create(title: image_title, description: image_desc, image_file: image_file_jpeg)
        test_like = test_image.likes.new
        test_like.user = test_user
        test_like.save
      end

      context 'not signed in' do
        scenario 'can see likes' do
          visit('/')
          within('.likes-container') do
            expect(page).to have_content('1')
          end
        end
      end
      context 'signed in' do
        scenario 'can see likes' do
          sign_up
          visit('/')
          within('.likes-container') do
            expect(page).to have_content('1')
          end
        end
      end
    end

  end

  context 'creating likes' do
    before do
      test_user = create_test_user
      test_image = test_user.images.create(title: image_title, description: image_desc, image_file: image_file_jpeg)
    end

    context 'not signed in' do
      scenario 'cannot select to add a like' do
        visit('/')
        expect(page).not_to have_selector('.add-new-like')
      end
    end

    context 'signed in' do
      scenario 'can click to add a new like', js: true do
        sign_up
        visit('/')
        find(:css, '.add-new-like').click
        within(".likes-container") do
          expect(page).to have_content '1'
        end
      end
      scenario 'cannot like more than once', js: true do
        sign_up
        visit('/')
        find(:css, '.add-new-like').click
        wait_for_ajax
        find(:css, '.add-new-like').click
        wait_for_ajax
        within(".likes-container") do
          expect(page).to have_content '1'
        end
      end
      scenario 'like icon changes to show when already liked image', js: true do
        sign_up
        visit('/')
        find(:css, '.add-new-like').click
        wait_for_ajax
        within(".image-container") do
          expect(page).not_to have_content 'favorite_border'
          expect(page).to have_content 'favorite'
        end
      end
      scenario 'on page load, like icon is already changed if image already liked', js: true do
        sign_up
        visit('/')
        find(:css, '.add-new-like').click
        wait_for_ajax
        visit('/')
        within(".image-container") do
          expect(page).not_to have_content 'favorite_border'
          expect(page).to have_content 'favorite'
        end
      end
    end
  end
end
