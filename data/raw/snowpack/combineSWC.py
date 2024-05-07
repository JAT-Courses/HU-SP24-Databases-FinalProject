import shutil

with open('combinedSWC.csv','wb') as wfd:
    for f in ['BISHOP PASS-SWC-Daily.csv', 'CEDAR PASS-SWC-Daily.csv', 'Dana Meadows-SWC-Daily.csv', 'DEADMAN CREEK-SWC-Daily.csv', 'FAREWELL GAP-SWC-Daily.csv', 'LOWER LASSEN PEAK-SWC-Daily.csv', 'NOEL SPRING-SWC-Daily.csv', 'Peterson Flat-SWC-Daily.csv', 'SCHNEIDERS-SWC-Daily.csv', 'UPPER TYNDALL CREEK-SWC-Daily.csv', 'VOLCANIC KNOB-SWC-Daily.csv']:
        with open(f,'rb') as fd:
            shutil.copyfileobj(fd, wfd)
