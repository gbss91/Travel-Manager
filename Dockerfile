# syntax=docker/dockerfile:1

# Use the official Ruby image 
FROM ruby:3.1.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  postgresql-client \
  libssl-dev \
  libreadline-dev \
  zlib1g-dev \
  build-essential \
  curl

# Set the working directory
WORKDIR /Travel-Manager

# Copy the Gemfile and Gemfile.lock
COPY Gemfile /Travel-Manager/Gemfile
COPY Gemfile.lock /Travel-Manager/Gemfile.lock

# Install Gems dependencies
RUN gem install bundler && bundle install

# Copy the application code
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Command to run the server
CMD ["rails", "server", "-b", "0.0.0.0"]