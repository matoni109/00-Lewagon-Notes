 def load_csv(filepath, my_gift_list)
  CSV.foreach(filepath) do |row|
    gift_hash = {}
    gift_hash[:gift_name] = row[0]
    gift_hash[:purchased] = (row[1] == "true") #solution 1
    # gift_hash[:purchased] = row[1] == "true" ? true : false #solution 2
    my_gift_list << gift_hash
  end
end

def save_csv(filepath, gift_list)
  CSV.open(filepath, 'wb') do |csv|
    gift_list.each do |gift|
      csv << [gift[:gift_name], gift[:purchased]]
    end
  end
end


