Add-Type -AssemblyName System.IO.Compression.FileSystem
$docxPath = 'c:\doms-journal\content.docx'
if (Test-Path $docxPath) {
    $zip = [System.IO.Compression.ZipFile]::OpenRead($docxPath)
    $entry = $zip.GetEntry('word/document.xml')
    if ($entry) {
        $reader = New-Object System.IO.StreamReader($entry.Open())
        $content = $reader.ReadToEnd()
        # Simple regex to strip tags (rough)
        $text = $content -replace '<[^>]+>', ' '
        Write-Output $text
    } else {
        Write-Error "word/document.xml not found inside docx"
    }
    $zip.Dispose()
} else {
    Write-Error "File not found: $docxPath"
}
