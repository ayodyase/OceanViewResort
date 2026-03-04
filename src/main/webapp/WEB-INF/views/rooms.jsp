<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Ocean View Resort - Rooms</title>
  <link rel="icon" href="${pageContext.request.contextPath}/assets/logo.png" />
  <style>
    :root {
      --bg: #f4f6fb;
      --card: #ffffff;
      --text: #1f2937;
      --muted: #6b7280;
      --primary: #0f4c81;
      --accent: #e2b04a;
      --shadow: 0 18px 40px rgba(15, 23, 42, 0.12);
      --radius: 16px;
    }
    * { box-sizing: border-box; }
    body {
      margin: 0;
      font-family: "Segoe UI", "Helvetica Neue", Arial, sans-serif;
      color: var(--text);
      background: radial-gradient(1200px 800px at 15% 15%, #e7f0ff 0%, var(--bg) 55%, #eef2f7 100%);
      min-height: 100vh;
    }
    header {
      padding: 24px 36px;
      background: #ffffffcc;
      backdrop-filter: blur(6px);
      border-bottom: 1px solid #e5e7eb;
      position: sticky;
      top: 0;
      z-index: 10;
    }
    .brand {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 16px;
      flex-wrap: wrap;
    }
    .brand-info {
      display: flex;
      align-items: center;
      gap: 14px;
    }
    .brand-logo {
      width: 44px;
      height: 44px;
      border-radius: 12px;
      object-fit: cover;
      box-shadow: 0 6px 16px rgba(15, 23, 42, 0.15);
      border: 2px solid #ffffff;
    }
    .brand h1 {
      margin: 0;
      font-size: 20px;
    }
    .brand span {
      display: block;
      color: var(--muted);
      font-size: 12px;
    }
    .header-actions {
      display: flex;
      gap: 10px;
      flex-wrap: wrap;
    }
    .btn-link {
      text-decoration: none;
    }
    .btn {
      border: none;
      border-radius: 10px;
      padding: 10px 14px;
      font-weight: 600;
      font-size: 13px;
      cursor: pointer;
      background: var(--primary);
      color: #fff;
      box-shadow: 0 10px 20px rgba(15, 76, 129, 0.2);
    }
    .btn-secondary {
      background: #eef0f5;
      color: var(--text);
      box-shadow: none;
    }
    main {
      padding: 32px 36px 48px;
      max-width: 1200px;
      margin: 0 auto;
    }
    .subtext {
      margin: 6px 0 0;
      color: var(--muted);
      font-size: 14px;
    }
    .grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 18px;
      margin-top: 24px;
    }
    .card {
      background: var(--card);
      border-radius: var(--radius);
      padding: 20px 18px;
      box-shadow: var(--shadow);
      border: 1px solid #eef0f5;
    }
    .card-link {
      text-decoration: none;
      color: inherit;
      display: block;
    }
    .card h3 {
      margin: 0 0 8px 0;
      font-size: 16px;
      text-align: center;
    }
    .card p {
      margin: 0;
      color: var(--muted);
      font-size: 13px;
      line-height: 1.5;
    }
  </style>
</head>
<body>
  <header>
    <div class="brand">
      <div class="brand-info">
        <img class="brand-logo" src="${pageContext.request.contextPath}/assets/logo.png" alt="Ocean View Resort logo" />
        <div>
          <h1>Ocean View Resort</h1>
        </div>
      </div>
      <div class="header-actions">
        <a class="btn-link" href="${pageContext.request.contextPath}/admin">
          <button class="btn btn-secondary" type="button">Back to Admin</button>
        </a>
      </div>
    </div>
  </header>

  <main>
    <h2>Room Management</h2>
    <div class="grid">
      <a class="card card-link" href="${pageContext.request.contextPath}/rooms/inventory">
        <h3>Room Inventory</h3>
      </a>
      <a class="card card-link" href="${pageContext.request.contextPath}/rooms/rates">
        <h3>Rates & Packages</h3>
      </a>
      <a class="card card-link" href="${pageContext.request.contextPath}/rooms/availability">
        <h3>Rooms Availability</h3>
      </a>
    </div>
  </main>
</body>
</html>
