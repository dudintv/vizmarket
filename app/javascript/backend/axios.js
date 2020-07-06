import axios from 'axios'

const metaCsrfToken = document.querySelector('meta[name="csrf-token"]');
axios.defaults.headers.common = {
  'X-Requested-With': 'XMLHttpRequest',
  'X-CSRF-TOKEN': metaCsrfToken ? metaCsrfToken.getAttribute('content') : '',
  'Accept': 'application/json',
};

const publisher_adapter = axios.create({
  baseURL: '/publisher/api',
})

export default {
  products: {
    get: id => publisher_adapter.get(`/products/${id}`),
    create: product => publisher_adapter.post('/products/', product)
  }
}
