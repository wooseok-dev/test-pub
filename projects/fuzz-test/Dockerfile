FROM gcr.io/oss-fuzz-base/base-builder
RUN apt-get update && apt-get install -y build-essential

WORKDIR $SRC
COPY pkgs/integration-test.tar.gz $SRC/

RUN tar -xzf $SRC/integration-test.tar.gz && rm $SRC/integration-test.tar.gz

COPY build.sh $SRC/
COPY fuzz_* *.options $SRC/
WORKDIR $SRC/integration-test



FROM ghcr.io/aixcc-finals/base-builder:v1.2.1
RUN apt-get update && apt-get install -y build-essential

WORKDIR $SRC
COPY pkgs/test-pub.tar.gz $SRC/
RUN tar -xzf $SRC/test-pub.tar.gz && rm $SRC/test-pub.tar.gz

COPY build.sh $SRC/
COPY fuzz_* $SRC/
WORKDIR $SRC/test-pub
