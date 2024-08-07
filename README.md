# Windows Sandbox環境構築
素のWindows Sandboxでは[winget](https://github.com/microsoft/winget-cli)や[WindowsTerminal](https://github.com/microsoft/terminal)などのツールが無いため起動時にその環境を構築する。
"launch_sandbox.wsb"を実行することで環境構築が可能となる。


## 個人ごとに変更が必要な箇所
以下の箇所に、Sandboxに共有するディレクトリパスを指定する。\
絶対パスで指定することに注意。
```
<HostFolder></HostFolder>
```

