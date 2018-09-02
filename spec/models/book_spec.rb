require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'create時' do
    specify 'updateされたデータが意図通りに更新されているか.' do
      sql = ('SELECT id FROM books')
      rand_id = ActiveRecord::Base.connection.select_all(sql).to_hash.sample["id"]
      rand_book = Book.find(rand_id)
      rand_title = (0...8).map{ ('A'..'Z').to_a[rand(26)] }.join
      rand_memo = (0...8).map{ ('A'..'Z').to_a[rand(26)] }.join
      rand_book.update( title: rand_title, memo: rand_memo )
      result = Book.find(rand_id)
      expect(result).to eq rand_book
    end
  end
end




