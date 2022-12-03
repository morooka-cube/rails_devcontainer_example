FROM node:14.21.1-slim AS node
FROM ruby:2.7.7

COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/include/node /usr/local/include/node
COPY --from=node /usr/local/bin/yarn /usr/local/bin/yarn
COPY --from=node /usr/local/bin/yarnpkg /usr/local/bin/yarnpkg
COPY --from=node /opt/yarn-v1.22.19 /opt/yarn-v1.22.19
RUN ln -s /usr/local/bin/node /usr/local/bin/nodejs && \
  ln -s /opt/yarn-v1.22.19/bin/yarn.js /usr/local/bin/yarn.js
WORKDIR /app

EXPOSE 3000
CMD bash
