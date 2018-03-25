# -*- coding: utf-8 -*-
"""
Created on Tue Mar 20 19:07:49 2018

@author: jenny_000
"""

import dash
import dash_core_components as dcc
import dash_html_components as html

import pandas as pd

df = pd.read_csv(
    'https://raw.githubusercontent.com/JennierJ/CUNY_DATA_608/master/Project%204/max.csv')

def generate_table(dataframe, max_rows=1500):
    return html.Table(
        # Header
        [html.Tr([html.Th(col) for col in dataframe.columns])] +

        # Body
        [html.Tr([
            html.Td(dataframe.iloc[i][col]) for col in dataframe.columns
        ]) for i in range(min(len(dataframe), max_rows))]
    )

app = dash.Dash()

app.layout = html.Div(children=[
    html.H4(children='Water Quality for Safe Swimming'),
    dcc.Dropdown(id='dropdown', options=[
        {'label': i, 'value': i} for i in df.Date.unique()
    ], multi=True, placeholder='Pick a date...'),
    html.Div(id='table-container')
])

@app.callback(
    dash.dependencies.Output('table-container', 'children'),
    [dash.dependencies.Input('dropdown', 'value')])
def display_table(dropdown_value):
    if dropdown_value is None:
        return generate_table(df)

    data = df['dropdown_value']
    return generate_table(data)


if __name__ == '__main__':
    app.run_server(debug=True)
