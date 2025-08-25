# OSS-Fuzz Dockerfile for libfuzzer-playground
FROM gcr.io/oss-fuzz-base/base-builder

# (Optional) extra build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    make cmake zip \
 && rm -rf /var/lib/apt/lists/*

# Copy project sources into $SRC/libfuzzer-playground
COPY . $SRC/libfuzzer-playground
WORKDIR $SRC/libfuzzer-playground

# The base-builder will automatically run /src/$PROJECT/build.sh
# during 'helper.py build_fuzzers'.

