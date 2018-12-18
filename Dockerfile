FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /brezan
WORKDIR /brezan
COPY Gemfile /brezan/Gemfile
COPY Gemfile.lock /brezan/Gemfile.lock
RUN bundle install
COPY . /brezan
