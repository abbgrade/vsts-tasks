[CmdletBinding()]
param()

Trace-VstsEnteringInvocation $MyInvocation
try {
    Import-VstsLocStrings "$PSScriptRoot\task.json"

    #region Input

    $reportPath = Get-VstsInput -Name 'reportPath' -Require
    $reportName = Get-VstsInput -Name 'reportName' -Default $null
    $workspaceName = Get-VstsInput -Name 'workspaceName' -Require

    #endregion

    #region Deploy
    
    $workspace = Get-PowerBIWorkspace -Name $workspaceName
    New-PowerBIReport -Path $reportPath -Name $reportName -Workspace $workspace

    #endregion

    Trace-VstsLeavingInvocation $MyInvocation
} catch {
    Write-Error $_.Exception
}