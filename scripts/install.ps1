# �o�[�W����
[string] $vc_libs_ver = "14.00"                 # VCLibs.Desktop�̃o�[�W����
[string] $ui_xaml_base_ver = "2.8"              # Microsoft.UI.Xaml�̃x�[�X�o�[�W����
[string] $ui_xaml_ver = "${ui_xaml_base_ver}.6" # Microsoft.UI.Xaml�̃o�[�W����
[string] $winget_ver = "1.8.1791"               # winget�̃o�[�W����
[string] $powershell_ver = "7.4.3"              # PowerShell�̃o�[�W����
[string] $win_term_ver = "1.20.11781.0"         # WindowsTerminal�̃o�[�W����

# �t�@�C����
[string] $vc_libs_name = "Microsoft.VCLibs.x64.${vc_libs_ver}.Desktop.appx"
[string] $ui_xaml_name = "Microsoft.UI.Xaml.${ui_xaml_ver}_x64.appx"
[string] $winget_name = "winget_v${winget_ver}.msixbundle"
[string] $powershell_name = "PowerShell_v${powershell_ver}_x64.msi"
[string] $win_term_name = "WindowsTerminal_v${win_term_ver}.msixbundle"

# �f�B���N�g����`
[string] $WorkMountDir = "C:\users\WDAGUtilityAccount\Mount" # �}�E���g�f�B���N�g���p�X
[string] $PackageDirPath = "${WorkMountDir}\packages" # �p�b�P�[�W�t�@�C���̃f�t�H���g�p�X
[string] $PackageDownloadDirPath = "C:\users\WDAGUtilityAccount\Desktop\packages" # �p�b�P�[�W�t�@�C���̃_�E�����[�h��̃p�X


<#
    .SYNOPSIS
        �p�b�P�[�W�̃v���Z�b�g�A�b�v

    .PARAMETER Url
        �_�E�����[�hURL
    .PARAMETER PackageFileName
        �p�b�P�[�W�t�@�C����

    .OUTPUTS
        �p�b�P�[�W�̃t�@�C���p�X

    .DESCRIPTION
        �p�b�P�[�W�����݂��Ȃ��ꍇ�̓_�E�����[�h���s��
    .NOTE
        �ǂ����""�ł����邱��
#>
function Set-Package([string]$Url, [string]$PackageFileName)
{
    [string] $PackageFilePath = "${PackageDirPath}\${PackageFileName}"
    if ((Test-Path "${PackageFilePath}")) {
        # �t�@�C������
        return ("${PackageFilePath}")
    } else {
        # �t�@�C���Ȃ�
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
        ���C������
#>
function Main
{
    $package_array = @()

    # �ˑ��֌W�̊m�F
    $package_array = ${package_array} + (Set-Package "https://aka.ms/${vc_libs_name}" "${vc_libs_name}")
    $package_array = ${package_array} + (Set-Package "https://github.com/microsoft/microsoft-ui-xaml/releases/download/v${ui_xaml_ver}/Microsoft.UI.Xaml.${ui_xaml_base_ver}.x64.appx" "${ui_xaml_name}")

    # winget�̊m�F
    $package_array = ${package_array} + (Set-Package "https://github.com/microsoft/winget-cli/releases/download/v${winget_ver}/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" "${winget_name}")

    # PowerShell�̊m�F
    $package_array = ${package_array} + (Set-Package "https://github.com/PowerShell/PowerShell/releases/download/v${powershell_ver}/PowerShell-${powershell_ver}-win-x64.msi" "${powershell_name}")

    # WindowsTerminal�̊m�F
    $package_array = ${package_array} + (Set-Package "https://github.com/microsoft/terminal/releases/download/v${win_term_ver}/Microsoft.WindowsTerminal_${win_term_ver}_8wekyb3d8bbwe.msixbundle" "${win_term_name}")

    # �p�b�P�[�W�̃C���X�g�[��
    foreach ($package in ${package_array}) {
        if ((Get-ChildItem ${package}).Extension -eq ".msi") {
            Start-Process msiexec -ArgumentList "/i ${package} /passive" -Wait
        } else {
            Add-AppPackage -Path ${package}
        }
    }

    # winget�p�b�P�[�W�̃C���X�g�[��
    winget import ${WorkMountDir}\scripts\winget_packages.json
}

Main
