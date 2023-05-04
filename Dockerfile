FROM ruby:3.2.2-bullseye

RUN mkdir /app
WORKDIR /app

COPY ./ ./

RUN gem install bundler
RUN bundle install

RUN cd / && rm -rf /app
