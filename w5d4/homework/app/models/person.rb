# == Schema Information
#
# Table name: people
#
#  id         :bigint           not null, primary key
#  name       :string
#  age        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  house_id   :integer
#
class Person < ApplicationRecord 
    belongs_to :house
    validates :name, presence: true # 이름이 있으면 true 없으면 false
    valid 

end
