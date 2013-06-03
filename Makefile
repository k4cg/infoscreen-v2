help:
	@echo "make install - install python environment into .env"
	@echo "make update  - update local content"
	@echo "make clean   - cleanup"

install: 
	virtualenv .env
	.env/bin/easy_install oauth2
	.env/bin/easy_install python-twitter

update:
	cd twitter && ../.env/bin/python update-tweets.py
	cd tumblr && ../.env/bin/python update-tumblr.py
	cd fahrplan && ../.env/bin/python update-fahrplan.py
	cd stats && ./update-stats.sh

clean:
	rm -rf .env
	rm -f twitter/profile-image*
	rm -f twitter/tweets.json
	rm -f stats/stats.json
	rm -f tumblr/tumblr-image*
	rm -f stats/power.png
