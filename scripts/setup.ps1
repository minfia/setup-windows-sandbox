<#
    .SYNOPSIS
        メイン処理
#>
function Main
{
    # Windowsの設定処理
    . .\sys_config.ps1

    # インストール処理
    . .\install.ps1

    Restart-Computer
}

Main
