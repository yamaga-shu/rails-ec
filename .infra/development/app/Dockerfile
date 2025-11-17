FROM ruby:3.4.7-trixie

ENV TZ UTC

WORKDIR /app

COPY ./Gemfile /app/Gemfile
COPY ./Gemfile.lock /app/Gemfile.lock

RUN bundle install
