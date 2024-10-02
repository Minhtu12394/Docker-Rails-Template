FROM ruby:3.1

# Cài đặt Node.js và Yarn (yêu cầu cho Rails 6+ để sử dụng Webpacker)
RUN apt-get update -qq && \
    apt-get install build-essential -y --no-install-recommends \
    vim \
    git \
    cron \
    libpq-dev \
    nodejs \
    yarn

RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# BUNDLE_PATH: Đường dẫn nơi các gem sẽ được cài đặt.
# BUNDLE_BIN: Đường dẫn nơi các tệp thực thi (binstubs) sẽ được lưu.
ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle

# With PATH="${BUNDLE_BIN}:${PATH}" => rake ....
# Without PATH="${BUNDLE_BIN}:${PATH}" => bundle/bin/rake
ENV PATH="${BUNDLE_BIN}:${PATH}"

ARG BUNDLER_VERSION=2.3.27

RUN gem install bundler:${BUNDLER_VERSION}
RUN bundle install --path=${BUNDLER_PATH}

# Sao chép toàn bộ code của ứng dụng vào container
COPY . /app

COPY entrypoint.sh /scripts/
RUN chmod a+x /scripts/*.sh

EXPOSE 3000

# Thiết lập entrypoint
# ENTRYPOINT ["/scripts/entrypoint.sh"]

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
