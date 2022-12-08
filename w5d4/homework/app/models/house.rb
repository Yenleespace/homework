# == Schema Information
#
# Table name: houses
#
#  id         :bigint           not null, primary key
#  address    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class House < ApplicationRecord # 하우스가 사람을 많이 가질수 있으니까 has many 적어주고 복수형으로 people로 입력
    has_many :people

    def residents
        self.people
    end
end
