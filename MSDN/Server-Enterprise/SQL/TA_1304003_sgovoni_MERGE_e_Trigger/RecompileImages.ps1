
# RecompileImages.ps1 -p "TA_Test_My_Article" 

param([string]$p = "")

Write-Host "Arg1: $p"


if( $p -eq ""){
  # echo "Please enter the Project name"
  # echo 'usage: .\RecompileImages.ps1 -p "TA_My_Test_Article"'

  $f = Get-ChildItem -Filter *.HxC
  $p = $f.Name.Split('.')[0]
  
  & 'C:\Program Files\Common Files\Microsoft Shared\Help 2.0 Compiler\hxcomp.exe' -p .\$p.HxC -r . -o .\$p.HxS


  return 1
  }
  else
  {
  & 'C:\Program Files\Common Files\Microsoft Shared\Help 2.0 Compiler\hxcomp.exe' -p .\$p.HxC -r . -o .\$p.HxS
  
  return 0
  }