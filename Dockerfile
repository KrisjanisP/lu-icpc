# --- Build Stage ---
FROM ruby:latest as builder
ENV LANG C.UTF-8
WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler jekyll && bundle install
COPY . .
RUN bundle exec jekyll build

# --- Serve Stage ---
FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /usr/src/app/_site /usr/share/nginx/html
EXPOSE 80
