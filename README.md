# Практична робота № 1 — Дослідження HTTP/HTTPS

**Студент:** Куровський Іван Дмитрович  
**Група:** КН-43  
**Дисципліна:** Розробка WEB-застосувань

## Мета
Дослідити HTTP/HTTPS, REST-операції, заголовки, статуси, TLS, cookies та CORS за допомогою браузерних DevTools, Postman або REST Client, `curl` та Git.

## Вміст проєкту
- `requests.http` — готові запити для розширення REST Client у VS Code.
- `scripts/run-diagnostics.ps1` — команди для PowerShell: CRUD, автентифікація, таймінги, TLS, cookies, CORS.
- `screenshots/` — сюди додати фактичні скриншоти виконання.
- `Звіт_практична_1.docx` — звіт із місцями для вставлення скриншотів.

## Підготовка середовища (Windows)
1. Встановити/відкрити Visual Studio Code.
2. У VS Code встановити розширення **REST Client** (автор Huachao Mao) або використати Postman.
3. Відкрити цю папку через **File → Open Folder**.
4. Відкрити PowerShell у терміналі VS Code: **Terminal → New Terminal**.
5. Перевірити інструменти:
   ```powershell
   curl.exe --version
   git --version
   ```
6. Для запитів у `requests.http` натискати **Send Request** над кожним блоком.

## Рівень 1 — DevTools та REST
1. Виконати в `requests.http` запити GET, POST, PUT, DELETE до DummyJSON.
2. Зберегти запити у файлі `requests.http` (він уже підготовлений).
3. Відкрити `https://dummyjson.com/products` у Chrome.
4. Натиснути F12 → **Network** → перезавантажити сторінку → вибрати запит `products`.
5. Зафіксувати General, Request Headers, Response Headers і Timing.

Примітка: DummyJSON є тестовим API. POST/PUT/DELETE імітують зміни та повертають результат, але не зберігають його як постійну зміну бази.

## Рівень 2 — curl
У PowerShell запустити:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\run-diagnostics.ps1
```
Скрипт виконує запити до публічних тестових API. Для запиту логіну використовується тестовий обліковий запис, наведений у методичці. Токен використовується лише в межах поточного запуску.

Якщо команда `curl` у PowerShell запускає Invoke-WebRequest, використовуйте саме `curl.exe`.

## Рівень 3 — TLS, cookies, CORS
Скрипт містить:
- TLS-трасування через `curl.exe -v`;
- порівняння HTTP та HTTPS;
- запис і повторне надсилання cookies через cookie jar;
- перевірку `Set-Cookie` з `HttpOnly`, `Secure`, `SameSite`;
- OPTIONS Preflight із заголовками Origin та Access-Control-Request-*.

Важливо: CORS — браузерна політика. `curl` лише надсилає OPTIONS і показує відповідь сервера; він сам не застосовує браузерні обмеження CORS.

## Скріншоти для звіту
Зробіть реальні скриншоти й надішліть їх у чат. Потрібні:
1. `01_curl_version.png` — PowerShell із результатом `curl.exe --version`.
2. `02_rest_get.png` — GET product, статус 200 і JSON.
3. `03_rest_post.png` — POST product/add, статус 201 і повернений id.
4. `04_rest_put_delete.png` — PUT і DELETE зі статусами та JSON-відповідями.
5. `05_devtools_general.png` — Network → Headers → General для `/products`.
6. `06_devtools_headers.png` — Request Headers і Response Headers.
7. `07_devtools_timing.png` — вкладка Timing.
8. `08_curl_crud_users.png` — GET users і POST posts/add у терміналі.
9. `09_curl_status_codes.png` — заголовки для 404 та 500.
10. `10_auth_token_me.png` — успішна автентифікація та `/auth/me` (токен замаскувати).
11. `11_curl_timings.png` — DNS, TCP, TLS, TTFB, Total.
12. `12_tls_verbose.png` — TLS handshake та дані сертифіката (без приватних даних).
13. `13_http_redirect.png` — HTTP redirect та Location.
14. `14_cookie_jar.png` — створений `cookies.txt` і відповідь `/cookies`.
15. `15_cookie_security.png` — Set-Cookie з атрибутами.
16. `16_cors_preflight.png` — OPTIONS і CORS response headers.
17. `17_no_errors.png` — фінальний термінал/VS Code без помилок.

Можна надсилати скриншоти частинами. Не обрізайте статус-коди, URL, заголовки або вивід, які потрібно перевірити. Не надсилайте повний access token — замаскуйте його.

## Git
У терміналі з кореня папки:
```powershell
git init
git add .
git commit -m "Complete practical work 1: HTTP and HTTPS diagnostics"
```
Публікацію на GitHub можна виконати після створення репозиторію на GitHub:
```powershell
git branch -M main
git remote add origin https://github.com/USERNAME/REPOSITORY.git
git push -u origin main
```
Замініть `USERNAME` і `REPOSITORY` на власні значення.

## Контрольні питання
Відповіді навмисно не включені до цього проєкту. Після завершення практичної роботи пройдемо контрольні питання у форматі тесту безпосередньо в чаті.
