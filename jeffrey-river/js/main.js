/* Jeffrey River — site scripts */

// Mobile nav toggle
document.addEventListener("DOMContentLoaded", () => {
  const toggle = document.querySelector(".nav__toggle");
  const links = document.querySelector(".nav__links");
  if (toggle && links) {
    toggle.addEventListener("click", () => {
      links.classList.toggle("is-open");
      const expanded = links.classList.contains("is-open");
      toggle.setAttribute("aria-expanded", expanded);
    });
  }

  // Mark active nav link
  const path = window.location.pathname.split("/").pop() || "index.html";
  document.querySelectorAll(".nav__links a").forEach((a) => {
    const href = a.getAttribute("href");
    if (href === path || (path === "" && href === "index.html")) {
      a.classList.add("active");
    }
  });

  // Play button placeholder — just a visual pulse for now
  document.querySelectorAll(".player__btn").forEach((btn) => {
    btn.addEventListener("click", () => {
      btn.textContent = btn.textContent.trim() === "▶" ? "❚❚" : "▶";
    });
  });

  // Set current year in footer
  const yearEl = document.getElementById("year");
  if (yearEl) yearEl.textContent = new Date().getFullYear();

  // MailerLite signup is handled inline on each page
});
