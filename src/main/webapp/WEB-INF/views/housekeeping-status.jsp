<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Ocean View Resort - Housekeeping Status</title>
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
    .subtext {
      margin: 6px 0 0;
      color: var(--muted);
      font-size: 14px;
    }
    .section {
      margin-top: 24px;
      background: #ffffffcc;
      border: 1px solid #e5e7eb;
      border-radius: 24px;
      padding: 24px;
      box-shadow: 0 20px 50px rgba(15, 23, 42, 0.08);
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
    .select {
      width: 100%;
      border: 1px solid #d9dee7;
      border-radius: 10px;
      padding: 10px 12px;
      font-size: 13px;
      outline: none;
      background: #f9fbff;
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
          <span>Administration Panel - Housekeeping</span>
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
    <h2>Housekeeping Status</h2>
    <p class="subtext">Track housekeepers, ratings, working hours, and availability.</p>

    <section class="section">
      <c:if test="${not empty errorMessage}">
        <div class="alert"><c:out value="${errorMessage}" /></div>
      </c:if>
      <div class="section-grid">
        <div class="panel">
          <h4>Housekeeping Details</h4>
          <form method="post" action="${pageContext.request.contextPath}/rooms/housekeeping/save" autocomplete="off">
            <input type="hidden" name="id" value="<c:out value='${housekeepingForm.id}'/>" />
            <div class="form-row">
              <div class="field">
                <label for="housekeeper-name">Housekeeper name</label>
                <input class="input" id="housekeeper-name" name="housekeeperName" type="text" required value="<c:out value='${housekeepingForm.housekeeperName}'/>" />
              </div>
              <div class="field">
                <label for="assigned-room">Assigned room</label>
                <input class="input" id="assigned-room" name="assignedRoom" type="text" value="<c:out value='${housekeepingForm.assignedRoom}'/>" />
              </div>
            </div>
            <div class="form-row">
              <div class="field">
                <label for="rating">Customer rating</label>
                <input class="input" id="rating" name="customerRating" type="number" min="1" max="5" step="0.1" required value="<c:out value='${housekeepingForm.customerRating}'/>" />
              </div>
              <div class="field">
                <label for="availability-status">Availability</label>
                <select class="select" id="availability-status" name="availabilityStatus">
                  <option value="Available" <c:if test="${housekeepingForm.availabilityStatus == 'Available'}">selected</c:if>>Available</option>
                  <option value="On Duty" <c:if test="${housekeepingForm.availabilityStatus == 'On Duty'}">selected</c:if>>On Duty</option>
                  <option value="Off Duty" <c:if test="${housekeepingForm.availabilityStatus == 'Off Duty'}">selected</c:if>>Off Duty</option>
                </select>
              </div>
            </div>
            <div class="form-row">
              <div class="field">
                <label for="hours-start">Hours start</label>
                <input class="input" id="hours-start" name="hoursStart" type="time" required value="<c:out value='${housekeepingForm.hoursStart}'/>" />
              </div>
              <div class="field">
                <label for="hours-end">Hours end</label>
                <input class="input" id="hours-end" name="hoursEnd" type="time" required value="<c:out value='${housekeepingForm.hoursEnd}'/>" />
              </div>
            </div>
            <div class="header-actions">
              <button class="btn" type="submit">Save Housekeeping</button>
              <a class="btn-link" href="${pageContext.request.contextPath}/rooms/housekeeping">
                <button class="btn btn-secondary" type="button">Clear Form</button>
              </a>
            </div>
          </form>
        </div>

        <div class="panel">
          <h4>Housekeeping List</h4>
          <table class="table">
            <thead>
              <tr>
                <th>Housekeeper</th>
                <th>Rating</th>
                <th>Hours</th>
                <th>Availability</th>
                <th>Assigned</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="hk" items="${housekeepingList}">
                <tr>
                  <td><c:out value="${hk.housekeeperName}" /></td>
                  <td><c:out value="${hk.customerRating}" /></td>
                  <td><c:out value="${hk.hoursStart}" /> - <c:out value="${hk.hoursEnd}" /></td>
                  <td><c:out value="${hk.availabilityStatus}" /></td>
                  <td><c:out value="${hk.assignedRoom}" /></td>
                  <td>
                    <div class="inline-actions">
                      <form class="inline-form" method="get" action="${pageContext.request.contextPath}/rooms/housekeeping">
                        <input type="hidden" name="editId" value="<c:out value='${hk.id}'/>" />
                        <button class="btn btn-secondary" type="submit">Edit</button>
                      </form>
                      <form class="inline-form" method="post" action="${pageContext.request.contextPath}/rooms/housekeeping/delete">
                        <input type="hidden" name="id" value="<c:out value='${hk.id}'/>" />
                        <button class="btn btn-danger" type="submit">Delete</button>
                      </form>
                    </div>
                  </td>
                </tr>
              </c:forEach>
              <c:if test="${empty housekeepingList}">
                <tr>
                  <td colspan="6">No housekeeping records yet.</td>
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
