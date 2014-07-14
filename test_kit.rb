# ----------------------------------------
# A test suite which runs the regex in the
# file 'filter_regex.txt' against the
# example headlines in 'posative_tests.txt'
# and 'positive_tests.txt'. % hit rate is
# output at the end scoring the regex file
# ----------------------------------------

require 'yaml'

# Load regex statements
regex_array    = YAML.load_file("regex.yaml")

# Test against positive tests
pos_file  = File.open("positive_tests.txt")
pos_hits  = 0
pos_miss  = 0
pos_errors  = []
pos_file.each_line do | line |
  miss = true
  regex_array.each do | regex |
    if line.match(regex)
      miss = false
    end
  end
  if miss
    pos_miss += 1
    pos_errors << line
  else
    pos_hits += 1
  end
end
pos_total = pos_hits + pos_miss

# Print pos report
pos_rate = ( pos_hits.to_f / pos_total ) * 100
puts "* * * BAD HEADLINES * * *\n#{pos_total} lines evaluated #{pos_rate.round(2)}% correct"
pos_errors.each { | miss | puts "MISS: #{miss}"}

# Test against negative tests
neg_file  = File.open("negative_tests.txt")
neg_hits  = 0
neg_miss  = 0
neg_errors  = []
neg_file.each_line do | line |
  miss = true
  regex_array.each do | regex |
    if line.match(regex)
      miss = false
    end
  end
  if miss
    neg_miss += 1
  else
    neg_hits += 1
    neg_errors << line
  end
end
neg_total = neg_hits + neg_miss

# Print neg report
neg_rate = ( neg_hits.to_f / neg_total ) * 100
puts "* * * GOOD HEADLINES * * *\n#{neg_total} lines evaluated #{neg_rate.round(2)}% incorrect"
neg_errors.each { | miss | puts "MISS: #{miss}"}