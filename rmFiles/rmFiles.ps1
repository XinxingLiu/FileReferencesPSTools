$FilesToRm = Get-Content .\PathNotFoundFiles.txt

foreach ($FileToRm in $FilesToRm)
{
    $sourceFile = "D:\dd\VS\src\ExternalAPIs\CdfvstoolsTest\" + $FileToRm
    $destinationFile = "D:\ExternalAPIs\CdfvstoolsTest_2\" + $FileToRm
    $destinationFolder = split-path -Parent $destinationFile
    if ((Test-Path -PathType Container $destinationFolder) -eq 0)
    {
        New-Item -ItemType Directory -Force -Path $destinationFolder
    }
    
    mv $sourceFile $destinationFolder
}