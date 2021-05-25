import axios from 'axios'

const metaCsrfToken = document.querySelector('meta[name="csrf-token"]');
axios.defaults.headers.common = {
  'X-Requested-With': 'XMLHttpRequest',
  'X-CSRF-TOKEN': metaCsrfToken ? metaCsrfToken.getAttribute('content') : '',
  'Accept': 'application/json',
};

const admin_path_adapter = axios.create({
  baseURL: '/admin/api',
})

export default {
  users: {
    get: () => admin_path_adapter.get('/users'),
  },
}
