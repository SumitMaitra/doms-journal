Add-Type -AssemblyName System.IO.Compression.FileSystem
$docxPath = 'c:\doms-journal\content.docx'
try {
    $zip = [System.IO.Compression.ZipFile]::OpenRead($docxPath)
    $entry = $zip.GetEntry('word/document.xml')
    if ($entry) {
        $reader = New-Object System.IO.StreamReader($entry.Open())
        $content = $reader.ReadToEnd()
        $text = $content -replace '<[^>]+>', ' '
        
        # Look for "Address" or "Contact" or "Email"
        $matches = $text | Select-String -Pattern "Address|Contact|Email" -Context 0, 200
        if ($matches) {
            foreach ($match in $matches) {
                Write-Output $match.Context.PostContext
                Write-Output $match.Line
            }
        }
        else {
            Write-Output "Keywords not found. Showing last 500 chars:"
            if ($text.Length -gt 500) {
                Write-Output $text.Substring($text.Length - 500)
            }
            else {
                Write-Output $text
            }
        }
    }
    $zip.Dispose()
}
catch {
    Write-Error $_.Exception.Message
}
