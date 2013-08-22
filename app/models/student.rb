require_relative '../../db/config'
require 'debugger'
require 'Date'

class Student < ActiveRecord::Base
# implement your Student model here
  has_many :groups, :foreign_key => :student_id
  has_many :teachers, :through => :groups

  validates :email, uniqueness: true, format: { with: /.{1,}@.{1,}[.].{2,}/ }
  validates :age, :numericality => { :greater_than => 4 }
  validates :phone, length: { minimum: 10 , tokenizer: lambda { |str| str.scan(/\d/) }}
 
  def name
    self.first_name + " " + self.last_name
  end

  def age
    now = Date.today
    age = now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
  end

end
