param(
  [int]$Port = 8080
)

$siteRoot = [System.IO.Path]::GetFullPath($PSScriptRoot)
$listener = [System.Net.HttpListener]::new()
$listener.Prefixes.Add("http://localhost:$Port/")
$listener.Start()

Write-Host "Serving $siteRoot at http://localhost:$Port/"

$contentTypes = @{
  ".html" = "text/html; charset=utf-8"
  ".css"  = "text/css; charset=utf-8"
  ".js"   = "text/javascript; charset=utf-8"
  ".png"  = "image/png"
  ".jpg"  = "image/jpeg"
  ".jpeg" = "image/jpeg"
  ".gif"  = "image/gif"
  ".svg"  = "image/svg+xml"
  ".webp" = "image/webp"
  ".ico"  = "image/x-icon"
}

try {
  while ($listener.IsListening) {
    $context = $listener.GetContext()
    $relativePath = [Uri]::UnescapeDataString($context.Request.Url.AbsolutePath.TrimStart("/"))

    if ([string]::IsNullOrWhiteSpace($relativePath)) {
      $relativePath = "index.html"
    }

    $requestedPath = [System.IO.Path]::GetFullPath(
      [System.IO.Path]::Combine($siteRoot, $relativePath.Replace("/", [System.IO.Path]::DirectorySeparatorChar))
    )

    if (-not $requestedPath.StartsWith($siteRoot, [System.StringComparison]::OrdinalIgnoreCase) -or
        -not [System.IO.File]::Exists($requestedPath)) {
      $context.Response.StatusCode = 404
      $context.Response.Close()
      continue
    }

    $extension = [System.IO.Path]::GetExtension($requestedPath).ToLowerInvariant()
    $context.Response.ContentType = if ($contentTypes.ContainsKey($extension)) {
      $contentTypes[$extension]
    } else {
      "application/octet-stream"
    }

    $bytes = [System.IO.File]::ReadAllBytes($requestedPath)
    $context.Response.ContentLength64 = $bytes.Length
    $context.Response.OutputStream.Write($bytes, 0, $bytes.Length)
    $context.Response.Close()
  }
}
finally {
  $listener.Stop()
  $listener.Close()
}
