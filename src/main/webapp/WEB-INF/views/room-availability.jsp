<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Ocean View Resort - Room Availability</title>
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
    .btn-danger {
      background: #f05353;
      box-shadow: 0 10px 20px rgba(240, 83, 83, 0.2);
    }
    main {
      padding: 32px 36px 48px;
      max-width: 1200px;
      margin: 0 auto;
    }
    .section {
      margin-top: 24px;
      background: #ffffffcc;
      border: 1px solid #e5e7eb;
      border-radius: 24px;
      padding: 24px;
      box-shadow: 0 20px 50px rgba(15, 23, 42, 0.08);
    }
    .stats {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
      gap: 16px;
      margin-top: 12px;
    }
    .stat-card {
      background: var(--card);
      border-radius: 16px;
      padding: 14px 16px;
      border: 1px solid #eef0f5;
      text-align: center;
    }
    .stat-card h3 {
      margin: 0;
      font-size: 20px;
    }
    .stat-card span {
      display: block;
      color: var(--muted);
      font-size: 12px;
      margin-top: 6px;
    }
    .section-grid {
      display: grid;
      grid-template-columns: minmax(260px, 1fr) minmax(320px, 1.4fr);
      gap: 20px;
      margin-top: 18px;
    }
    .panel {
      background: var(--card);
      border-radius: 18px;
      padding: 18px;
      border: 1px solid #eef0f5;
      box-shadow: 0 16px 32px rgba(15, 23, 42, 0.08);
    }
    .panel h4 {
      margin: 0 0 12px;
      font-size: 16px;
    }
    .form-row {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
      gap: 12px;
      margin-bottom: 12px;
    }
    .field label {
      display: block;
      font-size: 12px;
      color: var(--muted);
      margin-bottom: 6px;
    }
    .input,
    .select,
    textarea {
      width: 100%;
      border: 1px solid #d9dee7;
      border-radius: 10px;
      padding: 10px 12px;
      font-size: 13px;
      outline: none;
      background: #f9fbff;
    }
    textarea {
      min-height: 80px;
      resize: vertical;
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
    .inline-actions {
      display: flex;
      gap: 8px;
      align-items: center;
    }
    .inline-actions .btn {
      padding: 6px 10px;
      font-size: 12px;
    }
    .inline-form {
      display: inline-block;
      margin: 0;
    }
    .alert {
      margin-top: 12px;
      background: #fff5f5;
      border: 1px solid #fecaca;
      color: #b91c1c;
      padding: 10px 12px;
      border-radius: 10px;
      font-size: 13px;
    }
    @media (max-width: 900px) {
      .section-grid {
        grid-template-columns: 1fr;
      }
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
        <a class="btn-link" href="${pageContext.request.contextPath}/rooms">
          <button class="btn btn-secondary" type="button">Back to Rooms</button>
        </a>
      </div>
    </div>
  </header>

  <main>
    <h2>Room Availability</h2>
    <div class="stats">
      <div class="stat-card">
        <h3>${availableRoomsCount}</h3>
        <span>Available Rooms</span>
      </div>
      <div class="stat-card">
        <h3>${bookedRoomsCount}</h3>
        <span>Booked Rooms</span>
      </div>
    </div>

    <section class="section">
      <c:if test="${not empty errorMessage}">
        <div class="alert"><c:out value="${errorMessage}" /></div>
      </c:if>
      <div class="section-grid">
        <div class="panel">
          <h4>Availability Details</h4>
          <form method="post" action="${pageContext.request.contextPath}/rooms/availability/save" autocomplete="off">
            <input type="hidden" name="id" value="<c:out value='${availabilityForm.id}'/>" />
            <div class="form-row">
              <div class="field">
                <label for="room-number">Room number</label>
                <input class="input" id="room-number" name="roomNumber" type="text" required value="<c:out value='${availabilityForm.roomNumber}'/>" />
              </div>
            </div>
            <div class="form-row">
              <div class="field">
                <label for="availability-status">Status</label>
                <select class="select" id="availability-status" name="availabilityStatus">
                  <option value="Available" <c:if test="${availabilityForm.availabilityStatus == 'Available'}">selected</c:if>>Available</option>
                  <option value="Booked" <c:if test="${availabilityForm.availabilityStatus == 'Booked'}">selected</c:if>>Booked</option>
                  <option value="Maintenance" <c:if test="${availabilityForm.availabilityStatus == 'Maintenance'}">selected</c:if>>Maintenance</option>
                </select>
              </div>
            </div>
            <div class="field">
              <label for="notes">Notes</label>
              <textarea id="notes" name="notes"><c:out value="${availabilityForm.notes}" /></textarea>
            </div>
            <div class="header-actions">
              <button class="btn" type="submit">Save Availability</button>
              <a class="btn-link" href="${pageContext.request.contextPath}/rooms/availability">
                <button class="btn btn-secondary" type="button">Clear Form</button>
              </a>
            </div>
          </form>
        </div>

        <div class="panel">
          <h4>Availability List</h4>
          <table class="table">
            <thead>
              <tr>
                <th>Room</th>
                <th>Status</th>
                <th>Notes</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="availability" items="${availabilityList}">
                <tr>
                  <td><c:out value="${availability.roomNumber}" /></td>
                  <td><c:out value="${availability.availabilityStatus}" /></td>
                  <td><c:out value="${availability.notes}" /></td>
                  <td>
                    <div class="inline-actions">
                      <form class="inline-form" method="get" action="${pageContext.request.contextPath}/rooms/availability">
                        <input type="hidden" name="editId" value="<c:out value='${availability.id}'/>" />
                        <button class="btn btn-secondary" type="submit">Edit</button>
                      </form>
                      <form class="inline-form" method="post" action="${pageContext.request.contextPath}/rooms/availability/delete">
                        <input type="hidden" name="id" value="<c:out value='${availability.id}'/>" />
                        <button class="btn btn-danger" type="submit">Delete</button>
                      </form>
                    </div>
                  </td>
                </tr>
              </c:forEach>
              <c:if test="${empty availabilityList}">
                <tr>
                  <td colspan="5">No availability records yet.</td>
                </tr>
              </c:if>
            </tbody>
          </table>
        </div>
      </div>
    </section>
  </main>
</body>
</html>
