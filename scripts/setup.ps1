<#
    .SYNOPSIS
        ���C������
#>
function Main
{
    # Windows�̐ݒ菈��
    . .\sys_config.ps1

    # �C���X�g�[������
    . .\install.ps1

    Restart-Computer
}

Main
