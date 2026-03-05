<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Ocean View Resort - Login</title>
  <link rel="icon" href="${pageContext.request.contextPath}/assets/logo.png" />
  <style>
    :root {
      --bg: #f4f6fb;
      --card: #ffffff;
      --text: #1f2937;
      --muted: #6b7280;
      --primary: #0f4c81;
      --primary-dark: #0c3b64;
      --accent: #e2b04a;
      --error: #b91c1c;
      --shadow: 0 20px 45px rgba(15, 23, 42, 0.12);
      --radius: 14px;
    }
    * {
      box-sizing: border-box;
    }
    body {
      margin: 0;
      font-family: "Segoe UI", "Helvetica Neue", Arial, sans-serif;
      color: var(--text);
      background: radial-gradient(1200px 800px at 10% 10%, #e8f1ff 0%, var(--bg) 55%, #eef2f7 100%);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 24px;
    }
    .login-card {
      width: 100%;
      max-width: 420px;
      background: var(--card);
      border-radius: var(--radius);
      box-shadow: var(--shadow);
      padding: 36px 32px;
      position: relative;
      overflow: hidden;
    }
    .login-card::before {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 6px;
      background: linear-gradient(90deg, var(--primary) 0%, var(--accent) 100%);
    }
    .brand {
      display: flex;
      align-items: center;
      gap: 12px;
      margin-bottom: 18px;
    }
    .brand-logo {
      width: 48px;
      height: 48px;
      border-radius: 12px;
      object-fit: cover;
      box-shadow: 0 6px 16px rgba(15, 23, 42, 0.15);
      border: 2px solid #ffffff;
    }
    h1 {
      font-size: 22px;
      margin: 0;
    }
    p.subtext {
      margin: 6px 0 24px 0;
      color: var(--muted);
      font-size: 14px;
    }
    label {
      display: block;
      font-weight: 600;
      font-size: 13px;
      margin-bottom: 8px;
    }
    input {
      width: 100%;
      padding: 12px 14px;
      border-radius: 10px;
      border: 1px solid #d6dbe5;
      font-size: 14px;
      transition: border-color 0.2s ease, box-shadow 0.2s ease;
    }
    input:focus {
      outline: none;
      border-color: var(--primary);
      box-shadow: 0 0 0 4px rgba(15, 76, 129, 0.12);
    }
    .field {
      margin-bottom: 16px;
    }
    .actions {
      margin-top: 8px;
    }
    button {
      width: 100%;
      border: none;
      border-radius: 10px;
      padding: 12px 14px;
      background: var(--primary);
      color: #fff;
      font-size: 15px;
      font-weight: 600;
      cursor: pointer;
      transition: background 0.2s ease, transform 0.2s ease;
    }
    button:hover {
      background: var(--primary-dark);
      transform: translateY(-1px);
    }
    .footer {
      margin-top: 18px;
      font-size: 12px;
      color: var(--muted);
      text-align: center;
    }
    .error {
      margin: 12px 0 0 0;
      color: var(--error);
      background: #fee2e2;
      border: 1px solid #fecaca;
      padding: 10px 12px;
      border-radius: 10px;
      font-size: 13px;
    }
  </style>
</head>
<body>
  <div class="login-card">
    <div class="brand">
      <img class="brand-logo" src="${pageContext.request.contextPath}/assets/logo.png" alt="Ocean View Resort logo" />
      <div>
        <h1>Ocean View Resort</h1>
      </div>
    </div>

    <form method="post" action="${pageContext.request.contextPath}/login" autocomplete="off">
        <div class="field">
          <label for="username">Username</label>
          <input id="username" name="username" type="text" required maxlength="50" />
        </div>
      <div class="field">
        <label for="password">Password</label>
        <input id="password" name="password" type="password" required maxlength="72" />
      </div>
      <div class="actions">
        <button type="submit">Sign In</button>
      </div>
    </form>

    <% if (request.getAttribute("error") != null) { %>
      <div class="error"><%= request.getAttribute("error") %></div>
    <% } else if (request.getParameter("error") != null) { %>
      <div class="error">Please sign in to continue.</div>
    <% } %>

    <div class="footer">Authorized use only.</div>
  </div>
</body>
</html>
