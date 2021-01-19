FROM ruby:2.7

# タイムゾーンをAsia/Tokyoに
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
WORKDIR /usr/src/app
COPY . .
RUN bundle install

WORKDIR /usr/src/app/test/dummy
#RUN bin/rails assets:precompile
EXPOSE 3000
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
