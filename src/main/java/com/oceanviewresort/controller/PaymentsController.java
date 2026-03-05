package com.oceanviewresort.controller;

import com.oceanviewresort.model.Payment;
import com.oceanviewresort.model.PaymentDao;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import com.oceanviewresort.security.AccessUtil;

@Controller
@RequestMapping("/payments")
public class PaymentsController {
    private final PaymentDao paymentDao;

    public PaymentsController(PaymentDao paymentDao) {
        this.paymentDao = paymentDao;
    }

    @GetMapping({"", "/"})
    public String paymentsPage(@RequestParam(value = "editId", required = false) Integer editId,
                               Model model,
                               HttpServletRequest request,
                               HttpServletResponse response) throws IOException {
        if (!AccessUtil.ensureLoggedIn(request, response)) {
            return null;
        }

        HttpSession session = request.getSession(false);
        model.addAttribute("canEdit", AccessUtil.canEdit(session));
        model.addAttribute("canPrint", AccessUtil.canEdit(session));

        Payment form = new Payment();
        if (editId != null) {
            Payment existing = paymentDao.findById(editId);
            if (existing != null) {
                form = existing;
            } else {
                model.addAttribute("errorMessage", "Selected payment was not found.");
            }
        }

        model.addAttribute("paymentForm", form);
        model.addAttribute("paymentList", paymentDao.findAll());
        return "payments";
    }

    @PostMapping("/save")
    public String savePayment(Payment payment,
                              Model model,
                              HttpServletRequest request,
                              HttpServletResponse response) throws IOException {
        if (!AccessUtil.ensureCanEdit(request, response)) {
            return null;
        }

        List<String> errors = validate(payment);
        if (!errors.isEmpty()) {
            model.addAttribute("paymentForm", payment);
            model.addAttribute("paymentList", paymentDao.findAll());
            model.addAttribute("errorMessage", String.join(" ", errors));
            return "payments";
        }

        if (payment.getId() == null) {
            paymentDao.create(payment);
        } else {
            paymentDao.update(payment);
        }
        return "redirect:/payments";
    }

    @PostMapping("/delete")
    public String deletePayment(@RequestParam("id") int id,
                                HttpServletRequest request,
                                HttpServletResponse response) throws IOException {
        if (!AccessUtil.ensureCanEdit(request, response)) {
            return null;
        }
        paymentDao.delete(id);
        return "redirect:/payments";
    }

    private List<String> validate(Payment payment) {
        List<String> errors = new ArrayList<>();
        if (isBlank(payment.getBookingReference())) {
            errors.add("Booking reference is required.");
        }
        if (isBlank(payment.getGuestName())) {
            errors.add("Guest name is required.");
        }
        if (payment.getAmount() == null || payment.getAmount() <= 0) {
            errors.add("Amount must be greater than 0.");
        }
        if (isBlank(payment.getMethod())) {
            errors.add("Payment method is required.");
        }
        if (isBlank(payment.getPaymentDate())) {
            errors.add("Payment date is required.");
        }
        if (isBlank(payment.getStatus())) {
            errors.add("Status is required.");
        }
        return errors;
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
