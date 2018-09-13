$files = Get-ChildItem -Recurse D:\dd\VS\src\ExternalAPIs\CdfvstoolsTest -File

foreach ($file in $files)
{
    if(Test-Path $file.FullName -PathType Container)
    {
        continue
    }
    echo $file.FullName >> "strings.txt"
}