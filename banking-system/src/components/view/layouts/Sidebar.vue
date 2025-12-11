<template>

  <!-- Mobile toggle checkbox (keeps original CSS behavior) -->
  <input type="checkbox" id="sidebar-toggle" class="d-none" />
  <label for="sidebar-toggle" class="bg-layer"></label>

  <div id="sidebar">
    <span class="fs-2 d-lg-none" id="close-btn">
      <label for="sidebar-toggle">
        <i class="fas fa-chevron-left text-light"></i>
      </label>
    </span>

    <h4 class="text-center">Admin Panel</h4>

    <div class="text-center mb-4">
      <div class="text-center mb-4">
        <img src="/assets/img/custom_icon/man3.png" class="rounded-circle" width="80" height="80" alt="Profile image" />
      </div>

      <h5 class="mt-2 mb-0">Super Admin</h5>
      <small class="text-light">Administrator</small>
    </div>

    <nav class="navbar sidebar-menu">
      <ul class="nav flex-column">

        <!-- Dashboard -->
        <li class="nav-item">
          <router-link to="/" class="nav-link text-light link-navbar active">
            <i class="fa-solid fa-grip me-2 fa-lg"></i> Dashboard
          </router-link>
        </li>

        <!-- User Manage (collapsible) -->
        <li>
          <a class="nav-link text-white dropdown-toggle" data-bs-toggle="collapse" href="#usersMenu" role="button"
            aria-expanded="false" aria-controls="usersMenu">
            <i class="fas fa-users me-2 fa-lg"></i> User Manage
          </a>
          <div class="collapse" id="usersMenu" data-bs-parent=".sidebar-menu">
            <ul class="list-unstyled ps-4">
              <li><router-link to="/users" class="nav-link text-white"><i class="fas fa-user me-2"></i> All Users</router-link></li>
              <li><router-link to="" class="nav-link text-white"><i class="fas fa-user-check me-2"></i> Customers</router-link></li>
              <li><router-link to="" class="nav-link text-white"><i class="fas fa-user-tie me-2"></i> Tellers</router-link></li>
            </ul>
          </div>
        </li>

        <!-- Banking -->
        <li>
          <a class="nav-link text-white dropdown-toggle" data-bs-toggle="collapse" href="#bankingMenu" role="button"
            aria-expanded="false" aria-controls="bankingMenu">
            <i class="fas fa-piggy-bank me-2 fa-lg"></i> Banking
          </a>
          <div class="collapse" id="bankingMenu" data-bs-parent=".sidebar-menu">
            <ul class="list-unstyled ps-4">
              <li><a href="#" class="nav-link text-white"><i class="fas fa-university me-2"></i> All Accounts</a></li>
              <li><a href="#" class="nav-link text-white"><i class="fas fa-exchange-alt me-2"></i> Transactions</a></li>
              <li><a href="#" class="nav-link text-white"><i class="fas fa-hand-holding-usd me-2"></i> Loans</a></li>
            </ul>
          </div>
        </li>

        <!-- Finance -->
        <li>
          <a class="nav-link text-white dropdown-toggle" data-bs-toggle="collapse" href="#financeMenu" role="button"
            aria-expanded="false" aria-controls="financeMenu">
            <i class="fas fa-wallet me-2 fa-lg"></i> Finance
          </a>
          <div class="collapse" id="financeMenu" data-bs-parent=".sidebar-menu" >
            <ul class="list-unstyled ps-4">
              <li><a href="#" class="nav-link text-white"><i class="fas fa-money-bill me-2"></i> Payments</a></li>
              <li><a href="#" class="nav-link text-white"><i class="fas fa-percentage me-2"></i> Commissions</a></li>
              <li><a href="#" class="nav-link text-white"><i class="fas fa-hand-holding-usd me-2"></i> Payouts</a></li>
            </ul>
          </div>
        </li>

        <!-- Reports -->
        <li>
          <a class="nav-link text-white dropdown-toggle" data-bs-toggle="collapse" href="#reportMenu" role="button"
            aria-expanded="false" aria-controls="reportMenu">
            <i class="fas fa-chart-bar me-2 fa-lg"></i> Reports
          </a>
          <div class="collapse" id="reportMenu" data-bs-parent=".sidebar-menu">
            <ul class="list-unstyled ps-4">
              <li><a href="#" class="nav-link text-white"><i class="fas fa-file-invoice-dollar me-2"></i> Sales
                  Report</a></li>
              <li><a href="#" class="nav-link text-white"><i class="fas fa-store me-2"></i> Branch Report</a></li>
              <li><a href="#" class="nav-link text-white"><i class="fas fa-box me-2"></i> Account Report</a></li>
            </ul>
          </div>
        </li>

        <!-- Settings -->
        <li>
          <a class="nav-link text-white dropdown-toggle" data-bs-toggle="collapse" href="#settingMenu" role="button"
            aria-expanded="false" aria-controls="settingMenu">
            <i class="fas fa-cog me-2 fa-lg"></i> Settings
          </a>
          <div class="collapse" id="settingMenu" data-bs-parent=".sidebar-menu">
            <ul class="list-unstyled ps-4">
              <li><a href="#" class="nav-link text-white"><i class="fas fa-sliders-h me-2"></i> Site Settings</a></li>
              <li><a href="#" class="nav-link text-white"><i class="fas fa-shield-alt me-2"></i> Security</a></li>
              <li><a href="#" class="nav-link text-white"><i class="fas fa-shipping-fast me-2"></i> Shipping (if
                  any)</a></li>
            </ul>
          </div>
        </li>

        <!-- Profile & Logout -->
        <li class="nav-item">
          <a href="#" class="nav-link text-light"><i class="fas fa-user-circle me-2 fa-lg"></i> Profile</a>
        </li>

        <li class="">
          <button type="button" class="nav-link text-light">
            <i class="fas fa-sign-out-alt me-2 fa-lg"></i> Logout
          </button>
        </li>

      </ul>
    </nav>
  </div>

</template>



<style scoped>
#sidebar {
  width: 280px;
  min-height: 100vh;
  background: #2C3E50;
  color: #FFFFFF;
  padding: 20px;
  position: fixed;
  top: 0;
  left: 0;
  z-index: 2000;
  transition: all 0.3s ease-in-out;
  overflow-y: none;
  overflow-x: 250px;
}

#sidebar::-webkit-scrollbar {
  width: 6px;
}

#sidebar::-webkit-scrollbar-thumb {
  background-color: #1ABC9C;
  border-radius: 8px;
}

#sidebar::-webkit-scrollbar-track {
  background-color: #2C3E50;
}

/* === Close Button === */
#close-btn {
  position: absolute;
  left: 248px;
  top: 2px;
}

@media screen and (max-width: 769px) {
  #sidebar {
    left: -280px;
  }

  #sidebar-toggle:checked~#sidebar {
    left: 0;
  }
}

@media(max-width: 1024px) {
  #sidebar {
    left: -280px;
  }
}
@media(max-width: 1024px) {
  #sidebar {
    left: -280px !important;
  }

  #sidebar-toggle:checked~#sidebar {
    left: 0 !important;
  }

  /* overlay for tablet */
  #sidebar-toggle:checked~.bg-layer {
    position: fixed;
    top: 0;
    bottom: 0;
    right: 0;
    left: 0;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 1990;
  }
}


@media (max-width: 769px) {
  #sidebar-toggle:checked~.bg-layer {
    position: fixed;
    top: 0;
    bottom: 0;
    right: 0;
    left: 0;
    background-color: rgba(1, 1, 1, 0.5);
    z-index: 1090;
  }
}

/* === Sidebar Heading === */
#sidebar h4 {
  font-weight: bold;
  letter-spacing: 1px;
  text-transform: uppercase;
  color: #ECF0F1;
  margin-bottom: 20px;
}

/* Custom Scrollbar Style for Sidebar */
#sidebar::-webkit-scrollbar {
  width: 6px;
}

#sidebar::-webkit-scrollbar-track {
  background: #2C3E50;
}

#sidebar::-webkit-scrollbar-thumb {
  background-color: #1ABC9C;
  border-radius: 10px;
  transition: background-color 0.3s ease-in-out;
}

#sidebar::-webkit-scrollbar-thumb:hover {
  background-color: #16A085;
}
</style>
