<#
    .SYNOPSIS
        ���W�X�g���̒ǉ�

    .PARAMETER RegPath
        ���W�X�g���̃p�X
    .PARAMETER RegKey
        �ǉ�����L�[
    .PARAMETER RegValueType
        �ǉ�����l�̎��
    .PARAMETER RegValue
        �ǉ�����l

    .NOTE
        ���ׂ�""�ł����邱��

#>
function New-Registory([string]$RegPath, [string]$RegKey, [string]$RegValueType, [string]$RegValue)
{
    New-ItemProperty -Force -LiteralPath ${RegPath} -Name ${RegKey} -PropertyType ${RegValueType} -Value ${RegValue}
}

<#
    .SYNOPSIS
        �L�[�{�[�h�ݒ菈��
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
        �n��̐ݒ菈��
#>
function Set-Location
{
    Set-WinUserLanguageList -Force ja-JP
    Set-WinHomeLocation -GeoID 122
    Set-Culture -CultureInfo ja-JP
}

<#
    .SYNOPSIS
        �V�X�e���ݒ胁�C������
#>
function SysConfigMain
{
    Set-Keyboard
    Set-Location
}

SysConfigMain
