# Vizrt Marketplace

## Publisher Portal

### Frontend & Backend routes

For rendering all back-office only the page:
/publisher/products

Inside Vue route there is routes for editing a product:
/publisher/products/:id
/publisher/products/:id/title
/publisher/products/:id/texts
/publisher/products/:id/media
/publisher/products/:id/files

All the rest render by Vue, with inside API:
/publisher/api/products

## Toasting / flash messages / global notification

To make a new notification/toast just run:
```
FlashVM.notice("message")
FlashVM.alert("message")
```
It's avaliable everywhere, includes Vue and regular js code.
