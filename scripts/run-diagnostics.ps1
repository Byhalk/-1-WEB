
$ErrorActionPreference = 'Continue'
$ProgressPreference = 'SilentlyContinue'

$base = 'https://dummyjson.com'

Write-Host '=== CURL VERSION ===' -ForegroundColor Cyan
curl.exe --version

Write-Host '=== GET USERS ===' -ForegroundColor Cyan
curl.exe -i "$base/users?limit=2"

Write-Host '=== POST REQUEST ===' -ForegroundColor Cyan
$postBody = '{"title":"HTTP practical work","userId":1}'
$postBody | curl.exe -i -X POST "$base/posts/add" -H 'Content-Type: application/json' --data-binary '@-'

Write-Host '=== HEAD PRODUCTS ===' -ForegroundColor Cyan
curl.exe -I "$base/products"

Write-Host '=== HTTP 404 ===' -ForegroundColor Cyan
curl.exe -i 'https://httpbin.org/status/404'

Write-Host '=== HTTP 500 ===' -ForegroundColor Cyan
curl.exe -i 'https://httpbin.org/status/500'

Write-Host '=== AUTHENTICATION ===' -ForegroundColor Cyan
$loginJson = '{"username":"emilys","password":"emilyspass"}'
$login = $loginJson | curl.exe -sS -X POST "$base/auth/login" -H 'Content-Type: application/json' --data-binary '@-' | ConvertFrom-Json

$token = [string]$login.accessToken

if ([string]::IsNullOrWhiteSpace($token)) {
    Write-Host 'Login failed. Token not received.' -ForegroundColor Red
}
else {
    Write-Host "Login successful. Token length: $($token.Length)"
    Write-Host '=== AUTH/ME ===' -ForegroundColor Cyan
    curl.exe -i -sS "$base/auth/me" -H "Authorization: Bearer $token" -H 'Accept: application/json'
}

Write-Host '=== NETWORK TIMINGS ===' -ForegroundColor Cyan
curl.exe -sS -o NUL -w 'DNS: %{time_namelookup}s | TCP: %{time_connect}s | TLS: %{time_appconnect}s | TTFB: %{time_starttransfer}s | Total: %{time_total}s' "$base/products"
Write-Host ''

Write-Host '=== TLS TRACE ===' -ForegroundColor Cyan
curl.exe -v "$base/products/1" -o NUL

Write-Host '=== HTTP REDIRECT ===' -ForegroundColor Cyan
curl.exe -I -L 'http://dummyjson.com/products/1'

Write-Host '=== COOKIE SAVE ===' -ForegroundColor Cyan
$cookieUrl = 'https://httpbin.org/cookies/set?user_role=student&session_key=lab1_token'
curl.exe -sS -L -c cookies.txt "$cookieUrl"
Write-Host 'Cookie jar contents:'
Get-Content .\cookies.txt

Write-Host '=== COOKIE SEND ===' -ForegroundColor Cyan
curl.exe -i -b cookies.txt 'https://httpbin.org/cookies'

Write-Host '=== COOKIE SECURITY ATTRIBUTES ===' -ForegroundColor Cyan
curl.exe -i 'https://httpbin.org/response-headers?Set-Cookie=session_id%3Dxyz789%3B%20Path%3D%2F%3B%20Secure%3B%20HttpOnly%3B%20SameSite%3DStrict'

Write-Host '=== CORS PREFLIGHT OPTIONS ===' -ForegroundColor Cyan
curl.exe -i -X OPTIONS 'https://httpbin.org/post' -H 'Origin: https://example.com' -H 'Access-Control-Request-Method: POST' -H 'Access-Control-Request-Headers: Content-Type'

Write-Host 'DIAGNOSTICS FINISHED' -ForegroundColor Green
