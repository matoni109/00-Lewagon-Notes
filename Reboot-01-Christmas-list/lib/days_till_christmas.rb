def days_till_christmas
  x_mas = Date.new(2020, 12, 25)
  x_mas.jd - Date.today.jd
end
