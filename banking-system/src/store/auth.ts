import api from "@/config/config";
import { defineStore } from "pinia";

import { useRouter } from "vue-router";

export interface UserType {
  id: number;
  name: string;
  email: string;
  role_id: number;
  photo?: string;
}

export interface AuthResponse {
  user: UserType;
  token: string;
}

export const useAuthStore = defineStore("auth", {
  state: () => ({
    user: (localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user") as string) : null) as UserType | null,
    token: (localStorage.getItem("token") || "") as string,
  }),

  actions: {
    setAuth(data: AuthResponse) {
      this.user = data.user;
      this.token = data.token;
      localStorage.setItem("user", JSON.stringify(data.user));
      localStorage.setItem("token", data.token);
    },

    async logout() {
      const router = useRouter();

      await api.post(
        "logout",
        {},
        {
          headers: { Authorization: `Bearer ${this.token}` },
        }
      );

      this.user = null;
      this.token = "";
      localStorage.clear();
      router.push("/login");
    },
  },
});
