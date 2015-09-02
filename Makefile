.PHONY: build
build: 
	go build ./...

.PHONY: deps
deps:
	go get -t ./...
	# goautotest is used from the Makefile to run tests in a loop
	go get github.com/tsg/goautotest
	# cover
	go get golang.org/x/tools/cmd/cover

.PHONY: gofmt
gofmt:
	go fmt ./...

.PHONY: test
test:
	go test -short ./...

.PHONY: autotest
autotest:
	goautotest -short ./...

.PHONY: testlong
testlong:
	go vet ./...
	make cover

.PHONY: benchmark
benchmark:
	go test -short -bench=. ./...

.PHONY: cover
cover:
	# gotestcover is needed to fetch coverage for multiple packages
	go get github.com/pierrre/gotestcover
	$(GOPATH)/bin/gotestcover -coverprofile=profile.cov -covermode=count github.com/elastic/libbeat/...
	mkdir -p cover
	go tool cover -html=profile.cov -o cover/coverage.html

.PHONY: clean
clean:
	gofmt -w .
	-rm profile.cov
	-rm -r cover
