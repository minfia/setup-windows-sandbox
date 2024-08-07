# Windows Sandbox環境構築
素のWindows Sandboxでは[winget](https://github.com/microsoft/winget-cli)や[WindowsTerminal](https://github.com/microsoft/terminal)などのツールが無いため起動時にその環境を構築する。\
"launch_sandbox.wsb"を実行することで環境構築が可能となる。

## 使い方
1. [個人ごとに変更が必要な箇所](# 個人ごとに変更が必要な箇所)にある変更をする
1. launch_sandbox.wsbを実行
1. Sandboxが起動し自動で各アプリケーションをダウンロード、インストールする

以下の手順で2回目以降の起動時にファイルのダウンロードを省略することが可能。
1. 各アプリケーションのインストールを完了させる
1. Sandbox側のデスクトップの"projects"ディレクトリをコピー
1. "launch_sandbox.wsb"と同じ場所にペースト
これで2回目以降は、ダウンロードをせずに"projects"ディレクトリにあるファイルをインストールする。

### 個人ごとに変更が必要な箇所
以下の箇所に、Sandboxに共有するディレクトリパスを指定する。\
絶対パスで指定することに注意。
```
<HostFolder></HostFolder>
```
