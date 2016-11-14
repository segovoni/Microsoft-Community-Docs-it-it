## -------------- MAIN ---------------- ##

#cd 'C:\BUILD\Microsoft\CommunityDocs-itit\MSDN\Windows\UWP\'

Get-ChildItem *.md -Exclude TOC.md | 
ForEach-Object {
	$Title = Get-Content  $_.FullName -Encoding UTF8 -ReadCount 30  |  foreach { $_ -match "#" } | select -First 1
	# remove '#' [ and ] chars form the title
	$Title = $Title.Replace("#","")
	
	Write-Output ("#["+$Title+"]("+$_.BaseName+".md)")
	} |  
Out-File "TOC.md" -Encoding UTF8
