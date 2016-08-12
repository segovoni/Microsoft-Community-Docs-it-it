$outf = "c:\Users\aldod\Desktop\outlist.md"

$wd = New-Object -ComObject Word.Application

# $wd.Visible = $false
$objDocument = $wd.Documents.Open("c:\Users\aldod\Desktop\StruttoraTA.docx")
$paras = $objDocument.Paragraphs
foreach( $p in $paras)
{
if(!$p.Range.Hyperlinks.Count) {Out-File -Append -InputObject $p.Range.Text -FilePath $outf -Encoding UTF8} 
foreach($h in $p.Range.Hyperlinks)
{
$s = "# ["+$h.TextToDisplay+"]("+$h.Name+")"
Out-File -Append -InputObject $s -FilePath $outf -Encoding UTF8
}
} 


$objDocument.Close()
$wd.Quit()
$wd = $null


