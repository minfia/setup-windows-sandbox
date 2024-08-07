# バージョン
[string] $vc_libs_ver = "14.00"                 # VCLibs.Desktopのバージョン
[string] $ui_xaml_base_ver = "2.8"              # Microsoft.UI.Xamlのベースバージョン
[string] $ui_xaml_ver = "${ui_xaml_base_ver}.6" # Microsoft.UI.Xamlのバージョン
[string] $winget_ver = "1.8.1791"               # wingetのバージョン
[string] $powershell_ver = "7.4.3"              # PowerShellのバージョン
[string] $win_term_ver = "1.20.11781.0"         # WindowsTerminalのバージョン

# ファイル名
[string] $vc_libs_name = "Microsoft.VCLibs.x64.${vc_libs_ver}.Desktop.appx"
[string] $ui_xaml_name = "Microsoft.UI.Xaml.${ui_xaml_ver}_x64.appx"
[string] $winget_name = "winget_v${winget_ver}.msixbundle"
[string] $powershell_name = "PowerShell_v${powershell_ver}_x64.msi"
[string] $win_term_name = "WindowsTerminal_v${win_term_ver}.msixbundle"

# ディレクトリ定義
[string] $WorkMountDir = "C:\users\WDAGUtilityAccount\Mount" # マウントディレクトリパス
[string] $PackageDirPath = "${WorkMountDir}\packages" # パッケージファイルのデフォルトパス
[string] $PackageDownloadDirPath = "C:\users\WDAGUtilityAccount\Desktop\packages" # パッケージファイルのダウンロード先のパス


<#
    .SYNOPSIS
        パッケージのプリセットアップ

    .PARAMETER Url
        ダウンロードURL
    .PARAMETER PackageFileName
        パッケージファイル名

    .OUTPUTS
        パッケージのファイルパス

    .DESCRIPTION
        パッケージが存在しない場合はダウンロードを行う
    .NOTE
        どちらも""でくくること
#>
function Set-Package([string]$Url, [string]$PackageFileName)
{
    [string] $PackageFilePath = "${PackageDirPath}\${PackageFileName}"
    if ((Test-Path "${PackageFilePath}")) {
        # ファイルあり
        return ("${PackageFilePath}")
    } else {
        # ファイルなし
        if (-not (Test-Path "${PackageDownloadDirPath}")) {
            mkdir ${PackageDownloadDirPath}
        }
        [string] $DownloadFilePath = "${PackageDownloadDirPath}\${PackageFileName}"
        curl.exe -Lo ${DownloadFilePath} ${Url}
        return ("${DownloadFilePath}")
    }
}

<#
    .SYNOPSIS
        メイン処理
#>
function Main
{
    $package_array = @()

    # 依存関係の確認
    $package_array = ${package_array} + (Set-Package "https://aka.ms/${vc_libs_name}" "${vc_libs_name}")
    $package_array = ${package_array} + (Set-Package "https://github.com/microsoft/microsoft-ui-xaml/releases/download/v${ui_xaml_ver}/Microsoft.UI.Xaml.${ui_xaml_base_ver}.x64.appx" "${ui_xaml_name}")

    # wingetの確認
    $package_array = ${package_array} + (Set-Package "https://github.com/microsoft/winget-cli/releases/download/v${winget_ver}/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" "${winget_name}")

    # PowerShellの確認
    $package_array = ${package_array} + (Set-Package "https://github.com/PowerShell/PowerShell/releases/download/v${powershell_ver}/PowerShell-${powershell_ver}-win-x64.msi" "${powershell_name}")

    # WindowsTerminalの確認
    $package_array = ${package_array} + (Set-Package "https://github.com/microsoft/terminal/releases/download/v${win_term_ver}/Microsoft.WindowsTerminal_${win_term_ver}_8wekyb3d8bbwe.msixbundle" "${win_term_name}")

    # パッケージのインストール
    foreach ($package in ${package_array}) {
        if ((Get-ChildItem ${package}).Extension -eq ".msi") {
            Start-Process msiexec -ArgumentList "/i ${package} /passive" -Wait
        } else {
            Add-AppPackage -Path ${package}
        }
    }

    # wingetパッケージのインストール
    winget import ${WorkMountDir}\scripts\winget_packages.json
}

Main
