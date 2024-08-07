GOLANGCI_LINT_VER := v1.59.1
GO_LICENSES_VER := v1.6.0

test:
	go test -v ./... -race -failfast
.PHONY: test

cover:
	go test -failfast -coverprofile=/tmp/cover.out ./...
	go tool cover -func /tmp/cover.out
.PHONY: cover

lint:
	go install -v github.com/golangci/golangci-lint/cmd/golangci-lint@$(GOLANGCI_LINT_VER) || true
	golangci-lint run
.PHONY: lint

licenses:
	go install -v github.com/google/go-licenses@$(GO_LICENSES_VER) || true
	go-licenses check .
.PHONY: licenses

checks: test lint licenses
.PHONY: checks
