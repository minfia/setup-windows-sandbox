<#
    .SYNOPSIS
        レジストリの追加

    .PARAMETER RegPath
        レジストリのパス
    .PARAMETER RegKey
        追加するキー
    .PARAMETER RegValueType
        追加する値の種類
    .PARAMETER RegValue
        追加する値

    .NOTE
        すべて""でくくること

#>
function New-Registory([string]$RegPath, [string]$RegKey, [string]$RegValueType, [string]$RegValue)
{
    New-ItemProperty -Force -LiteralPath ${RegPath} -Name ${RegKey} -PropertyType ${RegValueType} -Value ${RegValue}
}

<#
    .SYNOPSIS
        キーボード設定処理
#>
function Set-Keyboard
{
    (New-Registory "HKCU:Software\Microsoft\IME\15.0\IMEJP\MSIME" "IsKeyAssignmentEnabled" "DWord" "1")
    (New-Registory "HKCU:Software\Microsoft\IME\15.0\IMEJP\MSIME" "KeyAssignmentHenkan" "DWord" "0")
    (New-Registory "HKCU:Software\Microsoft\IME\15.0\IMEJP\MSIME" "KeyAssignmentMuhenkan" "DWord" "1")
    (New-Registory "HKLM:SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" "LayerDriver JPN" "String" "kbd106.dll")
    (New-Registory "HKLM:SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" "OverrideKeyboardIdentifier" "String" "PCAT_106KEY")
}

<#
    .SYNOPSIS
        地域の設定処理
#>
function Set-Location
{
    Set-WinUserLanguageList -Force ja-JP
    Set-WinHomeLocation -GeoID 122
    Set-Culture -CultureInfo ja-JP
}

<#
    .SYNOPSIS
        システム設定メイン処理
#>
function SysConfigMain
{
    Set-Keyboard
    Set-Location
}

SysConfigMain
