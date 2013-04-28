#!/usr/bin/python
import sys
import json
import urllib
import time
import pprint

datestr = time.strftime("%Y-%m-%d+%H:%M")
vrn = json.loads(urllib.urlopen("http://rnv.the-agent-factory.de:8080/easygo2/rest/regions/rnv/modules/stationmonitor/element?hafasID=2359&transportFilter=alle&time=" + datestr).read())

abfahrten = [dict(
    uhrzeit = f["time"].partition("+")[0],
    linie = f["lineLabel"],
    ziel = f["direction"],
    verspaetung = f["time"].partition("+")[2] or "0",
) for f in vrn["listOfDepartures"]] # 4 tds pro tr

file("fahrplan.json", "wb").write(json.dumps(abfahrten, ensure_ascii=False).encode("utf8"))
