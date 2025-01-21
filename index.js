// Add Event Listener when DOM is Loaded
document.addEventListener("DOMContentLoaded", function () {
    updateVisitorCount();
    addSmoothScroll();
});

// Visitor Counter (Mocked API Fetch or Local Storage)
function updateVisitorCount() {
    let count = localStorage.getItem("visitorCount") || 0;
    count = parseInt(count) + 1;
    localStorage.setItem("visitorCount", count);

    document.getElementById("visitor-counter").innerText = `Visitors: ${count}`;
}

// Smooth Scroll Function
function addSmoothScroll() {
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener("click", function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute("href"));
            target.scrollIntoView({ behavior: "smooth" });
        });
    });
}

// Toggle Dark Mode (Optional)
function toggleDarkMode() {
    document.body.classList.toggle("dark-mode");
}
