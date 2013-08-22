require_relative '../../db/config'
require 'debugger'
require 'Date'

class Teacher < ActiveRecord::Base
  has_many :groups, :foreign_key => :teacher_id
  has_many :students, :through => :groups

# implement your Student model here
  validates :email, uniqueness: true, format: { with: /.{1,}@.{1,}[.].{2,}/ }
  validates :phone, length: { minimum: 10 , tokenizer: lambda { |str| str.scan(/\d/) }}
 
  def name
    self.first_name + " " + self.last_name
  end


end
