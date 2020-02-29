.PHONY: server
server:
	hugo server --disableFastRender -w -D

.PHONY: build
build:
	hugo --cleanDestinationDir --enableGitInfo

.PHONY: upload
upload: build
	gsutil -m rsync -c -r -d public gs://food.hannah-and-jakob.ca/
