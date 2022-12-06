# --- node.jsとyarnの実行ファイルが入ったイメージ ---
FROM node:14.21.1-slim AS node


# --- yarn installを行うビルドステージ ここから
FROM node AS yarn
# ワーキングディレクトリを設定
WORKDIR /app

# ビルドコンテキストからyarn installに必要なファイルをコピー
COPY package.json yarn.lock /app/

# yarn installを実行
RUN yarn install
# --- yarn installを行うビルドステージ ここまで


# --- 最終的なビルド結果となるステージ ここから
FROM ruby:2.7.7

# nodeからnode.jsとyarnの実行ファイルをコピー
COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/include/node /usr/local/include/node
COPY --from=node /usr/local/bin/yarn /usr/local/bin/yarn
COPY --from=node /usr/local/bin/yarnpkg /usr/local/bin/yarnpkg
COPY --from=node /opt/yarn-v1.22.19 /opt/yarn-v1.22.19

RUN \
# nodeとyarnが実行できるようシンボリックリンクを設定
  ln -s /usr/local/bin/node /usr/local/bin/nodejs && \
  ln -s /opt/yarn-v1.22.19/bin/yarn.js /usr/local/bin/yarn.js && \
  # デバッグ用のGemをインストール
  gem install solargraph ruby-debug-ide debase

# ワーキングディレクトリを設定
WORKDIR /app 

# ビルドコンテキストからbundle installに必要なファイルをコピー
COPY Gemfile Gemfile.lock /app/

# bundle installを実行
RUN bundle install

# yarn install結果をコピー
COPY --from=yarn /app/package.json /app/yarn.lock /app/node_modules /app/

# ポート3000番に穴を開ける
EXPOSE 3000
# --- 最終的なビルド結果となるステージ ここまで
