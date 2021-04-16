import csv
import json

def make_json(filename):
    data = {}
    with open(f'{filename}.csv', encoding='utf-8-sig') as csvf:
        data = {int(rows['c']): rows for rows in csv.DictReader(csvf)}
        for value in data.values():
            del value['c']

    with open(f'SpeedBlackjack/BasicStrategy/{filename}.json', 'w', encoding='utf-8-sig') as jsonf:
        jsonf.write(json.dumps(data, indent=4))

bs_h = 'BasicStrategy_Hard'
bs_s = 'BasicStrategy_Soft'
bs_p = 'BasicStrategy_Split'

make_json(bs_h)
make_json(bs_s)
make_json(bs_p)
