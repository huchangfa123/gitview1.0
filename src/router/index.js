import Vue from 'vue'
import Router from 'vue-router'
import First from '@/components/First'
import Login from '@/components/Login'
Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'First',
      component: First
    },
    {
      path: '/Login',
      name: 'Login',
      component: Login
    }
  ]
})
