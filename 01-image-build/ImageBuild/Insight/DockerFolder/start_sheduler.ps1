foreach($ev in [System.Environment]::GetEnvironmentVariables('process').Keys)
{
    [System.Environment]::SetEnvironmentVariable($ev,[System.Environment]::GetEnvironmentVariable($ev,'process'), 'machine');
}

Restart-Service -Name InsightSchedulerService640
Start-Process -FilePath 'C:\ServiceMonitor.exe' -ArgumentList 'InsightSchedulerService640' -Wait;