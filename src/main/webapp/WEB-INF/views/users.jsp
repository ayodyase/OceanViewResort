<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Ocean View Resort - Users Management</title>
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
    .section-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 18px;
      flex-wrap: wrap;
    }
    .section-header h3 {
      margin: 0;
      font-size: 20px;
    }
    .section-header span {
      color: var(--muted);
      font-size: 13px;
    }
    .actions {
      display: flex;
      gap: 10px;
      flex-wrap: wrap;
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
    .select {
      width: 100%;
      border: 1px solid #d9dee7;
      border-radius: 10px;
      padding: 10px 12px;
      font-size: 13px;
      outline: none;
      background: #f9fbff;
    }
    .input:focus,
    .select:focus {
      border-color: var(--primary);
      box-shadow: 0 0 0 3px rgba(15, 76, 129, 0.12);
    }
    .toggle-group {
      display: flex;
      align-items: center;
      gap: 12px;
      margin-top: 6px;
    }
    .toggle {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 6px 10px;
      border-radius: 999px;
      background: #eef4ff;
      font-size: 12px;
      color: var(--primary);
      font-weight: 600;
      cursor: pointer;
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
    .status {
      display: inline-flex;
      align-items: center;
      padding: 4px 10px;
      border-radius: 999px;
      font-size: 11px;
      font-weight: 600;
    }
    .status.active {
      background: #e6f7ef;
      color: #0f7a4d;
    }
    .status.inactive {
      background: #fff0f0;
      color: #bf3030;
    }
    .inline-actions {
      display: flex;
      gap: 8px;
      align-items: center;
      flex-wrap: wrap;
    }
    .inline-actions .btn {
      padding: 6px 10px;
      font-size: 12px;
    }
    .inline-input {
      width: 140px;
      padding: 6px 8px;
      font-size: 12px;
      border-radius: 10px;
      border: 1px solid #d9dee7;
      background: #f9fbff;
    }
    .inline-form {
      display: inline-block;
      margin: 0;
    }
    .helper {
      margin-top: 12px;
      font-size: 12px;
      color: var(--muted);
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
          <a class="btn-link" href="${pageContext.request.contextPath}/admin">
            <button class="btn btn-secondary" type="button">Back to Admin</button>
          </a>
          <c:if test="${canEdit}">
            <a class="btn-link" href="${pageContext.request.contextPath}/users">
              <button class="btn" type="button">Add New Staff</button>
            </a>
          </c:if>
        </div>
    </div>
  </header>

  <main>
    <h2>Staff Management</h2>

    <section class="section" aria-labelledby="users-section-title">
        <div class="section-header">
          <div>
            <h3 id="users-section-title">Staff Profiles</h3>
          </div>
          <c:if test="${canEdit}">
            <div class="actions">
              <a class="btn-link" href="${pageContext.request.contextPath}/users">
                <button class="btn btn-secondary" type="button">Manage Staff</button>
              </a>
            </div>
          </c:if>
      </div>


      <div class="section-grid">
        <div class="panel">
          <h4>Staff Details</h4>
          <c:if test="${not empty successMessage}">
            <p class="helper" style="color:#0f7a4d;"><c:out value="${successMessage}" /></p>
          </c:if>
          <c:if test="${not empty errorMessage}">
            <p class="helper" style="color:#bf3030;"><c:out value="${errorMessage}" /></p>
          </c:if>
          <form method="post" action="${pageContext.request.contextPath}/users/save" autocomplete="off">
            <input type="hidden" name="id" value="<c:out value='${staffForm.id}'/>" />
            <div class="form-row">
              <div class="field">
                <label for="staff-name">Full name</label>
                <input class="input" id="staff-name" name="name" type="text" required value="<c:out value='${staffForm.name}'/>" />
              </div>
              <div class="field">
                <label for="staff-email">Email</label>
                <input class="input" id="staff-email" name="email" type="email" required value="<c:out value='${staffForm.email}'/>" />
              </div>
            </div>
            <div class="form-row">
              <div class="field">
                <label for="staff-gender">Gender</label>
                <select class="select" id="staff-gender" name="gender">
                  <option value="Male" <c:if test="${staffForm.gender == 'Male'}">selected</c:if>>Male</option>
                  <option value="Female" <c:if test="${staffForm.gender == 'Female'}">selected</c:if>>Female</option>
                  <option value="Other" <c:if test="${staffForm.gender == 'Other'}">selected</c:if>>Other</option>
                </select>
              </div>
              <div class="field">
                <label for="staff-nic">NIC</label>
                <input class="input" id="staff-nic" name="nic" type="text" value="<c:out value='${staffForm.nic}'/>" />
              </div>
            </div>
              <div class="form-row">
                <div class="field">
                  <label for="staff-employee">Employee ID</label>
                  <input class="input" id="staff-employee" name="employeeId" type="text" required value="<c:out value='${staffForm.employeeId}'/>" <c:if test="${!canEdit}">disabled</c:if> />
                </div>
                <div class="field">
                  <label for="staff-password">Password</label>
                  <input class="input" id="staff-password" name="password" type="password" autocomplete="new-password" <c:if test="${!canEdit}">disabled</c:if> />
                </div>
                <div class="field">
                  <label for="staff-role">Role</label>
                  <select class="select" id="staff-role" name="role" <c:if test="${!canEdit}">disabled</c:if>>
                  <option value="Front Desk" <c:if test="${staffForm.role == 'Front Desk'}">selected</c:if>>Front Desk</option>
                  <option value="Housekeeping" <c:if test="${staffForm.role == 'Housekeeping'}">selected</c:if>>Housekeeping</option>
                  <option value="Maintenance" <c:if test="${staffForm.role == 'Maintenance'}">selected</c:if>>Maintenance</option>
                  <option value="IT Executive" <c:if test="${staffForm.role == 'IT Executive'}">selected</c:if>>IT Executive</option>
                  <option value="Manager" <c:if test="${staffForm.role == 'Manager'}">selected</c:if>>Manager</option>
                </select>
              </div>
            </div>
            <div class="form-row">
              <div class="field">
                <label for="shift-start">Working hours start</label>
                  <input class="input" id="shift-start" name="hoursStart" type="time" required value="<c:out value='${staffForm.hoursStart}'/>" <c:if test="${!canEdit}">disabled</c:if> />
                </div>
                <div class="field">
                  <label for="shift-end">Working hours end</label>
                  <input class="input" id="shift-end" name="hoursEnd" type="time" required value="<c:out value='${staffForm.hoursEnd}'/>" <c:if test="${!canEdit}">disabled</c:if> />
                </div>
              </div>
            <div class="field">
              <label>Activation status</label>
              <div class="toggle-group">
                  <label class="toggle">
                    <input type="radio" name="status" value="Active" <c:if test="${staffForm.status == null || staffForm.status == 'Active'}">checked</c:if> <c:if test="${!canEdit}">disabled</c:if> />
                    Active
                  </label>
                  <label class="toggle">
                    <input type="radio" name="status" value="Inactive" <c:if test="${staffForm.status == 'Inactive'}">checked</c:if> <c:if test="${!canEdit}">disabled</c:if> />
                    Inactive
                  </label>
                </div>
              </div>
              <c:if test="${canEdit}">
                <div class="actions">
                  <button class="btn" type="submit">Save Staff</button>
                  <a class="btn-link" href="${pageContext.request.contextPath}/users">
                    <button class="btn btn-secondary" type="button">Clear Form</button>
                  </a>
                </div>
              </c:if>
            </form>
          <p class="helper">Select a staff member to edit or delete, or add a new staff entry.</p>
        </div>

        <div class="panel">
          <h4>Staff Directory</h4>
          <table class="table">
            <thead>
              <tr>
                <th>Staff</th>
                <th>Role</th>
                <th>Working hours</th>
                <th>Status</th>
                  <c:if test="${canEdit}">
                    <th>Actions</th>
                  </c:if>
                </tr>
              </thead>
              <tbody>
              <c:forEach var="staff" items="${staffList}">
                <tr>
                  <td>
                    <strong><c:out value="${staff.name}" /></strong><br />
                    <span class="subtext"><c:out value="${staff.employeeId}" /></span>
                  </td>
                  <td><c:out value="${staff.role}" /></td>
                  <td><c:out value="${staff.hoursStart}" /> - <c:out value="${staff.hoursEnd}" /></td>
                  <td>
                    <c:choose>
                      <c:when test="${staff.status == 'Active'}">
                        <span class="status active">Active</span>
                      </c:when>
                      <c:otherwise>
                        <span class="status inactive">Inactive</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                    <c:if test="${canEdit}">
                      <td>
                        <div class="inline-actions">
                          <form class="inline-form" method="get" action="${pageContext.request.contextPath}/users">
                            <input type="hidden" name="editId" value="<c:out value='${staff.id}'/>" />
                            <button class="btn btn-secondary" type="submit">Edit</button>
                          </form>
                          <form class="inline-form" method="post" action="${pageContext.request.contextPath}/users/delete">
                            <input type="hidden" name="id" value="<c:out value='${staff.id}'/>" />
                            <button class="btn btn-danger" type="submit">Delete</button>
                          </form>
                          <form class="inline-form" method="post" action="${pageContext.request.contextPath}/users/reset-password">
                            <input type="hidden" name="id" value="<c:out value='${staff.id}'/>" />
                            <input class="inline-input" type="password" name="newPassword" placeholder="New password" />
                            <button class="btn btn-secondary" type="submit">Reset Password</button>
                          </form>
                        </div>
                      </td>
                    </c:if>
                  </tr>
              </c:forEach>
              <c:if test="${empty staffList}">
                  <tr>
                    <c:choose>
                      <c:when test="${canEdit}">
                        <td colspan="5">No staff records yet.</td>
                      </c:when>
                      <c:otherwise>
                        <td colspan="4">No staff records yet.</td>
                      </c:otherwise>
                    </c:choose>
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
