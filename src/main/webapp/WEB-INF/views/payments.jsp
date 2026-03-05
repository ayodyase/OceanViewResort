<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Ocean View Resort - Payments</title>
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
    @media print {
      header,
      .panel form,
      .inline-actions,
      .header-actions {
        display: none !important;
      }
      body {
        background: #fff;
      }
      .section {
        box-shadow: none;
        border: none;
      }
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
    <h2>Billing &amp; Payments</h2>

    <section class="section">
      <c:if test="${not empty errorMessage}">
        <div class="alert"><c:out value="${errorMessage}" /></div>
      </c:if>
      <div class="section-grid">
        <div class="panel">
          <h4>Payment Details</h4>
          <form method="post" action="${pageContext.request.contextPath}/payments/save" autocomplete="off">
            <input type="hidden" name="id" value="<c:out value='${paymentForm.id}'/>" />
            <div class="form-row">
              <div class="field">
                <label for="booking-reference">Billing Reference</label>
                  <input class="input" id="booking-reference" name="bookingReference" type="text" required value="<c:out value='${paymentForm.bookingReference}'/>" <c:if test="${!canEdit}">disabled</c:if> />
              </div>
              <div class="field">
                <label for="guest-name">Guest name</label>
                  <input class="input" id="guest-name" name="guestName" type="text" required value="<c:out value='${paymentForm.guestName}'/>" <c:if test="${!canEdit}">disabled</c:if> />
              </div>
            </div>
            <div class="form-row">
              <div class="field">
                <label for="amount">Amount</label>
                  <input class="input" id="amount" name="amount" type="number" min="0.01" step="0.01" required value="<c:out value='${paymentForm.amount}'/>" <c:if test="${!canEdit}">disabled</c:if> />
              </div>
              <div class="field">
                <label for="method">Method</label>
                  <select class="select" id="method" name="method" <c:if test="${!canEdit}">disabled</c:if>>
                  <option value="Cash" <c:if test="${paymentForm.method == 'Cash'}">selected</c:if>>Cash</option>
                  <option value="Card" <c:if test="${paymentForm.method == 'Card'}">selected</c:if>>Card</option>
                  <option value="Bank Transfer" <c:if test="${paymentForm.method == 'Bank Transfer'}">selected</c:if>>Bank Transfer</option>
                </select>
              </div>
            </div>
            <div class="form-row">
              <div class="field">
                <label for="payment-date">Payment date</label>
                  <input class="input" id="payment-date" name="paymentDate" type="date" required value="<c:out value='${paymentForm.paymentDate}'/>" <c:if test="${!canEdit}">disabled</c:if> />
              </div>
              <div class="field">
                <label for="status">Status</label>
                  <select class="select" id="status" name="status" <c:if test="${!canEdit}">disabled</c:if>>
                  <option value="Paid" <c:if test="${paymentForm.status == 'Paid'}">selected</c:if>>Paid</option>
                  <option value="Pending" <c:if test="${paymentForm.status == 'Pending'}">selected</c:if>>Pending</option>
                  <option value="Failed" <c:if test="${paymentForm.status == 'Failed'}">selected</c:if>>Failed</option>
                </select>
              </div>
            </div>
            <c:if test="${canEdit}">
              <div class="header-actions">
                <button class="btn" type="submit">Save Payment</button>
                <a class="btn-link" href="${pageContext.request.contextPath}/payments">
                  <button class="btn btn-secondary" type="button">Clear Form</button>
                </a>
              </div>
            </c:if>
          </form>
        </div>

        <div class="panel">
          <h4>Payment List</h4>
          <table class="table">
            <thead>
              <tr>
                <th>Booking</th>
                <th>Guest</th>
                <th>Amount</th>
                <th>Method</th>
                <th>Status</th>
                  <c:if test="${canEdit || canPrint}">
                    <th>Actions</th>
                  </c:if>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="payment" items="${paymentList}">
                <tr data-date="<c:out value='${payment.paymentDate}'/>">
                  <td><c:out value="${payment.bookingReference}" /></td>
                  <td><c:out value="${payment.guestName}" /></td>
                  <td><c:out value="${payment.amount}" /></td>
                  <td><c:out value="${payment.method}" /></td>
                  <td><c:out value="${payment.status}" /></td>
                    <c:if test="${canEdit || canPrint}">
                      <td>
                        <div class="inline-actions">
                          <c:if test="${canEdit}">
                            <form class="inline-form" method="get" action="${pageContext.request.contextPath}/payments">
                              <input type="hidden" name="editId" value="<c:out value='${payment.id}'/>" />
                              <button class="btn btn-secondary" type="submit">Edit</button>
                            </form>
                            <form class="inline-form" method="post" action="${pageContext.request.contextPath}/payments/delete">
                              <input type="hidden" name="id" value="<c:out value='${payment.id}'/>" />
                              <button class="btn btn-danger" type="submit">Delete</button>
                            </form>
                          </c:if>
                          <button class="btn print-btn" type="button" data-print="payment">
                            Print
                          </button>
                        </div>
                      </td>
                    </c:if>
                </tr>
              </c:forEach>
              <c:if test="${empty paymentList}">
                  <tr>
                    <c:choose>
                      <c:when test="${canEdit || canPrint}">
                        <td colspan="6">No payments yet.</td>
                      </c:when>
                      <c:otherwise>
                        <td colspan="5">No payments yet.</td>
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
  <script src="${pageContext.request.contextPath}/assets/print-payment.js"></script>
</body>
</html>
