class Post < ApplicationRecord
  validates :title, :sub_id, :user_id, presence: :true

  belongs_to :sub

  belongs_to :author,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
end
