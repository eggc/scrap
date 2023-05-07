FROM ruby:3.2.2-bullseye

RUN mkdir /app
WORKDIR /app

COPY ./ ./

# Install imagemagick to use rmagick
RUN apt-get update && \
    apt-get install -y libmagickwand-dev

RUN gem install bundler
RUN bundle install

# Remove application code because it can be fetched from git
RUN cd / && rm -rf /app
