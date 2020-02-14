class Movie < ApplicationRecord
  # 動画URLは必須
  validates :url, presence: true
  belongs_to :user
end
