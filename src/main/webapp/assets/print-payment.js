document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll("button[data-print='payment']").forEach(function (button) {
    button.addEventListener("click", function () {
      const row = button.closest("tr");
      const cells = row ? row.querySelectorAll("td") : [];
      const reference = cells[0] ? cells[0].textContent.trim() : "";
      const guest = cells[1] ? cells[1].textContent.trim() : "";
      const amount = cells[2] ? cells[2].textContent.trim() : "";
      const method = cells[3] ? cells[3].textContent.trim() : "";
      const status = cells[4] ? cells[4].textContent.trim() : "";
      const date = row && row.dataset ? row.dataset.date : "";

      const iframe = document.createElement("iframe");
      iframe.style.position = "fixed";
      iframe.style.right = "0";
      iframe.style.bottom = "0";
      iframe.style.width = "0";
      iframe.style.height = "0";
      iframe.style.border = "0";
      document.body.appendChild(iframe);

      const win = iframe.contentWindow;
      if (!win) {
        iframe.remove();
        return;
      }

      const html =
        "<!DOCTYPE html>" +
        "<html lang='en'>" +
        "<head>" +
        "<meta charset='UTF-8' />" +
        "<title>Payment Receipt</title>" +
        "<style>" +
        "body { font-family: 'Segoe UI', Arial, sans-serif; padding: 24px; color: #1f2937; }" +
        "h1 { font-size: 20px; margin: 0 0 12px; }" +
        "table { width: 100%; border-collapse: collapse; margin-top: 12px; }" +
        "td { padding: 8px 6px; border-bottom: 1px solid #e5e7eb; }" +
        ".label { color: #6b7280; width: 160px; }" +
        "</style>" +
        "</head>" +
        "<body>" +
        "<h1>Ocean View Resort - Payment Receipt</h1>" +
        "<table>" +
        "<tr><td class='label'>Billing Reference</td><td>" + reference + "</td></tr>" +
        "<tr><td class='label'>Guest Name</td><td>" + guest + "</td></tr>" +
        "<tr><td class='label'>Amount</td><td>" + amount + "</td></tr>" +
        "<tr><td class='label'>Method</td><td>" + method + "</td></tr>" +
        "<tr><td class='label'>Payment Date</td><td>" + date + "</td></tr>" +
        "<tr><td class='label'>Status</td><td>" + status + "</td></tr>" +
        "</table>" +
        "</body>" +
        "</html>";

      win.document.open();
      win.document.write(html);
      win.document.close();
      setTimeout(function () {
        win.focus();
        win.print();
        setTimeout(function () {
          iframe.remove();
        }, 1000);
      }, 200);
    });
  });
});
