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
    create: product => publisher_adapter.post('/products', product),
    update: (id, product) => publisher_adapter.patch(`/products/${id}`, product),
    upload_thumbnail: (id, image) => publisher_adapter.post(`/products/${id}/upload_thumbnail`, image),
    upload_featured_image: (id, image) => publisher_adapter.post(`/products/${id}/upload_featured_image`, image),
    delete_thumbnail: (id) => publisher_adapter.delete(`/products/${id}/delete_thumbnail`),
    delete_featured_image: (id) => publisher_adapter.delete(`/products/${id}/featured_image`),
  }
}
