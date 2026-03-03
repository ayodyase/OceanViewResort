<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Ocean View Resort - Admin</title>
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
      padding: 28px 36px;
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
      gap: 14px;
    }
    .brand-logo {
      width: 48px;
      height: 48px;
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
    main {
      padding: 32px 36px 48px;
      max-width: 1200px;
      margin: 0 auto;
    }
    .grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 18px;
      margin-top: 24px;
    }
    .subtext {
      margin: 6px 0 0;
      color: var(--muted);
      font-size: 14px;
    }
    .card {
      background: var(--card);
      border-radius: var(--radius);
      padding: 20px 18px;
      box-shadow: var(--shadow);
      border: 1px solid #eef0f5;
      transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .card:hover {
      transform: translateY(-3px);
      box-shadow: 0 24px 50px rgba(15, 23, 42, 0.16);
    }
    .card h2 {
      margin: 0 0 8px 0;
      font-size: 16px;
    }
    .card p {
      margin: 0;
      color: var(--muted);
      font-size: 13px;
      line-height: 1.5;
    }
    .pill {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      background: #eef4ff;
      color: var(--primary);
      font-weight: 600;
      font-size: 11px;
      padding: 4px 10px;
      border-radius: 999px;
      margin-top: 12px;
    }
    .card-link {
      text-decoration: none;
      color: inherit;
      display: block;
    }
  </style>
</head>
<body>
  <header>
    <div class="brand">
      <img class="brand-logo" src="${pageContext.request.contextPath}/assets/logo.png" alt="Ocean View Resort logo" />
      <div>
        <h1>Ocean View Resort</h1>
        <span>Administration Panel</span>
      </div>
    </div>
  </header>

  <main>
    <h2>Overview</h2>
    <p class="subtext">Select a module to manage resort operations.</p>

    <div class="grid">
      <a class="card card-link" href="${pageContext.request.contextPath}/users">
        <h2>Users</h2>
        <p>Manage staff accounts, access levels, and activation status.</p>
        <span class="pill">Admin only</span>
      </a>
      <a class="card card-link" href="${pageContext.request.contextPath}/rooms">
        <h2>Rooms</h2>
        <p>Configure room inventory, rates, and availability.</p>
        <span class="pill">Operations</span>
      </a>
      <a class="card card-link" href="${pageContext.request.contextPath}/bookings">
        <h2>Bookings</h2>
        <p>Review upcoming stays, check-ins, and cancellations.</p>
        <span class="pill">Front desk</span>
      </a>
      <a class="card card-link" href="${pageContext.request.contextPath}/payments">
        <h2>Payments</h2>
        <p>Track invoices, deposits, and settlement status.</p>
        <span class="pill">Finance</span>
      </a>
      <a class="card card-link" href="${pageContext.request.contextPath}/reports">
        <h2>Reports</h2>
        <p>Generate occupancy, revenue, and performance reports.</p>
        <span class="pill">Analytics</span>
      </a>
      <a class="card card-link" href="${pageContext.request.contextPath}/settings">
        <h2>Settings</h2>
        <p>Resort details, policies, and system preferences.</p>
        <span class="pill">Configuration</span>
      </a>
    </div>
  </main>
</body>
</html>
