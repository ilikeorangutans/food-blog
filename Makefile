today := $(shell date +%Y-%m-%d)
title ?= "New Blog Post"
safe_title := $(shell echo $(title) | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g' | sed -E 's/^-+|-+$$//g' )


.PHONY: server
server:
	hugo server --disableFastRender -w -D

.PHONY: post
post:
	hugo new "posts/$(today)-$(safe_title)/index.md"

.PHONY: build
build:
	hugo --gc --cleanDestinationDir --minify
	find public -name '*.jpg' | grep -v 'lanczos' | xargs rm

.PHONY: upload
upload: build
	gsutil -m rsync -c -r -x '.DS_Store' -d public gs://food.hannah-and-jakob.ca/
