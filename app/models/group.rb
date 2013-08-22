require_relative '../../db/config'


class Group < ActiveRecord::Base
# implement your Student model here
belongs_to :student
  belongs_to :teacher
end

