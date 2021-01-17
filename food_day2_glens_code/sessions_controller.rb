require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def sign_in
    # Ask for username
    username = @sessions_view.ask_for('username')
    # ask for password
    password = @sessions_view.ask_for('password')
    employee = @employee_repository.find_by_username(username)

    if employee && employee.password == password
      return employee
    else
      @sessions_view.error
      sign_in
    end
  end
end
