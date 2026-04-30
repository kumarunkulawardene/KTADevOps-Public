# Running Linux containers on windows 
# To switch to Linux Containers

[Environment]::SetEnvironmentVariable("LCOW_SUPPORTED", "1", "Machine")

Restart-Service docker

# To switch back to Windows Containers

[Environment]::SetEnvironmentVariable("LCOW_SUPPORTED", $null, "Machine")

Restart-Service docker


##