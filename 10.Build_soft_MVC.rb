
# Build Software
#
# Data Structures
#
# Array and Hashes
#
# Last in First Out
#
# Model => 1
# View => no logic
# Controler
#

class Stack
  def initialize
    @elements = []
  end

  def push(element)
    @elements << element
  end

  def pop
    @elements.delete_at(-1)
  end
end

EXample 2

class Queue
  def initialize
    @elements = []
  end

  def enqueue(element)
    @elements << element
  end
  def dequeue
    @elements.delete_at(0)
  end
end

beatles = %w(john paul george)

# ENQUEUE: => element is added at the end of the array.
beatles.push("ringo")

beatles.length
# => 4
p beatles
# => [ "john", "paul", "george", "ringo" ]

# DEQUEUE: first element of the array is picked.
beatle = beatles.shift
# => "john"

p beatles
# => [ "paul", "george", "ringo" ]


#1 :: what is a task ? # 1 The Modal or Recipe

class Task # this is the model
  attr_reader :description

  def initialize(description)
    @description = description
    @done = false
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end
end

#
#  TASK HOLDER/ storage repo

class TaskRepository # or DATABASE
  def initialize
    @tasks = [] # array of Task Instances
  end

  # Behavior  # CRUD
  def add(task) # task parameter is a task instance
    @tasks << task
  end

  def all
    @tasks
  end

  def find(index)
    @tasks[index]
  end

  def remove(index)
    @tasks.delete_at(index)
  end
end

# User Imput

class TasksView # Puts and Gets Stuff !
  def display(tasks)
    # task in an arrat of task instances
    tasks.each_with_index do |task, index|
      done = task.done? ? "[x]" : "[ ]"
      puts "#{done} #{index + 1} - #{task.description}"
    end
  end

  def ask_user_for_description
    puts "What do you want to do?"
    return gets.chomp
  end

  def ask_user_for_index
    puts "Index?"
    return gets.chomp.to_i - 1
  end
end

#  / CONTROLER
require_relative 'task'
require_relative 'tasks_view'

class TasksController
  def initialize(repository)
    @repository = repository
    @view = TasksView.new
  end

  def list
    display_tasks
  end

  def create
    # 1. Get description from view
    description = @view.ask_user_for_description
    # 2. Create new task
    task = Task.new(description)
    # 3. Add to repo
    @repository.add(task)
  end

  def mark_as_done
    # 1. Display list with indices
    display_tasks
    # 2. Ask user for index
    index = @view.ask_user_for_index
    # 3. Fetch task from repo
    task = @repository.find(index)
    # 4. Mark task as done
    task.mark_as_done!
  end

  def destroy
    # 1. Display list with indices
    display_tasks
    # 2. Ask user for index
    index = @view.ask_user_for_index
    # 3. Remove from repository
    @repository.remove(index)
  end

  private

  def display_tasks
    # 1. Fetch tasks from repo
    tasks = @repository.all
    # 2. Send them to view for display
    @view.display(tasks)
  end
end

# User Brain :

class Router
  def initialize(controller)
    @controller = controller
  end

  def run
    loop do
      print_actions
      action = gets.chomp.to_i
      dispatch(action)
    end
  end

  private

  def print_actions
    puts "\n---"
    puts 'What do you want to do?'
    puts '1 - Display tasks'
    puts '2 - Add a new task'
    puts '3 - Mark a task as done'
    puts '4 - Remove a task'
    puts '---'
  end

  def dispatch(action)
    case action
    when 1 then @controller.list
    when 2 then @controller.create
    when 3 then @controller.mark_as_done
    when 4 then @controller.destroy
    else
      puts "Please type 1, 2, 3 or 4 :)"
    end
  end
end


#MVC PART 2

#1 is the MODEL [Flat | USER | Comment | ] # each moldel needs a REPO
# Class that is an instnace
# name and description
# pass the instance variables to it
# New IVAR ??

# 2 is the REPO ( only holds info nil logic )
# takes the informatoin
# Persistance is done in the REPO
# Holdin

# 3 is the CONTROLER ( exicute the code of a user aciton )
# CRUD for all Controllers
# Add a recipe
# List a recipe/s
# Web Search
# has the parsing object to start with ::


# Controler => fetch from the REPO => Sends it to the => VIEW

# 4 is the VIEW it PUTS and GETS
# PUTS the information back to the user in HTML
# Gets
# UPDATE THE VIEW

# 5 Router
# Voice mail member 1 to Add
# Dispatces user intent => to the right method in the controller
#
#

# SRP
# single reposibility principle
#
# Each class does just one thing
#
#
