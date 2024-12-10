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

## インストールアプリ
以下にインストールするアプリ一覧を示す。\
ただし、インストールに必要な前提アプリは除く。\
インストールをしたくない場合は"設定箇所"のファイルから削除すること。

| No. | アプリ名           | バージョン   | 設定箇所             | WinGet使用 |
| :-: | :----------------- | :----------- | :------------------- | :--------: |
|  1  | WinGet             | 1.8.1791     | install.ps1          |     No     |
|  2  | PowerShell         | 7.4.3        | install.ps1          |     No     |
|  3  | WindowsTerminal    | 1.20.11781.0 | install.ps1          |     No     |
|  4  | Visual Studio Code | latest       | winget_packages.json |     Yes    |
|  5  | Firefox            | latest       | winget_packages.json |     Yes    |
|  6  | Google Chrome      | latest       | winget_packages.json |     Yes    |

## 設定項目
以下はSandBox起動時に設定されるものである。
- Locale
  - 国と地域を日本に変更
  - 言語を日本語に変更
- キーボード
  - 変換/無変換をIMEのオン/オフに割当
  - キーボードレイアウトを日本語106キーボードに変更

### 参考
- [Windows サンドボックス構成](https://learn.microsoft.com/ja-jp/windows/security/application-security/application-isolation/windows-sandbox/windows-sandbox-configure-using-wsb-file)
- [Windowsサンドボックスの環境セットアップ](https://zenn.dev/mebiusbox/articles/a27432ce984382)
- [Windows Sandbox 起動時に IMEのキー配置を設定する](https://qiita.com/shigeokamoto/items/d822f04acf4fe16c94e2)
- [「使い捨て」ではないWindowsサンドボックスの活用方法](https://zenn.dev/gomita/articles/fb37e86afcc84d)
- [Windowsサンドボックスの日本語化バッチを作成してみた](https://www.osadasoft.com/windows%E3%82%B5%E3%83%B3%E3%83%89%E3%83%9C%E3%83%83%E3%82%AF%E3%82%B9%E3%81%AE%E6%97%A5%E6%9C%AC%E8%AA%9E%E5%8C%96%E3%83%90%E3%83%83%E3%83%81/)
