<template>

    <!-- Hidden Checkbox -->
    <input type="checkbox" id="sidebar-toggle" class="d-none" />

    <nav class="navbar topbar-bg p-2">
        <div class="container-fluid d-flex align-items-center flex-nowrap">

            <!-- Mobile Sidebar Toggle -->
            <label for="sidebar-toggle" class="cursor-pointer d-sm-none me-2">
                <i class="fa-solid fa-bars-staggered fa-lg text-light"></i>
            </label>

            <!-- Quick Navigation (Hidden on Mobile) -->
            <ul class="nav gap-3 d-none d-sm-flex">

                <li class="nav-item">
                    <router-link to="/customer/dashboard" class="nav-link text-light fw-semibold">
                        <i class="fa-solid fa-home-lg-alt me-1"></i> Dashboard
                    </router-link>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-light fw-semibold" data-bs-toggle="dropdown">
                        <i class="fa-solid fa-wallet me-1"></i> Accounts
                    </a>
                    <ul class="dropdown-menu">
                        <li><router-link class="dropdown-item" to="/customer/accounts">My Accounts</router-link></li>
                        <li><router-link class="dropdown-item" to="/customer/statement">Download Statement</router-link>
                        </li>
                        <li><router-link class="dropdown-item" to="/customer/balance">Balance Inquiry</router-link></li>
                    </ul>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-light fw-semibold" data-bs-toggle="dropdown">
                        <i class="fa-solid fa-arrow-right-arrow-left me-1"></i> Transfers
                    </a>
                    <ul class="dropdown-menu">
                        <li><router-link class="dropdown-item" to="/customer/transfer">Fund Transfer</router-link></li>
                        <li><router-link class="dropdown-item" to="/customer/beneficiary">Beneficiaries</router-link>
                        </li>
                        <li><router-link class="dropdown-item" to="/customer/transfer-history">Transfer
                                History</router-link></li>
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

            <!-- Right Section -->
            <div class="top-right d-flex align-items-center gap-4 ms-auto">

                <div class="position-relative cursor-pointer">
                    <i class="fa-solid fa-bell fa-lg text-light"></i>
                    <span class="badge bg-danger notify-badge">3</span>
                </div>

                <div class="dropdown">
                    <a class="d-flex align-items-center gap-2 dropdown-toggle" data-bs-toggle="dropdown">
                        <img src="/assets/img/custom_icon/man1.png" class="rounded-circle" width="36" height="36" />
                        <span class="fw-semibold d-none d-sm-inline text-light">Customer</span>
                    </a>

                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><router-link class="dropdown-item" to="/customer/profile">My Profile</router-link></li>
                        <li><router-link class="dropdown-item" to="/customer/settings">Settings</router-link></li>
                        <li>
                            <hr class="dropdown-divider" />
                        </li>
                        <li><button class="dropdown-item" @click="handleLogOut">Logout</button></li>
                    </ul>
                </div>

            </div>

        </div>
    </nav>

    <router-view/>

    <!-- MOBILE SIDEBAR -->
    <aside class="mobile-sidebar">

        <div class="sidebar-content">
            <label for="sidebar-toggle" class="close-btn">
                <i class="fa-solid fa-xmark"></i>
            </label>

            <router-link to="/customer/dashboard" class="side-item">Dashboard</router-link>
            <router-link to="/customer/accounts" class="side-item">My Accounts</router-link>
            <router-link to="/customer/transfer" class="side-item">Fund Transfer</router-link>
            <router-link to="/customer/apply-loan" class="side-item">Apply Loan</router-link>
            <router-link to="/customer/profile" class="side-item">Profile</router-link>

            <button class="btn btn-danger w-100 mt-3" @click="handleLogOut">Logout</button>
        </div>

    </aside>

</template>

<script setup lang="ts">
import { useAuthStore } from "@/store/auth";

const auth = useAuthStore();
function handleLogOut() {
    auth.logout();
}
</script>

<style scoped>
.top-right{
    right: -1.5rem !important;

}
.topbar-bg {
    background-color: #1d3557;
    color: #fff;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.notify-badge {
    position: absolute;
    top: -5px;
    right: -6px;
    font-size: 10px;
    padding: 3px 5px;
}

/* -------------------------
   MOBILE SIDEBAR (checkbox)
-------------------------- */

.mobile-sidebar {
    position: fixed;
    top: 0;
    left: -260px;
    width: 160px;
    height: 100vh;
    background: #0b1b33;
    padding: 20px;
    transition: 0.3s ease-in-out;
    z-index: 9999;
}

/* checkbox hack */
#sidebar-toggle:checked~.mobile-sidebar {
    left: 0;
}

.sidebar-content {
    display: flex;
    flex-direction: column;
}

.side-item {
    padding: 14px 0;
    font-size: 17px;
    color: #ddd;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    text-decoration: none;
}

.side-item:hover {
    color: #fff;
}

.close-btn {
    font-size: 24px;
    color: #fff;
    cursor: pointer;
    text-align: right;
    display: block;
    margin-bottom: 20px;
}

/* -------------------------
   TABLET / RESPONSIVE
-------------------------- */
@media (max-width: 992px) {
    .navbar {
        padding: 8px 12px !important;
    }
    .nav-link{
        padding: 1px 1px !important;
    }
}

@media (max-width: 768px) {
    .navbar {
        padding: 6px 8px !important;
    }
    .nav-link{
        padding: 2px 6px !important;
    }

    .top-right {
        gap: .7rem;
    }
}

@media (max-width: 576px) {
    .profile-name {
        display: none;
    }
}
</style>
