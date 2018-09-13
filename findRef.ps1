$strings = Get-Content ".\pathsToSearchFor\deletedFiles.txt"
$folders = Get-Content ".\folersToSearchIn\folders3.txt"
$PathNotFouldFiles = ".\output\PathNotFoundFiles.txt"
$PathReferedFiles = ".\output\PathReferedFiles.txt"
$NameNotFouldFiles = ".\output\NameNotFoundFiles.txt"
$NameReferedFiles = ".\output\NameReferedFiles.txt"

If (Test-Path $PathNotFouldFiles) {
    Remove-Item $PathNotFouldFiles
}

If (Test-Path $PathReferedFiles) {
    Remove-Item $PathReferedFiles
}

If (Test-Path $NameNotFouldFiles) {
    Remove-Item $NameNotFouldFiles
}

If (Test-Path $NameReferedFiles) {
    Remove-Item $NameReferedFiles
}
    
foreach($s in $strings)
{
    $output = @()
    foreach ($folder in $folders)
    {
        $fsoutput = @()
        $fsoutput += findstr /sic:"$s" $folder
        if ($fsoutput.Count -gt 0)
        {
				    $output += "[$folder]:"
            $output += $fsoutput
        }
    }
    
    if ($output.Count -eq 0)
    {
        echo $s >> $PathNotFouldFiles
        
				$fileName = split-path -leaf $s
				$output2 = @()
				foreach ($folder in $folders)
				{
						$fsoutput2 = @()
						$fsoutput2 += findstr /sic:"$fileName" $folder
						if ($fsoutput2.Count -gt 0)
						{
								$output2 += "[$folder]:"
								$output2 += $fsoutput2
						}
				}
				if ($output2.Count -eq 0)
				{
						echo $s >> $NameNotFouldFiles
						continue
				}
				echo "" >> $NameReferedFiles
				echo "Find references of file [$s]" >> $NameReferedFiles
				echo "-----------------------------------------------" >> $NameReferedFiles
				echo $output2 >> $NameReferedFiles
				echo "###############################################" >> $NameReferedFiles
				echo "End findstr $s" >> $NameReferedFiles
        continue
    }
    
    echo "" >> $PathReferedFiles
    echo "Find references of file [$s]" >> $PathReferedFiles
    echo "-----------------------------------------------" >> $PathReferedFiles
    echo $output >> $PathReferedFiles
    echo "###############################################" >> $PathReferedFiles
    echo "End findstr $s" >> $PathReferedFiles
}