# Fix navigation menus across all HTML files

$standardNav = @"
            <ul class="nav flex-column">
                <li class="nav-item"><a href="index.html" class="nav-link py-2 text-white">Home</a></li>
                <li class="nav-item"><a href="about.html" class="nav-link py-2 text-white">About</a></li>
                <li class="nav-item"><a href="aims-scope.html" class="nav-link py-2 text-white">Aims & Scope</a></li>
                <li class="nav-item"><a href="rationale.html" class="nav-link py-2 text-white">Rationale</a></li>
                <li class="nav-item"><a href="target-audience.html" class="nav-link py-2 text-white">Target Audience</a></li>
                <li class="nav-item"><a href="editorial-board.html" class="nav-link py-2 text-white">Editorial Board</a></li>
                <li class="nav-item"><a href="submission-guidelines.html" class="nav-link py-2 text-white">Submission Guidelines</a></li>
                <li class="nav-item"><a href="indexing-abstracting.html" class="nav-link py-2 text-white">Indexing & Abstracting</a></li>
                <li class="nav-item"><a href="call-for-papers.html" class="nav-link py-2 text-white">Call for Papers</a></li>
                <li class="nav-item"><a href="contact.html" class="nav-link py-2 text-white">Contact</a></li>
            </ul>
"@

$files = @(
    'index.html',
    'about.html',
    'aims-scope.html',
    'rationale.html',
    'target-audience.html',
    'editorial-board.html',
    'submission-guidelines.html',
    'call-for-papers.html',
    'contact.html',
    'indexing-abstracting.html'
)

foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "Processing $file..."
        $content = Get-Content $file -Raw
        
        # Replace the navigation menu section using regex
        # Match from <ul class="nav flex-column"> to </ul>
        $pattern = '(?s)\s*<ul class="nav flex-column">.*?</ul>'
        $content = $content -replace $pattern, $standardNav
        
        Set-Content $file -Value $content -NoNewline
        Write-Host "  ✓ Updated $file"
    }
}

Write-Host "`nAll navigation menus standardized!"
