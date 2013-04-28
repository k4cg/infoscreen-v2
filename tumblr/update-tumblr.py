#!/usr/bin/python
import sys
import json
import urllib
import datetime
import pprint

# we don't want to register for an api key
tumblr = json.loads(urllib.urlopen("http://log.raumzeitlabor.de/api/read/json?type=photo").read().replace("var tumblr_api_read = ", "")[:-2])

# don't load all images to avoid getting blacklisted by kernel
# in case a post has multiple photos, we only get the first
images = [dict(
    image = img["photo-url-500"],
    time = datetime.datetime.fromtimestamp(img["unix-timestamp"]).strftime("%D %H:%M"),
) for img in tumblr["posts"][:10]]

for n, img in enumerate(images):
    imgname = "tumblr-image%02d" % (n+1)
    out = file(imgname, "wb")
    out.write(urllib.urlopen(img['image']).read())
    out.close()
    img['image'] = imgname
    pprint.pprint(img)

file("tumblr.json", "wb").write(json.dumps(images, ensure_ascii=False).encode("utf8"))
