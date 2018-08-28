class Book < ApplicationRecord
  mount_uploader :picture, PictureUploader

  def self.authenticate(title, memo)
    book = Book.where(title: title, memo: memo).last
  end

  def self.authenticate2(id)
    book = Book.find(id)
  end
end
