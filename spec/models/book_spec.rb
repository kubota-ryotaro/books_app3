require 'rails_helper'

RSpec.describe Book, type: :model do
  describe '.connection_config' do
     it '指定のDBに接続していること' do
       expect(described_class.connection_config[:database]).to match(/books_app3_test/)
       expect(described_class.connection_config[:database]).not_to match(/books_app3_develop/)
     end
  end

  describe 'create時' do
    let(:book) { FactoryBot.create(:book, title: 'title_etc', memo: 'hogehoge')}

    specify 'createされたデータが保存されたかチェックする.' do
      result = Book.authenticate(book.title, book.memo)
      expect(result).to eq book
    end

    specify '削除したデータが存在していないかチェックする.' do
      id = book[:id]
      Book.find(id).destroy
      expect(Book.maximum("id")).to eq id - 1
    end

    specify 'updateされたデータが意図通りに更新されているか.' do
      rand1 = Book.order("RAND()").limit(1)
      rand2 = Book.order("RAND()").limit(1)
      rand = rand1 + rand2
      rand_id = rand[0][:id]
      rand_book = Book.find(rand_id)
      rand_book.update( title: "update title", memo: "update memo" )
      result = Book.authenticate2(rand_id)
      expect(result).to eq rand_book
    end
  end
end




