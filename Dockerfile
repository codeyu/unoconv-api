FROM ubuntu:wily

MAINTAINER Rene Kaufmann <kaufmann.r@gmail.com>

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
ENV GO15VENDOREXPERIMENT 1

#Install unoconv
RUN \
	apt-get update && \
	DEBIAN_FRONTEND=noninteractive \
	    apt-get upgrade -y && \
		apt-get install -y \
			unoconv \
			supervisor \
			golang-go \
	&& \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD . /go/src/github.com/HeavyHorst/unoconv-api
RUN go install github.com/HeavyHorst/unoconv-api

# Expose 3000
EXPOSE 3000

# Startup
ENTRYPOINT ["/usr/bin/supervisord"]
