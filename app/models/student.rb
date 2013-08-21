require_relative '../../db/config'
require 'debugger'
require 'Date'

class Student < ActiveRecord::Base
# implement your Student model here

  def name
    self.first_name + " " + self.last_name
  end

  def age
    now = Date.today
    age = now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
  end

end
