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

const author_adapter = axios.create({
  baseURL: '/publisher/author',
})

const user_adapter = axios.create({
  baseURL: '/settings/user',
})

const feedback_message_adapter = axios.create({
  baseURL: '/feedback_messages',
})

export default {
  user: {
    get: () => user_adapter.get('/show'),
    update: user => user_adapter.post('/update', { user } ),
    updatePassword: (currentPassword, newPassword) => user_adapter.post('/update_password', { user: { current_password: currentPassword, new_password: newPassword }} ),
    uploadAvatar: avatar => user_adapter.post('/upload_avatar', avatar),
    deleteAvatar: () => user_adapter.delete('/delete_avatar'),
    destroyAccountLink: account => user_adapter.delete('/destroy_account_link', { params: { account } }),
    getInvitationsList: () => user_adapter.get('/get_invitations_list'),
    createInvitations: () => user_adapter.post('/create_invitations'),
    destroyMyAccount: email => user_adapter.delete('/destroy_my_account', { params: { email } }),
  },
  author: {
    get: () => author_adapter.get('/show'),
    update: author => author_adapter.post('/update', { author } ),
    activate: () => author_adapter.post('/activate'),
  },
  products: {
    index: () => publisher_adapter.get('/products'),
    new: () => publisher_adapter.get('/products/new'),
    get: id => publisher_adapter.get(`/products/${id}`),
    create: product => publisher_adapter.post('/products', product),
    update: (id, product) => publisher_adapter.patch(`/products/${id}`, product),
    delete: id => publisher_adapter.delete(`/products/${id}`),

    publish: (id) => publisher_adapter.post(`/products/${id}/publish`),
    unpublish: (id) => publisher_adapter.post(`/products/${id}/unpublish`),

    uploadThumbnail: (id, image) => publisher_adapter.post(`/products/${id}/upload_thumbnail`, image),
    uploadFeaturedImage: (id, image) => publisher_adapter.post(`/products/${id}/upload_featured_image`, image),
    uploadGalleryImages: (id, images) => publisher_adapter.post(`/products/${id}/upload_gallery_images`, images),
    deleteThumbnail: (id) => publisher_adapter.delete(`/products/${id}/delete_thumbnail`),
    deleteFeaturedImage: (id) => publisher_adapter.delete(`/products/${id}/delete_featured_image`),
    deleteImage: (key) => publisher_adapter.delete(`/products/delete_image`, { params: { key: key } }),
  },
  versions: {
    index: (product_id) => publisher_adapter.get(`/products/${product_id}/versions`),
    create: (product_id, version) => publisher_adapter.post(`/products/${product_id}/versions`, version),
    update: (id, version) => publisher_adapter.patch(`/versions/${id}`, version),
    delete: id => publisher_adapter.delete(`/versions/${id}`),

    publish: (id) => publisher_adapter.post(`/versions/${id}/publish`),
    unpublish: (id) => publisher_adapter.post(`/versions/${id}/unpublish`),

    deleteFile: (key) => publisher_adapter.delete(`/versions/delete_file`, { params: { key: key } }),
  },
  feedbackMessages: {
    index: () => feedback_message_adapter.get('/'),
    new: () => feedback_message_adapter.get('/new'),
    create: message => feedback_message_adapter.post('/', message),
    delete: id => feedback_message_adapter.delete(`/${id}`),
  }
}
