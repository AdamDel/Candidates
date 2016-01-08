# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program

candidates_to_check = @candidates

def find(id)
  return @candidates.select{|x| x[:id]==id}
end

def experienced?(candidate)
  #Returns true if the candidate has 2 years of experience or more
  if (candidate[:years_of_experience] >= 2)
    return true 
  else 
    return false 
  end
end

# More methods will go below

def days_ago_applied(candidate)
  return (Time.now.to_date - candidate[:date_applied]).to_i
end



def qualified_candidates
  qualified = []
  @candidates.each do |x| 
    if more_than_100_points?(x)&&ruby_or_python?(x)&&applied_15_days?(x)&&older_than_17?(x)
      qualified << x
    end
  end
  return qualified
end



def more_than_100_points?(candidate)
  if(candidate[:github_points] > 100)
    return true
  else
    return false
  end
end

def ruby_or_python?(candidate)
  if candidate[:languages].include?("Ruby") || candidate[:languages].include?("Python")
    return true
  else
    return false
  end
end

def applied_15_days?(candidate)
  if days_ago_applied(candidate) <= 15
    return true
  else
    return false
  end
end

def older_than_17?(candidate)
  if candidate[:age] > 17
    return true
  else 
    return false 
  end
end 

def order_by_qualifications
  sorted = @candidates.sort {|a, b| [b[:years_of_experience], b[:github_points]] <=> [a[:years_of_experience], a[:years_of_experience]]}
  return sorted
end

def menu
  loop do
  puts "SELECTION: "
  input = gets.chomp

  case input
  when /^find (\d?\d)$/
    id = /^find (\d*)$/.match(input)[1].to_i
    puts id
    
    pp find(id)
  when /^all$/
    pp @candidates
  when /^qualified$/
    pp qualified_candidates
  when /^quit$/
    break
  else puts 'Invalid command'
  end
end
end









