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
