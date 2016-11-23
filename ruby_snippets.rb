# Make a progress bar
entity_to_count = Entity.all
bar = ProgressBar.new(entity_to_count.count)
entity_to_count.each do |my_entity|
  # do something with them
  bar.increment!
end

# convert two arrays (one of keys, one of values) into a hash
my_hash = Hash[keys_array.zip(values_array)] 

# convert array of strings to array of symbols
string_array = ["My Name", "My age", "My new ADDRESS "]
symbol_array = string_array.map {|elem| elem.downcase.strip.parameterize.underscore.to_sym}
# => [:my_name, :my_age, :my_new_address]

# Parse an excel sheet and select a specific sheet
excel = Roo::Spreadsheet.open(File.join(Rails.root, "file_name.xlsx"))
my_first_sheet = JSON.parse(excel.sheet(0).to_json)
my_second_sheet = JSON.parse(excel.sheet(1).to_json)

# Parse a csv with latin-1 (iso-8859-1) encoding and different separator (';')
my_csv = CSV.read(File.join(Rails.root, 'file_name.csv'), headers: true, col_sep: ';', encoding: "iso-8859-1:utf-8")
headers = my_csv.headers
first_row = my_csv.first

# Edit a csv row by row
my_csv.map do |row|
  row["New column"] = row["Old column"] - 1
end

# The only way I know of to do a deep copy
new_object = Marshal.load( Marshal.dump( old_object ) )

# how to turn an array of arrays, where the first row is an array of headers, into a an array of hashes
# e.g. when you parse an excel sheet
excel = Roo::Spreadsheet.open(File.join(Rails.root, "file_name.xlsx"))
my_first_sheet = JSON.parse(excel.sheet(0).to_json)

# get the header
header = my_first_sheet.shift

my_first_sheet.map! do |ary|
  hsh = Hash.new
  ary.each_with_index{|val,index| hsh[header[index]] = val }
  hsh
end
# this modifies my_first_sheet directly

# save an array of arrays to a csv
require 'csv'
File.open(File.join(Rails.root, 'app/documents/invente.csv'),'w') { |f| f << invente.map(&:to_csv).join }

# Safely merge two hashes (source_hash is the existing hash) with conditions such as 
# Prefer the old value if it's not missing or "NA"/"Sin Datos"/"#N/A"/etc, and if they're both null then the value should be nil
# Works even if there are missing or extra keys in each hash
# Note: casecmp("sindatos") is the same as downcase == 'sindatos'
def deep_safe_merge(source_hash, new_hash)
  source_hash.merge(new_hash) do |_, old, new|
    new_null = (new.nil? || new.to_s.gsub(/[^0-9A-Za-z]/, '') == 'NA' || new.to_s.gsub(/[^0-9A-Za-z]/, '').casecmp("sindatos"))
    old_null = (old.nil? || old.to_s.gsub(/[^0-9A-Za-z]/, '') == 'NA' || old.to_s.gsub(/[^0-9A-Za-z]/, '').casecmp("sindatos"))
    # if the new value is nil, NA or sindatos, then we check the old value
    case [new_null, old_null]
    when [true, true] then nil
    when [true, false] then old
    when [false, true] then new
    when [false, false] then old
    end
  end
end
   
# can use it to merge arrays of hashes on a particular key, in this case "Name" (note: inject and reduce are the same)
def join_new_hsh(initial_array_of_hashes, new_array_of_hashes, on_field = 'Name')
  new_array_of_hashes.reduce(initial_array_of_hashes) do |results, new_info|
    key = new_info[on_field]
    results[key] ||= {}
    results[key] = deep_safe_merge(results[key],new_info)
    results
  end
end

existing_array_of_hashes = join_new_hsh(existing_array_of_hashes, array_of_hashes_to_merge)

# NOTE: each_with_object is preferred over reduce, but you have to swap the order of results/new_info and you don't have to return the object
def join_new_hsh(initial_array_of_hashes, new_array_of_hashes, on_field = 'Name')
  new_array_of_hashes.each_with_object(initial_array_of_hashes) do |new_info, results|
    key = new_info[on_field]
    results[key] ||= {}
    results[key] = deep_safe_merge(results[key],new_info)
  end
end
      
# The result of this method will be a hash of hashes where "Name" is the key. To flatten this we can simply do
existing_array_of_hashes.values
      

      
      
      
