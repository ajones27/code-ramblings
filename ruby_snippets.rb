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

# update entries based on a mapping
mapping = {
    "Comunidad Autónoma De Canarias" => "Gobierno de Canarias",
    "Comunidad Autónoma De Castilla Y León" => "Junta de Castilla y león",
    "Comunidad Autónoma De Cataluña" => "Generalitat de Cataluña",
    "Comunidad Autónoma De Madrid" => "Comunidad de Madrid",
}
mappings.each do |k ,v|
  Debtor.find_by(name: k).update_attributes! name: v
end

# Investor portfolio report
require "timecop"
# Suppresses the output
ActiveRecord::Base.logger.level = 1
# The report we want, as seen on the investor portfolio page
# investors/portfolio/invoices_table_component.rb
report = []
# If we use a specific database backup
Timecop.freeze("2017-02-01 07-00-00".to_time) do
  i = Investor.find(570)
  # 570 for AGC
  ip = Investors::InvestorPresenter.new(i)
  auctions = i.auctions.map { |a| Investors::Portfolio::AuctionDetailsPresenter.new(a) }
  report = auctions.map do |a|
    next unless a.has_been_sold
    ap = AuctionPresenter.new(a.decorated)
    b = BidPresenter.new(a.decorated.bids.find_by(investor_id: i.id))
    status = if ap.debtor_paid_at.present?
               "Settled"
             elsif Time.current.to_date < ap.invoice.expected_paid_at
               "Due"
             elsif Time.current.to_date >= ap.invoice.expected_paid_at &&
                   (Time.current.to_date - ap.invoice.expected_paid_at).to_i <= ap.grace_period.to_i
               "In Grace Period"
             else
               "Overdue"
             end
    the_date = ap.debtor_paid_at.present? ? ap.debtor_paid_at : ap.invoice.expected_paid_at
    [
      ap.transaction_number,
      ap.debtor.name.delete(","),
      (ap.debtor.public_entity? ? "Public" : "Private"),
      b.decorated.amount / 100.0,
      ap.format_days(ap.payment_terms_length).delete(" days"),
      ap.expected_aer,
      ip.net_return_of(a)[1..-1],
      the_date&.to_date&.strftime("%d/%m/%Y"),
      ap.auction.rating,
      status,
    ]
  end
end

# Investor report for balances
# /app/decorators/investors/calculations/balances.rb
report = []
Timecop.freeze('2017-02-01 07-01-02'.to_time) do
  i = Investor.find(570)    
  ip = Investors::InvestorPresenter.new(i)    
  report = [ip.total_balance, ip.balance, ip.deposits_minus_cash, ip.invested_balance, ip.available_balance, ip.reserved_balance]    
end    

# Run a command with a specific timeout, e.g. getting a prompt from a user within 5 seconds
Timeout.timeout(5) do
  STDIN.gets
end

# Ask user if they want to continue with the command e.g in a specific environment during a rake task
continue_phrase = "yes please"
if Rails.env.development? or Rails.env.test?
  puts "If you want continue, type '#{continue_phrase}'"
  line = STDIN.gets.chomp
  if line != continue_phrase
    puts "Message received. I don't blame you. Exiting..."
    exit 1
  end
end  

# Investor flow e.g. BG
# /app/controllers/operations/accounts_controller.rb
# http://nco-eur.lvh.me:3000/investors/498/accounts
# investor cash account
def show
  @account = the_investor.accounts.find params[:id]
  title =  view_context.link_to the_investor.name, investor_path(the_investor)
  title += " - "
  title += view_context.link_to "Accounts", investor_accounts_path(the_investor)
  title += " - "
  title += @account.category.titleize
  @page_header = PageHeaderComponent.new(view_context, title.html_safe, params)
  @component = ::Tables::GenericTableComponent.new(view_context)
  @component.headers = ["Balance", "Debit", "Credit", "Description", "Date Recorded",
                        "Transaction Number", "Public Entity", "Bid Amount", "Return",
                        "Expected Return", "Advanced At", "Debtor Paid At", "Expected Paid At",
                        "Rating"]
  balance = 0
  end_balance = @account.balance
  start_date = "14-06-2015"
  end_date = "01-01-2017"
  @component.rows = @account.accounting_entries.where("created_at::date > to_date('#{start_date}','DD-MM-YYYY') and created_at::date <  to_date('#{end_date}','DD-MM-YYYY')").order(:created_at => :asc).collect do |entry|
    is_credit = false
    if [ 'asset', 'expenses' ].include? @account.account_type
      is_credit = true if entry.amount > 0
      balance += entry.amount.abs if not is_credit
      balance -= entry.amount.abs if is_credit
    else
      is_credit = true if entry.amount > 0
      balance += entry.amount.abs if is_credit
      balance -= entry.amount.abs if not is_credit
    end

    presenter = ::Investors::InvestorPresenter.new(the_investor)
    row = []
    row.push(presenter.format_money(balance))
    credit_debit =
      if is_credit
        ["", presenter.format_money(entry.amount.abs)]
      else
        [presenter.format_money(entry.amount.abs), ""]
      end
    row.push(credit_debit)
    # row.push(entry.accounting_transaction.try(:description) || "Missing transaction")
    if entry.accounting_transaction.try(:description).present?
      desc = entry.accounting_transaction.description
      description, transaction_number =
        if desc.include?("Investor Deposit")
          ["Investor Deposit", ""]
        else
          desc.split(" - ")
        end
    else
      description = "No description"
      transaction_number = nil
    end
    row.push(description)
    row.push(entry.created_at.to_date.strftime("%d/%m/%Y"))
    if transaction_number.present? and transaction_number.include?("IG-")
      row.push(transaction_number)
      a = Auction.find_by(transaction_number: transaction_number)
      b = a.bids.find_by(investor_id: the_investor.id)
      if a.has_been_sold? and b.present?
        i = Invoice.find_by(auction_id: a.id)
        row.push(a.debtor.public_entity)
        row.push(b.amount / 100.0)
        if a.debtor_paid_at.nil?
          row.push(b.return_net / 100.0)
          row.push("")
        else
          row.push("")
          (b.total_payback - b.amount) / 100.0
        end
        row.push(a.advanced_at.to_date.strftime("%d/%m/%Y"))
        row.push(i.expected_paid_at.to_date.strftime("%d/%m/%Y"))
        row.push(a.debtor_paid_at&.to_date&.strftime("%d/%m/%Y"))
        row.push(a.rating)
      else
        row.push(["N/A (bid cancelled)", "", "", "", "", ""])
      end
    else
      row.push(["", "", "", "", "", "", ""])
    end
    row.flatten
  end
  render :template => "layouts/page"
end

# New DataSources/Profiles
# e.g. #{dev_server}/analyses/sme_risk_one_year?novicap_id=ESB1234
ds = DataSource.where(novicap_id: 'ESB1234')
ds = ds.first # there will usually be at least 2 - one manual and one from the real data source
ds.blob
ds.current_assets_by_year
ds.fetch
prof = Profile.new('ESB50632850')
prof.add(:current_assets_by_year)
prof.provide
prof.data_sources
prof.current_assets_by_year
prof.report.get(:current_assets_by_year)
# view/do an analysis. parameters in analyses/relationship.rb
# operations -> analyses
# operations -> relationships -> choose one -> view analysis
#{dev_server}/analyses/relationship?sme_novicap_id=ESA123&debtor_novicap_id=ESB456&payment_method=bank_transfer
ds = DataSource::Insightview.new(novicap_id: 'ESB1234')
ds.fetch
ds.class.supported_facts
# we've added insightview_modelo200_shared_datasource_stuff 
# because modelo200 and insightview are similar but neither is a member of the other
# using "ActiveSupport::Concern" instead of inheritance


# Given a new invoice with a new company/debtor, in risk-2, public debtor,
# we want to simulate how much of that invoice we could finance given the currently available funds of the investors
# and we want to know why
invs_bal = []; Account.where("category = 'investor_cash_account' and balance > 0").each do |a|
 invs_bal << [a.general_ledger.investor.id, a.balance/100.0]
end

tots = []
invs_bal.each do |i, bal|
  inv = Investor.find(i)
  od = inv.auctions.overdue.where(rating: "RISK-5").count
  d = inv.auctions.due.where(rating: "RISK-5").count
  ad = inv.auctions.advanced.where(rating: "RISK-5").count
  bd = inv.auctions.bidding.where(rating: "RISK-5").count
  cfd = inv.auctions.confirmed.where(rating: "RISK-5").count
  total = od + d + ad + bd + cfd
  if total > 0 and inv.strategy.grade_5 < 100
    invested = 0
   inv.auctions.overdue.where(rating: "RISK-5").each do |a|
      invested += a.bids.find_by(investor_id: i).amount
    end
   inv.auctions.due.where(rating: "RISK-5").each do |a|
      invested += a.bids.find_by(investor_id: i).amount
    end
   inv.auctions.advanced.where(rating: "RISK-5").each do |a|
      invested += a.bids.find_by(investor_id: i).amount
    end
   inv.auctions.bidding.where(rating: "RISK-5").each do |a|
      invested += a.bids.find_by(investor_id: i).amount
    end
   inv.auctions.confirmed.where(rating: "RISK-5").each do |a|
      invested += a.bids.find_by(investor_id: i).amount
    end
    if invested > (inv.strategy.grade_5  / 100.0 ) * bal
      tots << i
    end
  end
end

invs_bal.each do |i, bal|
  inv = Investor.find(i)
  od = inv.auctions.overdue.map(&:debtor).map(&:public_entity).count(true)
  d = inv.auctions.due.map(&:debtor).map(&:public_entity).count(true)
  ad = inv.auctions.advanced.map(&:debtor).map(&:public_entity).count(true)
  bd = inv.auctions.bidding.map(&:debtor).map(&:public_entity).count(true)
  cfd = inv.auctions.confirmed.map(&:debtor).map(&:public_entity).count(true)
  total = od + d + ad + bd + cfd
  if total > 0 and inv.strategy.maximum_public_administration_exposure < 100
    invested = 0
    inv.auctions.due.each do |a|
      if a.debtor.public_entity
        invested += a.bids.find_by(investor_id: i).amount
      end
    end
    inv.auctions.advanced.each do |a|
      if a.debtor.public_entity
        invested += a.bids.find_by(investor_id: i).amount
      end
    end
    inv.auctions.bidding.each do |a|
      if a.debtor.public_entity
        invested += a.bids.find_by(investor_id: i).amount
      end
    end
    inv.auctions.confirmed.each do |a|
      if a.debtor.public_entity
        invested += a.bids.find_by(investor_id: i).amount
      end
    end
    inv.auctions.overdue.each do |a|
      if a.debtor.public_entity
        invested += a.bids.find_by(investor_id: i).amount
      end
    end

    if invested > (inv.strategy.maximum_public_administration_exposure  / 100.0 ) * bal
      tots << i
    end
  end
end

strategies = []
reasons = []
invs_bal.each do |i, bal|
  next if tots.include? i
  strat = []
  i_strat = Investor.find(i).strategy
  strat << i_strat.maximum_invoice_exposure
  strat << i_strat.maximum_company_exposure
  strat << i_strat.maximum_debtor_exposure
  strat << i_strat.maximum_public_administration_exposure
  strat << i_strat.grade_2
  strategies << bal * (strat.min / 100.0)
  this_reason = [i]
  if i_strat.maximum_invoice_exposure == strat.min
    this_reason << 'invoice'
  end
  if i_strat.maximum_company_exposure == strat.min
    this_reason << 'company'
  end
  if i_strat.maximum_debtor_exposure == strat.min
    this_reason << 'debtor'
  end
  if i_strat.maximum_public_administration_exposure == strat.min
    this_reason << 'public'
  end
  if i_strat.grade_2== strat.min
    this_reason << 'risk'
  end
  reasons << this_reason
end
strategies.sum # => 60,000.00

