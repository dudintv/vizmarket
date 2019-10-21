FROM ruby:2.6.5

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && echo 'deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main' 11 > /etc/apt/sources.list.d/pgdg.list

RUN apt-get update -qq && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    postgresql-client-11 \
    nodejs \
    yarn=1.17.3-1

RUN mkdir /app
WORKDIR /app

ENV GEM_HOME=/bundle
ENV BUNDLE_PATH $GEM_HOME
RUN gem install bundler --version=2.0.2

COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY package.json yarn.lock /app/
RUN yarn install

COPY . /app/

EXPOSE 5000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0", "-p", "5000"]
