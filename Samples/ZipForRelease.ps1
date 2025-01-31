$samplesPath = $PSScriptRoot
$repoBasePath = Split-Path -Path $samplesPath -Parent

#remove release folder (if exist) and create it again
$releasePath = [IO.Path]::Combine($repoBasePath, 'Release')


Write-Output -InputObject $releasePath

Remove-Item -LiteralPath $releasePath -Force -Recurse
$releaseFolder = New-Item -ItemType Directory -Force -Path $releasePath




$revitDirs = Get-ChildItem -Path $samplesPath -Directory
$exclude = @("*.ps1","*.zip")

Foreach ($revitDir in $revitDirs)
{
      #revit folder names
      $name = $revitDir.name

      #sample subfolders
      $dirs = Get-ChildItem -Path $mypath\$revitDir -Directory

      #Compress-Archive -Path $mypath\$revitDir -DestinationPath $mypath\$name

      #iterate through subfolders
      Foreach($dir in $dirs)
      {
           #first revit versions
           Compress-Archive -Path $mypath\$revitDir\$dir -Update -DestinationPath $releasePath\$name

           #individual sample names
           $sampleName = $revitDir.name + "_" + $dir.name -replace"Revit"

           #now each sample
           Compress-Archive -Path $mypath\$revitDir\$dir\ -Update -DestinationPath $releasePath\$sampleName

      }
}