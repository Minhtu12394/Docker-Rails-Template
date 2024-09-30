FROM ruby:2.3.0

RUN apt-get update -qq && \
    apt-get install build-essential -y --no-install-recommends \
    vim \
    git \
    cron \
    libpq-dev \
    nodejs
RUN apt-get clean

RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY entrypoint.sh /app/scripts/

RUN chmod a+x /app/scripts/*.sh

# BUNDLE_PATH: Đường dẫn nơi các gem sẽ được cài đặt.
# BUNDLE_BIN: Đường dẫn nơi các tệp thực thi (binstubs) sẽ được lưu.
ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin

# With PATH="${BUNDLE_BIN}:${PATH}" => rake ....
# Without PATH="${BUNDLE_BIN}:${PATH}" => bundle/bin/rake
ENV PATH="${BUNDLE_BIN}:${PATH}"
COPY . /app

EXPOSE 3000
