# Практична робота № 1 — Дослідження HTTP/HTTPS

**Студент:** Куровський Іван Дмитрович  
**Група:** КН-43  
**Дисципліна:** Розробка WEB-застосувань

## Мета
Дослідити HTTP/HTTPS, REST-операції, заголовки, статуси, TLS, cookies та CORS за допомогою браузерних DevTools, Postman або REST Client, `curl` та Git.

## Вміст проєкту
- `requests.http` — готові запити для розширення REST Client у VS Code.
- `scripts/run-diagnostics.ps1` — команди для PowerShell: CRUD, автентифікація, таймінги, TLS, cookies, CORS.
- `Звіт_практична_1.docx` — звіт 

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

## Рівень 3 — TLS, cookies, CORS
Скрипт містить:
- TLS-трасування через `curl.exe -v`;
- порівняння HTTP та HTTPS;
- запис і повторне надсилання cookies через cookie jar;
- перевірку `Set-Cookie` з `HttpOnly`, `Secure`, `SameSite`;
- OPTIONS Preflight із заголовками Origin та Access-Control-Request-*.
