require 'rubocop-rspec'
FactoryBot.define do
  factory :book do
    title { 'example_title' }
    memo { 'example_memo' }
    author { 'example_author' }
    picture { 'hoge.png' }
  end
end
