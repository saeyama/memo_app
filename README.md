# memo_app

**概要**  
メモの登録・更新・削除が出来るシンプルなアプリです。  
ローカル環境で使用可能です。  

**作成バージョン**  
ruby：2.7.3　※2系なのでwebrickは入ってません。  
sinatra：2.1.0  
DB：未使用　※jsonファイルにてデータを管理。  

**使い方**  
`clone`もしくは`fork`でローカルに落とし、以下を実行すればWEBブラウザ上で使用可能です！  

ターミナルでフォルダのディレクトリに移動し以下を入力。
```
memo_app % bundle exec ruby app.rb
```
サーバーが立ち上がったことを確認。
```
[2021-09-30 23:07:33] INFO  WEBrick 1.6.1
[2021-09-30 23:07:33] INFO  ruby 2.7.3 (2021-04-05) [x86_64-darwin20]
== Sinatra (v2.1.0) has taken the stage on 4567 for development with backup from WEBrick
[2021-09-30 23:07:33] INFO  WEBrick::HTTPServer#start: pid=10287 port=4567
```

WEBブラウザに http://localhost:4567 を打ち込むとサイトが表示されます。  

![memo](https://user-images.githubusercontent.com/64824195/135475726-860a81a0-154a-4a65-86c9-0b25a2b1ac74.png)

メモを登録すると、`datas`フォルダに`json`ファイルが作成されます。  
メモを削除すると、`json`ファイルも削除されます。  
