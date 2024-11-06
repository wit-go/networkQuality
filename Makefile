PKG          := github.com/network-quality/goresponsiveness
GIT_VERSION  := $(shell git describe --always --long)
LDFLAGS      := -ldflags "-X $(PKG)/utilities.GitVersion=$(GIT_VERSION)"

all: build test
build:
	go build $(LDFLAGS) networkQuality.go
test:
	go test ./timeoutat/ ./traceable/ ./utilities/ ./lgc ./qualityattenuation ./rpm ./series
golines:
	find . -name '*.go' -exec ~/go/bin/golines -w {} \;
clean:
	go clean -testcache
	rm -f *.o core

apple:
	./networkQuality --config mensura.cdn-apple.com --port 443 --path /api/v1/gm/config

# makes a .deb package
debian:
	# you have to symlink this if you are building it from somewhere else
	# ln -s ~/go/src/github.com/network-quality/goresponsiveness -> ../../go.wit.com/apps/networkQuality
	~/go/bin/go-deb --ldflags "$(PKG)/utilities.GitVersion=$(GIT_VERSION)" --no-gui --repo go.wit.com/apps/networkQuality
