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
    index: () => publisher_adapter.get('/products'),
    get: id => publisher_adapter.get(`/products/${id}`),
    create: product => publisher_adapter.post('/products', product),
    delete: id => publisher_adapter.delete('/products', id),
    
    publish: (id) => publisher_adapter.post(`/products/${id}/publish`),
    unpublish: (id) => publisher_adapter.post(`/products/${id}/unpublish`),

    update: (id, product) => publisher_adapter.patch(`/products/${id}`, product),
    uploadThumbnail: (id, image) => publisher_adapter.post(`/products/${id}/upload_thumbnail`, image),
    uploadFeaturedImage: (id, image) => publisher_adapter.post(`/products/${id}/upload_featured_image`, image),
    uploadGalleryImages: (id, images) => publisher_adapter.post(`/products/${id}/upload_gallery_images`, images),
    deleteThumbnail: (id) => publisher_adapter.delete(`/products/${id}/delete_thumbnail`),
    deleteFeaturedImage: (id) => publisher_adapter.delete(`/products/${id}/delete_featured_image`),
    deleteImage: (key) => publisher_adapter.delete(`/products/delete_image`, { params: { key: key } }),
  }
}
