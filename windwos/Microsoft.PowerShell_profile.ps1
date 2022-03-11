
  Import-Module posh-git

  # Chocolatey profile
  $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
  if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
  }

  #  Kill process using a given network port
  function killp( [ValidateNotNullOrEmpty()] [int] $Port ) {
      $netstat = netstat.exe -ano | select -Skip 4
      $p_line  = $netstat | ? { $p = (-split $_ | select -Index 1) -split ':' | select -Last 1; $p -eq $Port } | select -First 1
      if (!$p_line) { Write-Host "No process found using port" $Port; return }
      $p_id = $p_line -split '\s+' | select -Last 1
      if (!$p_id) { throw "Can't parse process id for port $Port" }
      if ($p_id -eq '0') { Write-Warning $p_line; return }

      $proc = Get-CimInstance win32_process -Filter "ProcessId = $p_id"
      if (!$proc) { Write-Host "Process with pid $p_id using port $Port is no longer running" }
      Invoke-CimMethod $proc -MethodName "Terminate" | Out-Null

      #$p_name = ps -Id $p_id -ea 0 | kill -Force -PassThru | % ProcessName
      Write-Host "Process killed: $($proc.Name) (id $p_id) using port" $Port
      Write-Host "  " $proc.Path
      Write-Host "  " $prPageable pageableoc.CommandLine
  }
  # killp 8080

  # kill all java process

  function killjava(){
    taskkill /im java.exe /F
    taskkill /im javaw.exe /F
  }

  #  Kill process using a given network port
  function killp( [ValidateNotNullOrEmpty()] [int] $Port ) {
      $netstat = netstat.exe -ano | Select-Object -Skip 4
      $p_line  = $netstat | ? { $p = (-split $_ | select -Index 1) -split ':' | select -Last 1; $p -eq $Port } | select -First 1
      if (!$p_line) { Write-Host "No process found using port" $Port; return }
      $p_id = $p_line -split '\s+' | select -Last 1
      if (!$p_id) { throw "Can't parse process id for port $Port" }
      if ($p_id -eq '0') { Write-Warning $p_line; return }

      $proc = Get-CimInstance win32_process -Filter "ProcessId = $p_id"
      if (!$proc) { Write-Host "Process with pid $p_id using port $Port is no longer running" }
      Invoke-CimMethod $proc -MethodName "Terminate" | Out-Null

      #$p_name = ps -Id $p_id -ea 0 | kill -Force -PassThru | % ProcessName
      Write-Host "Process killed: $($proc.Name) (id $p_id) using port" $Port
      Write-Host "  " $proc.Path
      Write-Host "  " $prPageable pageableoc.CommandLine
  }
  # killp 8080

  # kill all java process

  function killjava(){
    taskkill /im java.exe /F
    taskkill /im javaw.exe /F
  }

  # open file manager 
  function fm(){
    Invoke-Item .
  }

  # shortcut for ls -la
  function ll(){
    dir

  }

  # copy current path to clipborad
  function cpath(){
    $path = Get-Location
    Set-Clipboard -Value $path
  }

  # admin windows terminal 
  function admin(){
    powershell "Start-Process -Verb RunAs cmd.exe '/c start wt.exe'"
  }


  # shortcut to set jdk 11
  function j11(){
    $java11 = 'C:\app\jdk-11\bin'
    $oldPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
    $newPath = "$java11; $oldPath"
    Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
    # set JAVA_HOME to JAVA11
    $JAVA_HOME = $java11 -replace "\\bin",""
    [System.Environment]::SetEnvironmentVariable('JAVA_HOME', $JAVA_HOME,[System.EnvironmentVariableTarget]::Machine)
    # reload environment in current session
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
  }

  # shortcut to set jdk 8
  function j8(){
    $java8 = 'C:\app\jdk-8\bin'
    $oldPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
    $newPath = "$java8;$oldPath"
    Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
    # set JAVA_HOME to JAVA8
    $JAVA_HOME = $java8 -replace "\\bin",""
    [System.Environment]::SetEnvironmentVariable('JAVA_HOME', $JAVA_HOME,[System.EnvironmentVariableTarget]::Machine)
    # reload environment in current session
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
  }

  # shortcut to set jdk 8
  function j15(){
    $java15 = 'C:\app\jdk-15\bin'
    $oldPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
    $newPath = "$java15;$oldPath"
    Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
    # set JAVA_HOME to JAVA15
    $JAVA_HOME = $java15 -replace "\\bin",""
    [System.Environment]::SetEnvironmentVariable('JAVA_HOME', $JAVA_HOME,[System.EnvironmentVariableTarget]::Machine)
    # reload environment in current session
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
  }

    # shortcut to set jdk 7
    function j7(){
      $java7 = 'C:\app\jdk-7\bin'
      $oldPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
      $newPath = "$java7;$oldPath"
      Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
      # set JAVA_HOME to JAVA15
      $JAVA_HOME = $java7 -replace "\\bin",""
      [System.Environment]::SetEnvironmentVariable('JAVA_HOME', $JAVA_HOME,[System.EnvironmentVariableTarget]::Machine)
      # reload environment in current session
      $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    }

    # shortcut to set jdk 17
  function j17(){
    $java17 = 'C:\app\jdk-17\bin'
    $oldPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
    $newPath = "$java17;$oldPath"
    Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
    # set JAVA_HOME to JAVA15
    $JAVA_HOME = $java17 -replace "\\bin",""
    [System.Environment]::SetEnvironmentVariable('JAVA_HOME', $JAVA_HOME,[System.EnvironmentVariableTarget]::Machine)
    # reload environment in current session
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
  }

  Invoke-Expression (&starship init powershell)
