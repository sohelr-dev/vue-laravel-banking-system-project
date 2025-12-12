import router from "@/components/routes";
import api from "@/config/config";
import { defineStore } from "pinia";

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

type AuthState ={
  user: UserType | null;
  token: string;
};

export const useAuthStore = defineStore("auth", {
  state: () => ({
    user: (localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user") as string) : null) as UserType | null,
    token: (localStorage.getItem("token") || "") as string,
  }),

  getters:{
    isauthenticated:(state)=>!!state.token && state.user !==null,
    userRole:(state)=>state.user?.role_id ?? null,
  },

  actions: {
    setAuth(data: AuthResponse) {
      this.user = data.user;
      this.token = data.token;
      try{
        localStorage.setItem("user", JSON.stringify(data.user));
        localStorage.setItem("token", data.token);
      }catch(e){
        console.error("localStorage set failed",e);
      }
    },

    async logout() {
      try{
        if(this.token){
          await api.post(
            "logout",{},{
              headers: { Authorization: `Bearer ${this.token}` },
            }
          );
        }
      }catch(e){
        console.warn('Server Logout failed',e);
      }finally{
        this.user = null;
        this.token = "";
      }try{
        localStorage.removeItem('user');
        localStorage.removeItem('token');
      }catch(e){}
      router.replace("/login");
    },
  },
});
