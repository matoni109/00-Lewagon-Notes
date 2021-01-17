11.Food Delivery.rb

# Model a Hospital
#
#
#patient.#!/usr/bin/env ruby -wKU

class Patient
  # STATE:
  # - name (string)
  # - cured ( Boolean )
  attr_reader :name, :cured
  attr_accessor :room, :id# creates iVAR points to => patient ?

  def initialize(attributes = {})

    @id = attributes[:id]
    @name = attributes[:name]
    @cured = attributes[:cured] || false # use the OR to assign
    @blood_type = attributes[:blood_type]
    #

  end

  def cure
    @cured = true
  end

end

##
Patient.New({name: "John", cured: false, blood_type: "A"})

## 2nd Model
#
# room.rb
require_relative "patient"

class Room

  attr_accessor :id

  class CapacityReachedError < Exception; end
  #STATE
  # - capacity ( FIXNUM)
  # - patients ( Array of Patients instances / LIST  )

  def initialize(attributes = {})
    @capacity = attributes[:capacity] || 0 # use OR
    @patients = attributes[:patients] || [] # use OR
  end

  #BEHAVIOR ? !
  def full?
    @patients.size == @capacity
  end

  def add_patient(patient)
    if full?
      # TODO: something
      fail CapacityReachedError, "The room is full dude "
    else
      @patients << patient
      patient.room = self # gets room from Patient class attr_accessor :room
    end
  end

end
room_1 = Room.new(capacity: 2)
puts "Is it full?"
p room_1.full?

john = Patient.new(name: "John")
# Add the patient to a room
# Ask the patient what room he is in?
room_1.add_patient(john) # Add the patient to a room
# ask patient what room he is in ?
puts john.room


# example  2
#
paul = Patient.New(name: "Paul")
room.add_patient(paul)

# room would be full with RINGO # add iff
begin
  ringo = Patient.New(name: "ringo")
  room.add_patient(ringo)
rescue Room::CapacityReachedError
  puts " Thas fine we don't have room_"
end

#
puts "everything is awesome"

# API example
loop do
  begin
    call_twitter_api
    sleep(60 * 5)
  rescue Timout::Error
    sleep(3500)
  end
end

###
# Storing info on the ROOMS converts to HASH :
# REPO 4 csv
#
def save_csv
  #meals = []
  csv_options = { headers: :first_row, header_converters: :symbol }
  CSV.open(@csv, 'wb') do |row|
    row << %w(id, name, price)
    @meals.each do |meal|
      row << [meal.id, meal.name, meal.price]
    end
  end
end

p patients

# Patient REPO
require 'csv'
require_relative 'patient'

class PatientRepository
  # ID and NAME and CURED and ROOM_ID

  def initialize(csv_file, room_repository)
    @room_repository = room_repository
    @csv_file = csv_file
    @patients = []
    @next_id = 1 # auto incro strategy
    load_csv
  end

  def add(patient)
    patient.id = @next_id
    @next_id += 1
    @patients << patient
    save_csv
  end

  private

  def load_csv

    @next_id = 0
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id]    = row[:id].to_i          # Convert column to Integer
      row[:cured] = row[:cured] == "true"

      # Convert column to boolean
      @patients << Patient.new(row)
      @next_id = row(:id)
    end
    @next_id += 1
  end

end

###
# Room REPO

class RoomRepository

  # ROOM_ID and CAPACITY

  def initialize(csv_file)
    @csv_file = csv_file
    @rooms = []
    @next_id = 1 # auto incro strategy
    load_csv
  end

  # def add(patient)
  #   patient.id = @next_id
  #   @next_id += 1
  #   @patients << patient
  #   save_csv
  # end

  def find(id)
    # Todo: return the room with the spec ID
    @artist.find { |artist | arist.id == id }
  end


  private

  def load_csv

    @next_id = 0
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id]    = row[:id].to_i          # Convert column to Integer
      row[:cured] = row[:cured] == "true"  # Convert column to boolean

      # Fetch from the room repo the room instnace
      # with the ID row[:room id ]
      room = @room_repository.find(row[:room_id])
      patient = Patient.new(row)
      patient.room = room
      @patients << room
      @next_id = row(:id)
    end
    @next_id += 1
  end

end


class Doctor
  # DR ID AND NAME
  attr_accessor :id

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
  end
end

class Appointment
  attr_accessor :id, :doctor, :patient, :date

  def initialize(attributes = {})
    @id = attributes[:id]
    @doctor = attributes[:doctor]
    @patient = attributes[:patient]
    @date = attributes[:date]
  end
end


class AppointmentRepository

  # APP_ID and DATE and PATIENT_ID(foriegn key non model) and DR_ID

  def initialize(csv_file)
    @csv_file = csv_file
    @rooms = []
    @next_id = 1 # auto incro strategy
    load_csv
  end

  # # def add(patient)
  # #   patient.id = @next_id
  # #   @next_id += 1
  # #   @patients << patient
  # #   save_csv
  # # end

  # def find(id)
  #   # Todo: return the room with the spec ID
  # end


  # private

  # def load_csv
  #   rooms = []
  #   @next_id = 0
  #   csv_options = { headers: :first_row, header_converters: :symbol }
  #   CSV.foreach(@csv_file, csv_options) do |row|
  #     row[:id]    = row[:id].to_i          # Convert column to Integer
  #     row[:cured] = row[:cured] == "true"  # Convert column to boolean

  #     # Fetch from the room repo the room instnace
  #     # with the ID row[:room id ]
  #     room = @room_repository.find(row[:room_id])
  #     patient = Patient.new(row)
  #     patient.room = room
  #     @patients << room
  #     @next_id = row(:id)
  #   end
  #   @next_id += 1
  # end

end


class AppointmentsController
  def create_appointment
    doctor_id = @view.ask_for_doctor_id
    patient_id = @view.ask_for_patient_id
    appointment = Appointment.new
    appointment.doctor = @doctor_repository.find(doctor_id)
    appointment.patient = @patient_repository.find(patient_id)
    @appointment_repository.add(appointment)
  end
end
