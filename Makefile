
REPO ?= akabos/debian-systemd

all:
	docker build -t $(REPO) .

rebuild:
	docker pull debian:jessie
	docker build --no-cache=true -t $(REPO) .

push: BUILD=$(shell date +%Y%m%d)
push:
	docker tag $(REPO) $(REPO):$(BUILD)
	docker push $(REPO):$(BUILD)
	docker push $(REPO)

run:
	docker run -d -i -t -v /sys/fs/cgroup:/sys/fs/cgroup:ro $(REPO)
