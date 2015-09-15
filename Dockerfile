FROM ruby:2.0.0-p647-onbuild

RUN apt-get update -y && apt-get install --no-install-recommends -y -q curl python build-essential git ca-certificates && \
    apt-get clean && rm /var/lib/apt/lists/*_*
RUN mkdir /nodejs && curl https://nodejs.org/dist/v0.12.7/node-v0.12.7-linux-x64.tar.gz | tar xvzf - -C /nodejs --strip-components=1

ENV PATH $PATH:/nodejs/bin

CMD ["bundle exec jekyll serve"]
