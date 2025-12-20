<template>
    <input type="checkbox" id="sidebar-toggle" class="d-none" />

    <nav class="navbar topbar-bg sticky-top p-2 shadow-sm">
        <div class="container-fluid d-flex align-items-center flex-nowrap px-lg-4">

            <label for="sidebar-toggle" class="cursor-pointer d-sm-none me-3">
                <i class="fa-solid fa-bars-staggered fa-lg text-light"></i>
            </label>

            <div class="navbar-brand fw-bold text-light d-flex align-items-center me-4">
                <i class="fa-solid fa-building-columns me-2 text-warning"></i>
                <span class=" d-md-block">BD BANK</span>
            </div>

            <ul class="nav gap-2 d-none d-sm-flex align-items-center">
                <li class="nav-item">
                    <router-link to="/customer/dashboard" class="nav-link custom-nav-link text-light">
                        Dashboard
                    </router-link>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle custom-nav-link text-light" data-bs-toggle="dropdown" href="#">
                        Accounts
                    </a>
                    <ul class="dropdown-menu shadow-lg border-0">
                        <li><router-link class="dropdown-item py-2" to="/customer/accounts"><i
                                    class="fas fa-list me-2"></i>My Accounts</router-link></li>
                        <li><router-link class="dropdown-item py-2" to="/customer/statement"><i
                                    class="fas fa-file-pdf me-2"></i>Statements</router-link></li>
                    </ul>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle custom-nav-link text-light" data-bs-toggle="dropdown" href="#">
                        Transfers
                    </a>
                    <ul class="dropdown-menu shadow-lg border-0">
                        <li><router-link class="dropdown-item py-2" to="/customer/transfer"><i
                                    class="fas fa-paper-plane me-2"></i>Fund Transfer</router-link></li>
                        <li><router-link class="dropdown-item py-2" to="/customer/history"><i
                                    class="fas fa-history me-2"></i>History</router-link></li>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-light fw-semibold" data-bs-toggle="dropdown">
                        <i class="fa-solid fa-hand-holding-dollar me-1"></i> Loans
                    </a>
                    <ul class="dropdown-menu">
                        <li><router-link class="dropdown-item" to="/customer/apply-loan">Apply Loan</router-link></li>
                        <li><router-link class="dropdown-item" to="/customer/my-loans">My Loans</router-link></li>
                        <li><router-link class="dropdown-item" to="/customer/emi">EMI Schedule</router-link></li>
                    </ul>
                </li>
            </ul>

            <div class="top-right d-flex align-items-center gap-3 ms-auto">
                <div class="position-relative cursor-pointer notification-icon d-none d-md-block">
                    <i class="fa-solid fa-bell fa-lg text-light opacity-75"></i>
                    <span class="badge rounded-pill bg-danger notify-badge">3</span>
                </div>

                <div class="dropdown">
                    <a class="d-flex align-items-center gap-2 dropdown-toggle text-decoration-none"
                        data-bs-toggle="dropdown">
                        <!-- <div class="avatar-box bg-warning text-navy fw-bold">C</div> -->
                        <img src="/assets/img/custom_icon/man1.png" class="rounded-circle" width="36" height="36" />
                        <span class="fw-semibold d-none d-lg-inline text-light">{{ auth?.user?.name ?? "Customer" }}</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0">
                        <li class="px-3 py-2 border-bottom">
                            <small class="text-muted d-block">Logged in as</small>
                            <span class="fw-bold">cust_1005</span>
                        </li>
                        <li><router-link class="dropdown-item mt-1" to="/customer/profile">My Profile</router-link></li>
                        <li><router-link class="dropdown-item" to="/customer/settings">Security Settings</router-link>
                        </li>
                        <li>
                            <hr class="dropdown-divider" />
                        </li>
                        <li><button class="dropdown-item text-danger fw-bold" @click="handleLogOut">Logout</button></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

    <main class="main-content-area">
        <router-view />
    </main>
    <div class="mobile-sidebar-overlay" @click="closeSidebar"></div>
    <aside class="mobile-sidebar shadow">
        <div
            class="sidebar-header border-bottom p-3 d-flex justify-content-between align-items-center bg-navy text-white">
            <span class="fw-bold"><i class="fas fa-university me-2"></i>Nexus Bank</span>
            <label for="sidebar-toggle" class="close-btn"><i class="fa-solid fa-xmark"></i></label>
        </div>
        <div class="sidebar-content p-3">
            <router-link to="/customer/dashboard" class="side-item"><i
                    class="fas fa-home me-3"></i>Dashboard</router-link>
            <router-link to="/customer/accounts" class="side-item"><i class="fas fa-wallet me-3"></i>My
                Accounts</router-link>
            <router-link to="/customer/transfer" class="side-item"><i class="fas fa-exchange-alt me-3"></i>Fund
                Transfer</router-link>
            <router-link to="/customer/apply-loan" class="side-item"><i class="fas fa-hand-holding-usd me-3"></i>Apply
                Loan</router-link>
            <router-link to="/customer/profile" class="side-item"><i
                    class="fas fa-user-circle me-3"></i>Profile</router-link>
            <button class="btn btn-danger w-100 mt-4 py-2" @click="handleLogOut">Logout</button>
        </div>
    </aside>
</template>

<script setup lang="ts">
import { useAuthStore } from "@/store/auth";

const auth = useAuthStore();
function handleLogOut() {
    auth.logout();
}
// Helper to close sidebar when clicking overlay
function closeSidebar() {
    const checkbox = document.getElementById('sidebar-toggle') as HTMLInputElement;
    if (checkbox) checkbox.checked = false;
}
</script>

<style scoped>
.topbar-bg {
    background-color: #1a237e;
    /* Navy Blue for Banking */
    border-bottom: 3px solid #ffd600;
    /* Subtle Gold line */
}

.custom-nav-link {
    font-size: 14px;
    font-weight: 500;
    padding: 8px 15px !important;
    border-radius: 6px;
    transition: all 0.3s;
}

.custom-nav-link:hover {
    background: rgba(255, 255, 255, 0.1);
}

.avatar-box {
    width: 34px;
    height: 34px;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
}

.notify-badge {
    position: absolute;
    top: -3px;
    right: -5px;
    font-size: 9px;
    padding: 2px 4px;
}

/* -------------------------
   MOBILE SIDEBAR FIXES
-------------------------- */
.mobile-sidebar {
    position: fixed;
    top: 0;
    left: -280px;
    width: 280px;
    height: 100vh;
    background: #ffffff;
    transition: 0.3s ease-in-out;
    z-index: 9999;
}

#sidebar-toggle:checked~.mobile-sidebar {
    left: 0;
}

#sidebar-toggle:checked~.mobile-sidebar-overlay {
    display: block;
}

.mobile-sidebar-overlay {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    z-index: 9998;
}

.side-item {
    display: flex;
    align-items: center;
    padding: 12px 15px;
    color: #333;
    text-decoration: none;
    border-radius: 8px;
    margin-bottom: 5px;
    font-weight: 500;
}

.side-item:hover,
.router-link-active {
    background: #3b76ce;
    color: #1a237e;
}

.bg-navy {
    background-color: #1a237e;
}

.main-content-area {
    background-color: #f8f9fa;
    min-height: calc(100vh - 60px);
}
</style>