# write or append dataframe to csv file
# adapted from here http://stackoverflow.com/questions/30991541/pandas-write-csv-append-vs-write

import os
if not os.path.isfile('filename.csv'):
        df.to_csv('filename.csv', header=True, encoding='utf-8')
    else:  
        # else the file exists so ignore the header
        df.to_csv('filename.csv', mode='a', header=False, encoding='utf-8')

# save dataframe in a pickle that's compatible with python 2
pickle.dump(df , open( "dataframe_pickle.p", "wb" ) , protocol = 2)
df = pickle.load( open( "dataframe_pickle.p", "rb" ))

# make a deep copy
import copy
new_var = copy.deepcopy(old_var)
# OR
new_var = old_var.copy(deep=True)

# strip column headings before punctuation (this method will only strip first instance)
# from table_name.column_name -> column_name
# use [0] to select first part, and [1] for the '.', not that you would ever want that..
df.columns = [i.rpartition('.')[2] for i in df.columns.values]

# prepend to column headers
df.columns = ['df.{0}'.format(i) for i in df.columns.values]
# from column_name -> df.column_name

# replace value in dataframe
df.replace(to_replace='old value', value='New value', inplace=True)

# strip string from right (end) of string. can replace r with l for replacing at the start
df['Name'] = df['Name'].map(lambda x: x.rstrip(' - '))
# e.g. "Anna - " -> "Anna"

# check if value is a particular type (in this case a float). Note: np.nan or "NaN" is a float
isinstance(value_to_check, float) == True

# drop a column by name
df = df.drop(['Column Name to Drop'], axis=1)

# drop nulls from a specific column
df.dropna(subset = ['Column name'], inplace=True)

# inner join dataframes (can be used with other joins too e.g. left, outer)
pd.merge(df1, df2, on = 'Common column name', how='inner')

# drop duplicates on a column
df = df.drop_duplicates('Column to keep unique')

# read a csv (useful codings include latin-1, mac-roman, utf-8)
pd.read_csv('my_filename.csv', sep=',', encoding='utf-8')

# read an excel 
pd.read_excel('my_filename.xlsx', sheetname=5, header=2)

# rename columns
df = df.rename(columns = {'Old column name':'New column name', 
                          'second_old_column':'shiny new column'})

# fill nulls of one column with another column
df['Column with nulls'].fillna(df['Similar column'], inplace=True)

# grabbing a particular value in a dataframe e.g. row 10, column "Column name"
df.ix[10,'Column name']

# find and replace by looping
for i, row in df.iterrows():
    if isinstance(df['String of currency'][i],float) == False:
        df['String of currency'][i] = float(df['String of currency'][i].replace('.','').replace(',','.'))

# replace words using an array of words to replace and an array of words to replace them with
# to expand the example, let's say we might have random upper/lower case letters and ultimately want Title Case
df['Name'] = df['Name'].str.lower()

to_replace = ["my old value", "my wrong name"]
to_replace_with = ["my new value", "my right name"]

import re
for i in range(len(to_replace)):
    df['Name'] = df['Name'].apply(lambda x: re.sub(to_replace[i], to_replace_with[i], x))

# if there are null values
for i, row in df.iterrows():
    if isinstance(df['Name'][i], float) == False:
        for k in range(len(to_replace)):
            df['Name'][i] = re.sub(to_replace[k], to_replace_with[k], df['Name'][i])
        
df['Name'] = df['Name'].str.title()

# Debugging with tracer
from IPython.core.debugger import Tracer
Tracer()()
# key words are the same as normal debuggers: continue, next, step, exit
