## http://www.artfulsoftware.com/infotree/queries.php
## http://ruby.bastardsbook.com/chapters/sql/#placeholders-sqlite-gem
#
#
#
Ruby                  (ex)       DB                    (ex)
--------------------------  <=>  --------------------------
  Model             (Doctor)       Table            (doctors)
Instance      (Doctor.new)       Row
Instance variable  (@name)       Column              (name)
# #
# CRUD
# Create
# Read
# Update
# Delete

CREATE TABLE `doctors` (
  `id`  INTEGER PRIMARY KEY AUTOINCREMENT,
  `name` TEXT,
  `age` INTEGER,
  `specialty` TEXT
);

# https://kitt.lewagon.com/karr/karr.kitt/assets/02_sql_crud_doctors-135696377f22460ebf3508ef121c633c4221a61f1a451ba81db94c5a334ce931.db
def self.all

end

def self.find
end


### flash cards ###
class Post
  def initialize(attributes = {})
    @id = attributes[:id]
    @url = attributes[:url]
    @votes = attributes[:votes] || 0
    @title = attributes[:title]
  end

  def save(db)
    # TODO: write this method using SQLite3::Database instance DB
    if @id.nil?
      DB.execute("INSERT INTO posts (url, votes, title) VALUES (?, ?, ?)", @url, @votes, @title)
      @id = DB.last_insert_row_id
    else
      DB.execute("UPDATE posts SET url = ?, votes = ?, title = ? WHERE id = ?", @url, @votes, @title, @id)
    end
  end
end

# Sample Data

# sqlite> .mode column
# sqlite> .headers on
# sqlite> SELECT * FROM doctors;
# id          name        age         specialty
# ----------  ----------  ----------  ----------------
#   1           John Smith  39          Anesthesiologist
# 2           Emma Reale  31          Cardiologist

# READ

SQL keyword: SELECT

SELECT * FROM doctors
SELECT * FROM doctors WHERE id = 2

No quotes around 2 as its a number.

  CREATE

SQL keyword: INSERT

INSERT keyword to add records to a table.

  INSERT INTO doctors (name, age, specialty)
VALUES ('Dr. Dolladille', 45, 'Dentist')

inserts a new record:

  sqlite> SELECT * FROM doctors;
id          name        age         specialty
----------  ----------  ----------  ----------------
  1           John Smith  39          Anesthesiologist
2           Emma Reale  31          Cardiologist
3           Dr. Dollad  45          Dentist

Autoincrement

Remember the schema definition:

CREATE TABLE `doctors` (
  `id`  INTEGER PRIMARY KEY AUTOINCREMENT,
  `name` TEXT,
  `age` INTEGER,
  `specialty` TEXT
);

UPDATE

SQL keyword: UPDATE

UPDATE keyword to update records in a table.
  Update one record

UPDATE doctors SET age = 40,
  name = 'John Smith' WHERE id = 3;

DELETE

SQL keyword: DELETE

DELETE keyword to delete records from a table.
  DELETE FROM doctors WHERE id = 32

# GMail
UPDATE message deleted=true WHERE id=3135121

# Back to RUBY
# connect to sqlite3
require 'sqlite3'
DB = SQLite3::Database.new("db/doctors.db")

rows = DB.execute('SELECT * FROM doctors')

# app/models/doctor.rb
class Doctor
  attr_reader :id

  def initialize(attributes = {})
    @id = attributes[:id]
    # TODO: store other attributes as instanced variable (exercise)
  end
end

doctor = Doctor.new(name: 'John', age: 42)
doctor.id
# => nil

Example
doctor = Doctor.new(name: 'John', specialty: age: 'Surgeorn')

doctor.save
# Create INSERT INTO
INSERT INTO doctors (name, age, specialty)
VALUES ('Dr. Dolladille', 45, 'Dentist')
DB.last_insert_row_id

# Example 2 An Array of HASHES

DB.results_as_hash = true
doctors = DB.execute("SELECT name, age FROM doctors")
# => [
#      { "name" => "John Smith", "age" => 39 , 0 => "John Smith", 1 => 39 },
#      { "name" => "Emma Reale", "age" => 31 , 0 => "Emma Reale", 1 => 31 }
#    ]

doctor = doctors.first
name = doctor["name"]
age = doctor["age"]
puts "Doctor #{name} is #{age} years old"

## Updating ID's in a Ruby Model
# instantiate doctor in ruby
john = Doctor.new(name: "John", age: 42)

# persist data in DB
DB.execute("INSERT INTO doctors (name, age) VALUES ('John', 42)")

# retrieve id from DB
id = DB.last_insert_row_id

# update ruby instance
john.id = id
