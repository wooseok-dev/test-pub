FROM gcr.io/oss-fuzz-base/base-builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    make cmake zip \
 && rm -rf /var/lib/apt/lists/*

# 이 폴더(= 프로젝트 디렉토리)를 /src로 복사 → /src/toy-ini/... 구조가 됨
COPY . /src/

# helper.py가 /src/build.sh를 실행하므로 권한만 부여
RUN chmod +x /src/build.sh

WORKDIR /src
# CMD 없음: infra/helper.py가 /src/build.sh를 실행합니다.

