FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /brezzan
WORKDIR /brezzan
COPY Gemfile /brezzan/Gemfile
COPY Gemfile.lock /brezzan/Gemfile.lock
RUN bundle install
COPY . /brezzan
