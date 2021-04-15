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
```javascript
FlashVM.notice("message")
FlashVM.alert("message")
```
It's avaliable everywhere, includes Vue and regular js code.

## Z-index layers
* 101 — image preview in Image Input
* 102 — image preview in Image Input, .picture-inner
* 103 — image preview in Image Input, .loading-container, .status-container 
* 200 — popup toasts/flashes
* 300 — popup main menu
* 1000 — modal window
* 10000 — Dropdown menu ul.vs__dropdown-menu
