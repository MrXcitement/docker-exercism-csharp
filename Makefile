username ?= mrbarker
imagename ?= exercism-csharp
tag ?= 0.1.1

.PHONY: clean docker-login docker-run
all: docker-build

docker-build: Dockerfile
	docker build -t $(username)/$(imagename):$(tag) .	
	touch $@

docker-push: docker-build
	docker push $(username)/$(imagename):$(tag)
	touch $@

docker-login:
	DOCKER_ID_USER="$(username)" docker login

docker-run: docker-build
	docker run --rm -it -v $(CURDIR):/root/exercism $(username)/$(imagename):$(tag)

clean:
	rm -f docker-build docker-push
