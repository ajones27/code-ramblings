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
# e.g. "Anna - " -> "Anna"
df['Name'] = df['Name'].map(lambda x: x.rstrip(' - '))

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
# key words are the same as normal debuggers: continue, next, step, exit
from IPython.core.debugger import Tracer
Tracer()()

# Rolling window, in this case used to calculate the mean of a rolling window of another column in a dataframe
# mean() can be substituted for other functions e.g. std(), window sets the maximum size, 
# additionally min_periods can be set to something smaller than the window size otherwise it gives NaN
df['Ave of value'] = df['Value'].rolling(window=100, min_periods=1).mean()

# turn index into column e.g. if date is the index and you want a date column and a numerical index instead
df.reset_index(level=0, inplace=True)

# fuzzy matching using difflib.get_close_matches(word, possibilities[, n][, cutoff])
# Return a list of the best “good enough” matches. 
# word is a sequence for which close matches are desired (typically a string)
# possibilities is a list of sequences against which to match word (typically a list of strings).
# n (default 3; > 0) is the maximum number of close matches to return
# cutoff (default 0.6) is a float in the range [0, 1]. Possibilities that don’t score at least that similar to word are ignored.
# The best matches among possibilities are returned in a list, sorted by similarity score, most similar first.
import difflib
new_appel_value = difflib.get_close_matches('appel', ['ape', 'apple', 'peach', 'puppy'])
# => ['apple', 'ape']

# if you have repeated names in a dataframe, but different numerical values, and want to take the sum/mean etc per name
df = df.groupby(df['Name']).mean().reset_index()
