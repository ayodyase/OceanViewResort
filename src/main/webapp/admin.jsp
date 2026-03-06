<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Ocean View Resort - Admin</title>
  <link rel="icon" href="${pageContext.request.contextPath}/assets/logo.png" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/responsive.css" />
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
    .header-content {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 16px;
      flex-wrap: wrap;
    }
    .header-actions {
      display: flex;
      align-items: center;
      gap: 16px;
    }
    .user-profile {
      display: flex;
      align-items: center;
      gap: 10px;
      background: #f1f4f9;
      border-radius: 999px;
      padding: 8px 14px;
    }
    .user-profile-link {
      text-decoration: none;
    }
    .user-avatar {
      width: 34px;
      height: 34px;
      border-radius: 50%;
      background: #0d4a7c;
      color: #ffffff;
      font-weight: 700;
      display: grid;
      place-items: center;
      font-size: 13px;
      letter-spacing: 0.5px;
    }
    .user-meta {
      display: flex;
      flex-direction: column;
      line-height: 1.1;
    }
    .user-name {
      font-weight: 600;
      font-size: 13px;
      color: #1b2b3a;
    }
    .user-role {
      font-size: 11px;
      color: #6c7a89;
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
    .stats {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
      gap: 16px;
      margin-top: 16px;
    }
    .section {
      margin-top: 24px;
      background: var(--card);
      border-radius: var(--radius);
      padding: 20px;
      border: 1px solid #eef0f5;
      box-shadow: var(--shadow);
    }
    .section h3 {
      margin: 0 0 12px 0;
      font-size: 16px;
    }
    .table {
      width: 100%;
      border-collapse: collapse;
      font-size: 13px;
    }
    .table th,
    .table td {
      text-align: left;
      padding: 10px 6px;
      border-bottom: 1px solid #eef0f5;
    }
    .table th {
      color: var(--muted);
      font-weight: 600;
      font-size: 12px;
    }
    .stat-card {
      background: var(--card);
      border-radius: var(--radius);
      padding: 16px 18px;
      border: 1px solid #eef0f5;
      box-shadow: var(--shadow);
      text-align: center;
    }
    .stat-card h3 {
      margin: 0;
      font-size: 22px;
    }
    .stat-card span {
      display: block;
      color: var(--muted);
      font-size: 12px;
      margin-top: 6px;
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
    .card-link h2 {
      text-align: center;
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
    .btn {
      border: none;
      border-radius: 10px;
      padding: 8px 14px;
      font-weight: 600;
      font-size: 13px;
      cursor: pointer;
      background: var(--primary);
      color: #fff;
    }
    .btn-secondary {
      background: #eef0f5;
      color: var(--text);
    }
  </style>
</head>
<body>
  <c:set var="profileName" value="${sessionScope.username}" />
  <c:if test="${not empty sessionScope.displayName}">
    <c:set var="profileName" value="${sessionScope.displayName}" />
  </c:if>
  <c:if test="${profileName == 'admin'}">
    <c:set var="profileName" value="Admin" />
  </c:if>
  <c:set var="profileRole" value="${sessionScope.role}" />
  <c:if test="${empty profileRole}">
    <c:set var="profileRole" value="Admin" />
  </c:if>
  <header>
    <div class="header-content">
      <div class="brand">
        <img class="brand-logo" src="${pageContext.request.contextPath}/assets/logo.png" alt="Ocean View Resort logo" />
        <div>
          <h1>Ocean View Resort</h1>
          <span><c:out value="${profileRole}" /></span>
        </div>
      </div>
      <div class="header-actions">
        <a class="user-profile-link" href="${pageContext.request.contextPath}/profile">
          <div class="user-profile">
            <div class="user-avatar">
              <c:out value="${fn:toUpperCase(fn:substring(profileName, 0, 1))}" />
            </div>
            <div class="user-meta">
            <div class="user-name"><c:out value="${profileName}" /></div>
            </div>
          </div>
        </a>
        <a class="card-link" href="${pageContext.request.contextPath}/logout">
          <button class="btn btn-secondary" type="button">Logout</button>
        </a>
      </div>
    </div>
  </header>

  <main>
    <h2>Overview</h2>
    <div class="stats">
      <div class="stat-card">
        <h3 class="js-counter" data-target="${availableRoomsCount}">0</h3>
        <span>Available Rooms</span>
      </div>
      <div class="stat-card">
        <h3 class="js-counter" data-target="${unavailableRoomsCount}">0</h3>
        <span>Unavailable Rooms</span>
      </div>
      <div class="stat-card">
        <h3 class="js-counter" data-target="${bookedRoomsCount}">0</h3>
        <span>Booked Rooms</span>
      </div>
      <div class="stat-card">
        <h3 class="js-counter" data-target="${unbookedRoomsCount}">0</h3>
        <span>Unbooked Rooms</span>
      </div>
    </div>

    <div class="section">
      <h3>Reservation List</h3>
      <table class="table">
        <thead>
          <tr>
            <th>Guest</th>
            <th>Room</th>
            <th>Check-in</th>
            <th>Check-out</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="reservation" items="${reservationList}">
            <tr>
              <td><c:out value="${reservation.guestName}" /></td>
              <td><c:out value="${reservation.roomNumber}" /></td>
              <td><c:out value="${reservation.checkInDate}" /></td>
              <td><c:out value="${reservation.checkOutDate}" /></td>
              <td><c:out value="${reservation.status}" /></td>
            </tr>
          </c:forEach>
          <c:if test="${empty reservationList}">
            <tr>
              <td colspan="5">No reservations yet.</td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>

    <div class="grid">
      <a class="card card-link" href="${pageContext.request.contextPath}/users">
        <h2>Staff Management</h2>
      </a>
      <a class="card card-link" href="${pageContext.request.contextPath}/rooms">
        <h2>Room Management</h2>
      </a>
      <a class="card card-link" href="${pageContext.request.contextPath}/bookings">
        <h2>Add New Reservation</h2>
      </a>
      <a class="card card-link" href="${pageContext.request.contextPath}/payments">
        <h2>Billing &amp; Payments</h2>
      </a>
    </div>
  </main>
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      var counters = document.querySelectorAll(".js-counter");
      counters.forEach(function (counter) {
        var target = parseInt(counter.getAttribute("data-target"), 10);
        if (!Number.isFinite(target) || target < 0) {
          counter.textContent = "0";
          return;
        }

        var durationMs = 700;
        var stepMs = 16;
        var steps = Math.max(1, Math.ceil(durationMs / stepMs));
        var currentStep = 0;

        var timer = setInterval(function () {
          currentStep += 1;
          var nextValue = Math.round((target * currentStep) / steps);
          counter.textContent = String(nextValue);
          if (currentStep >= steps) {
            counter.textContent = String(target);
            clearInterval(timer);
          }
        }, stepMs);
      });
    });
  </script>
</body>
</html>
