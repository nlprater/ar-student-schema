require 'rake'
require 'rspec/core/rake_task'
require 'faker'
require 'debugger'

require_relative 'app/models/teacher'
require_relative 'app/models/group'

require_relative 'db/config'
require_relative 'lib/students_importer'

task :console do
  exec "irb -r./app/models/student.rb -r./app/models/teacher.rb -r./app/models/group.rb"
end

desc "create the database"
task "db:create" do
  touch 'db/ar-students.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/ar-students.sqlite3'
end

desc "migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)."
task "db:migrate" do
  ActiveRecord::Migrator.migrations_paths << File.dirname(__FILE__) + 'db/migrate'
  ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
  ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
    ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
  end
end

desc "populate the test database with sample data"
task "db:populate" do
  StudentsImporter.import
end

desc "populate the test database with sample data"
task "db:addteach" do
  9.times do
    Teacher.create! :first_name => Faker::Name.first_name,
                   :last_name  => Faker::Name.last_name,
                   :email      => Faker::Internet.email,
                   :phone      => Faker::PhoneNumber.phone_number
  end
end

desc "populate the students_to_teachers table with sample data"
task "db:addgroups" do
  2000.times do |i|
    Group.create! :student_id => i,
                  :teacher_id => rand(9)+1
  end
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc "Run the specs"
RSpec::Core::RakeTask.new(:specs)

task :default  => :specs
