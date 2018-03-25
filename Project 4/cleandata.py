# -*- coding: utf-8 -*-
"""
Created on Wed Mar 21 15:10:05 2018

@author: jenny_000
"""

import pandas as pd
import numpy as np
import io
import requests

url = "https://raw.githubusercontent.com/charleyferrari/CUNY_DATA_608/master/module4/Data/riverkeeper_data_2013.csv"
s=requests.get(url).content
df=pd.read_csv(io.StringIO(s.decode('utf-8')))

df1 = df[['Date', 'EnteroCount']]


#df['Date'] = pd.Series([pd.to_datetime(d) for d in df['Date']])
df1['EnteroCount'] = df1['EnteroCount'].convert_objects(convert_numeric=True)

df_mean = df1.groupby('Date', as_index=False).mean()
df_mean.to_csv("mean.csv")

df_max = df.groupby('Date', as_index=False)['EnteroCount'].max()
df_max.to_csv("max.csv")




