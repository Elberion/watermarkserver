OK_COLOR=\033[32;01m
NO_COLOR=\033[0m

build:
	@echo "$(OK_COLOR)==> Compiling binary$(NO_COLOR)"
	go test && go build -o bin/imaginary

test:
	go test

install:
	go get -u .

benchmark: build
	bash benchmark.sh

docker-build:
	@echo "$(OK_COLOR)==> Building Docker image$(NO_COLOR)"
	docker build --no-cache=true --build-arg IMAGINARY_VERSION=$(VERSION) -t watermarkserver .

docker-run:
	@echo "$(OK_COLOR)==> Starting Docker image$(NO_COLOR)"
	docker run --net="host" -dp 9000:9000  watermarkserver

docker: docker-build docker-run

.PHONY: test benchmark docker-build docker-push docker
