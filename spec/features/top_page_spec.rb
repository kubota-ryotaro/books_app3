require 'spec_helper'

describe 'TopPage' do
  specify 'TopPageを確認' do
    visit '/books'
    expect(page).to have_css('h1', text: 'Books')
  end

  specify 'click \'New Book\'時に意図した遷移先にちゃんと飛んでいるか' do
    visit '/books'
    click_link 'New Book'
    expect(page).to have_css('form#new_session')
  end

  specify '/books/newで内容を入力しCreateボタンを押した時、それが遷移先URLで表示されるか' do
    rand_title = (0...8).map{ ('A'..'Z').to_a[rand(26)] }.join
    rand_memo = (0...8).map{ ('A'..'Z').to_a[rand(26)] }.join
    visit '/books/new'
    within('form#new_session') do
      fill_in 'Title', with: rand_title
      fill_in 'Memo', with: rand_memo
      click_button 'Create Book'
    end
    expect(page).to have_css('p', text: rand_title)
    expect(page).to have_css('p', text: rand_memo)
    click_link 'Back'
  end
end

