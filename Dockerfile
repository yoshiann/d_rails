FROM ruby:2.7.4
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq \
    && apt-get install -y nodejs yarn \
    && mkdir /d_rails
WORKDIR /d_rails
COPY Gemfile /d_rails/Gemfile
COPY Gemfile.lock /d_rails/Gemfile.lock
RUN bundle install
COPY . /d_rails

#RUN RAILS_ENV=${RAILS_ENV} bundle exec rails assets:precompile

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]