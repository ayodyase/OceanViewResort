<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Ocean View Resort - Admin</title>
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
  <header>
    <div class="header-content">
      <div class="brand">
        <img class="brand-logo" src="${pageContext.request.contextPath}/assets/logo.png" alt="Ocean View Resort logo" />
        <div>
          <h1>Ocean View Resort</h1>
          <span>Administration Panel</span>
        </div>
      </div>
      <a class="card-link" href="${pageContext.request.contextPath}/logout">
        <button class="btn btn-secondary" type="button">Logout</button>
      </a>
    </div>
  </header>

  <main>
    <h2>Overview</h2>
    <div class="stats">
      <div class="stat-card">
        <h3>${availableRoomsCount}</h3>
        <span>Available Rooms</span>
      </div>
      <div class="stat-card">
        <h3>${unavailableRoomsCount}</h3>
        <span>Unavailable Rooms</span>
      </div>
      <div class="stat-card">
        <h3>${bookedRoomsCount}</h3>
        <span>Booked Rooms</span>
      </div>
      <div class="stat-card">
        <h3>${unbookedRoomsCount}</h3>
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
</body>
</html>
