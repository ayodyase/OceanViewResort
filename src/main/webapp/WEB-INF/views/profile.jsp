<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Ocean View Resort - User Profile</title>
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
      padding: 24px 32px;
      background: #ffffffcc;
      backdrop-filter: blur(6px);
      border-bottom: 1px solid #e5e7eb;
      position: sticky;
      top: 0;
      z-index: 10;
    }
    .header-content {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 16px;
      flex-wrap: wrap;
    }
    .brand {
      display: flex;
      align-items: center;
      gap: 12px;
    }
    .brand-logo {
      width: 44px;
      height: 44px;
    }
    .brand h1 {
      font-size: 20px;
      margin: 0;
    }
    .brand span {
      color: var(--muted);
      font-size: 12px;
    }
    .header-actions {
      display: flex;
      align-items: center;
      gap: 12px;
    }
    .card-link {
      text-decoration: none;
    }
    .btn {
      border: none;
      background: var(--primary);
      color: #ffffff;
      padding: 10px 18px;
      border-radius: 999px;
      font-weight: 600;
      cursor: pointer;
    }
    .btn-secondary {
      background: #eef2f7;
      color: #1f2937;
    }
    main {
      padding: 32px;
      max-width: 1100px;
      margin: 0 auto;
    }
    h2 {
      margin: 0 0 16px;
      font-size: 24px;
    }
    .grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
      gap: 18px;
    }
    .card {
      background: var(--card);
      border-radius: var(--radius);
      box-shadow: var(--shadow);
      padding: 20px;
    }
    .field {
      margin-bottom: 12px;
    }
    .label {
      font-size: 12px;
      color: var(--muted);
      text-transform: uppercase;
      letter-spacing: 0.08em;
      margin-bottom: 4px;
    }
    .value {
      font-weight: 600;
      font-size: 14px;
    }
    .form-row {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 12px;
    }
    .input {
      width: 100%;
      padding: 10px 12px;
      border-radius: 10px;
      border: 1px solid #d9dee7;
      font-size: 14px;
    }
    .message {
      padding: 10px 14px;
      border-radius: 10px;
      margin-bottom: 12px;
      font-size: 13px;
    }
    .message.error {
      background: #ffe3e3;
      color: #b02a2a;
      border: 1px solid #f4b2b2;
    }
    .message.success {
      background: #e6f7ef;
      color: #0f7a4d;
      border: 1px solid #bfe6d2;
    }
  </style>
</head>
<body>
  <header>
    <div class="header-content">
      <div class="brand">
        <img class="brand-logo" src="${pageContext.request.contextPath}/assets/logo.png" alt="Ocean View Resort logo" />
        <div>
          <h1>Ocean View Resort</h1>
          <span>User Profile</span>
        </div>
      </div>
      <div class="header-actions">
        <a class="card-link" href="${pageContext.request.contextPath}/admin">
          <button class="btn btn-secondary" type="button">Back to Admin</button>
        </a>
        <a class="card-link" href="${pageContext.request.contextPath}/logout">
          <button class="btn btn-secondary" type="button">Logout</button>
        </a>
      </div>
    </div>
  </header>

  <main>
    <h2>Profile Details</h2>
    <div class="grid">
      <div class="card">
        <div class="field">
          <div class="label">Name</div>
          <div class="value"><c:out value="${profileName}" /></div>
        </div>
        <div class="field">
          <div class="label">Role</div>
          <div class="value"><c:out value="${profileRole}" /></div>
        </div>
        <div class="field">
          <div class="label">Username</div>
          <div class="value"><c:out value="${profileUsername}" /></div>
        </div>
        <div class="field">
          <div class="label">Email</div>
          <div class="value"><c:out value="${profileEmail}" /></div>
        </div>
      </div>
      <div class="card">
        <div class="field">
          <div class="label">Employee ID</div>
          <div class="value"><c:out value="${profileEmployeeId}" /></div>
        </div>
        <div class="field">
          <div class="label">NIC</div>
          <div class="value"><c:out value="${profileNic}" /></div>
        </div>
        <div class="field">
          <div class="label">Gender</div>
          <div class="value"><c:out value="${profileGender}" /></div>
        </div>
        <div class="field">
          <div class="label">Working Hours</div>
          <div class="value"><c:out value="${profileHours}" /></div>
        </div>
        <div class="field">
          <div class="label">Status</div>
          <div class="value"><c:out value="${profileStatus}" /></div>
        </div>
      </div>
      <div class="card">
        <h3>Change Password</h3>
        <c:if test="${not empty errorMessage}">
          <div class="message error"><c:out value="${errorMessage}" /></div>
        </c:if>
        <c:if test="${not empty successMessage}">
          <div class="message success"><c:out value="${successMessage}" /></div>
        </c:if>
        <form method="post" action="${pageContext.request.contextPath}/profile/password" autocomplete="off">
          <div class="form-row">
            <div class="field">
              <div class="label">Current Password</div>
              <input class="input" type="password" name="currentPassword" required />
            </div>
          </div>
          <div class="form-row">
            <div class="field">
              <div class="label">New Password</div>
              <input class="input" type="password" name="newPassword" required />
            </div>
            <div class="field">
              <div class="label">Confirm Password</div>
              <input class="input" type="password" name="confirmPassword" required />
            </div>
          </div>
          <div style="margin-top: 12px;">
            <button class="btn" type="submit">Update Password</button>
          </div>
        </form>
      </div>
    </div>
  </main>
</body>
</html>
