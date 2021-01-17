class SessionsView
  def ask_for(label)
    puts "Enter #{label}"
    print "> "
    gets.chomp
  end

  def error
    puts "Incorrect details"
  end
end
