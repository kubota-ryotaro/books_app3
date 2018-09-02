require 'spec_helper'

describe 'TopPage' do
  specify 'create　/books/newで内容を入力しCreateボタンを押した時、それがDBに反映され、遷移先URLで表示されるか' do
    rand_title = (0...8).map{ ('A'..'Z').to_a[rand(26)] }.join
    rand_memo = (0...8).map{ ('A'..'Z').to_a[rand(26)] }.join
    visit '/books/new'
    within('form#new_session') do
      fill_in 'Title', with: rand_title
      fill_in 'Memo', with: rand_memo
      click_button 'Create Book'
    end
    result = Book.find_by(title: rand_title, memo: rand_memo)
    expect(result).not_to eq nil
    expect(page).to have_css('p', text: rand_title)
    expect(page).to have_css('p', text: rand_memo)
  end

  specify 'update  /booksでEditリンクから更新したとき、それがDBに反映され、遷移先URLで表示されるか' do
    visit '/books'
    first('tbody tr').click_link 'Edit'
    rand_title = (0...8).map{ ('A'..'Z').to_a[rand(26)] }.join
    rand_memo = (0...8).map{ ('A'..'Z').to_a[rand(26)] }.join
    within('form#new_session') do
      fill_in 'Title', with: rand_title
      fill_in 'Memo', with: rand_memo
      click_button 'Update Book'
    end
    result = Book.find_by(title: rand_title, memo: rand_memo)
    expect(result).not_to eq nil
    expect(page).to have_css('p', text: rand_title)
    expect(page).to have_css('p', text: rand_memo)
  end

  specify 'destroy  /booksでDestroyリンクから削除をしたとき、それがDBに反映されるか' do
    visit '/books/new'
    rand_title = (0...8).map{ ('A'..'Z').to_a[rand(26)] }.join
    rand_memo = (0...8).map{ ('A'..'Z').to_a[rand(26)] }.join
    within('form#new_session') do
      fill_in 'Title', with: rand_title
      fill_in 'Memo', with: rand_memo
      click_button 'Create Book'
    end
    visit '/books'
    book = Book.find_by(title: rand_title, memo: rand_memo)
    click_link 'Destroy', href: book_path(book)
    result = Book.find_by(title: rand_title, memo: rand_memo)
    expect(result).to eq nil
  end
end

