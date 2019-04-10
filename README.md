# 概要

ライブやコンサートのセットリストを共有するWebアプリケーションです。

# 機能一覧

* ログイン機能

* Oauth認証（Twitter）

* 画像登録も含めたミュージシャン登録機能

* ミュージシャン検索機能

* セットリスト投稿機能

* ライブに関するツイートの表示機能

* お気に入りのミュージシャンと参加したライブの登録機能

* お気に入りのミュージシャンのセットリストが追加された際のメール送信機能 

# 使用している技術一覧

* Ruby 2.4.1

* Ruby on Rails 5.0.7

* PostgreSQL

* Heroku

* deviseを使わずにログイン機能を実装し、TwitterのOauth認証にも対応

* 検索にはRansackを使用

* 画像の整形にはCarrierWaveを使用し、Cloudnary上にアップロード

* セットリストの編集にはaccepts_nested_attributes_for、field_forを使用

* メール送信機能にはActionMailerを使用し、ローカル環境ではletter_opener_webで動作確認
