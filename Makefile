.PHONY: clean build test push_to_repo shell
.DEFAULT_GOAL := test

REPOSITORY="localhost:5000"
CONTAINERNAME="aylien/techtest-py"
VERSION=latest

clean:
	for i in $(shell docker images | grep $(CONTAINERNAME) | awk '{print $$3}' | sort -u); do docker rmi -f $$i; done; \
	find . \( -name "*.pyc" -o -name "__pycache__" \) -delete

build:
	docker build -t $(CONTAINERNAME):$(VERSION) -f Dockerfile-py .

test:
	docker run --rm -it $(CONTAINERNAME):$(VERSION) sh -c "pip install flake8 && clear && /usr/local/bin/flake8 /app/ || true"

push_to_repo: build
	# docker login -u {username or accesstoken} --password-stdin https://eu.gcr.io
	docker tag $(CONTAINERNAME):$(VERSION) $(REPOSITORY)/$(CONTAINERNAME):$(VERSION)
	docker push $(REPOSITORY)/$(CONTAINERNAME):$(VERSION)

shell: build
	docker run --rm -it $(CONTAINERNAME):$(VERSION) sh

