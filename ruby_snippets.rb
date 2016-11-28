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

# change the header
my_first_sheet[0] = "Key1, Key2, Key3"

# shift the header if it's not on row 0
header_line = 4
my_first_sheet = my_first_sheet[header_line..my_first_sheet.length]

# save an array of arrays to a csv
require 'csv'
File.open(File.join(Rails.root, 'app/documents/file_name.csv'),'w') { |f| f << hash_name.map(&:to_csv).join }

# read csv file and convert the csv rows to a hash (latin-1/utf-8 encoding)
my_csv = CSV.read(File.join(Rails.root, "app/documents/file_name.csv"), headers: true, encoding: "iso-8859-1:utf-8")
my_hash = my_csv.map(&:to_hash)

# Safely merge two hashes (source_hash is the existing hash) with conditions such as 
# Prefer the old value if it's not missing or "NA"/"Sin Datos"/"#N/A"/etc, and if they're both null then the value should be nil
# Works even if there are missing or extra keys in each hash
# Note: casecmp("sindatos").zero? is the same as downcase == 'sindatos'
def deep_safe_merge(source_hash, new_hash)
  source_hash.merge(new_hash) do |_, old, new|
    new_null = (new.nil? || new.to_s.gsub(/[^0-9A-Za-z]/, '') == 'NA' || new.to_s.gsub(/[^0-9A-Za-z]/, '').casecmp("sindatos").zero?)
    old_null = (old.nil? || old.to_s.gsub(/[^0-9A-Za-z]/, '') == 'NA' || old.to_s.gsub(/[^0-9A-Za-z]/, '').casecmp("sindatos").zero?)
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
      
# Find unique values for a particular key in an array of hashes
array_of_hashes.map { |h| h['Name'] }.uniq
      
# Find and replace values using arrays of find and replace values
def find_and_replace(hash_to_search, field, to_replace_array, to_replace_with_array)
  find_replace_hash = Hash[to_replace.zip(to_replace_with)]
  hash_to_search.map do |row|
    next if row[field].nil?
    array_words = row[field].split(/\W+/)
    if (array_words & to_replace).any?
      find_replace_hash.each { |k, v| row[field][k] &&= v }
    end
  end
end

# select all rows where key matches value
new_array_name = hash_or_csv.select { |row| row["Name"] == "anna" }
      
# for an array of words, ruby prefers %w(). Inside this, we don't need commas or quotes 
# e.g. instead of ["red", "green", "blue", "yellow"]
%w(red green blue yellow)
      
# create csv from array of hashes with different keys
headers = array_of_hashes.map(&:keys).flatten.uniq
rows = array_of_hashes.map { |h| h.values_at(*headers) }
File.open(File.join(Rails.root, "name_of_file.csv"), "w") do |csv|
  csv << headers.to_csv
  rows.each do |row|
    csv << row.to_csv
  end
end

# replace binary characters in a string before converting to utf (if there are some errors in force encoding)
def replace_binary_chars(value_to_replace)
  keys = [0xf3, 0xf1, 0xfa, 0xed, 0xe9, 0xe1, 0xda, 0xd3, 0xd1, 0xcd, 0xc9, 0xc1, 0xc3, 0xe3,
          0xc0, 0xc8, 0xcc, 0xd2, 0xd9, 0xe0, 0xe8, 0xec, 0xf2, 0xf9]
  values = %w(ó ñ ú í é á Ú Ó Ñ Í É Á Ã ã
              À È Ì Ò Ù à è ì ò ù)
  to_replace_hash = Hash[keys.zip(values)]
  value_to_replace = value_to_replace&.force_encoding("BINARY")
  to_replace_hash.each do |k, v|
    value_to_replace = value_to_replace&.gsub(k.chr, v.chr)
    break if value_to_replace.encoding.name == "UTF-8"
  end
  value_to_replace&.encode("utf-8")&.mb_chars&.downcase&.to_s
end

if not value&.dup&.force_encoding("utf-8")&.valid_encoding?
  replace_binary_chars(value)
end
