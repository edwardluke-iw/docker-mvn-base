.PHONY: start build push

build_all:
	make build_openjdk8
	make build_openjdk11
	make build_graaljdk11

build_openjdk8:
	docker build --file Dockerfile --target mvn-openjdk8 --tag edwardlukeiw/mvn:openjdk8 .
	docker push edwardlukeiw/mvn:openjdk8

build_openjdk11:
	docker build --file Dockerfile --target mvn-openjdk11 --tag edwardlukeiw/mvn:openjdk11 .
	docker push edwardlukeiw/mvn:openjdk11

build_graaljdk11:
	docker build --file Dockerfile --target mvn-graaljdk11 --tag edwardlukeiw/mvn:graaljdk11 .
	docker push edwardlukeiw/mvn:graaljdk11

run_openjdk8:
	docker run -it edwardlukeiw/mvn:openjdk8

run_openjdk11:
	docker run -it edwardlukeiw/mvn:openjdk11

run_graaljdk11:
	docker run -it edwardlukeiw/mvn:graaljdk11
