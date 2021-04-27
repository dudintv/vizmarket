# Vizrt Marketplace

[https://vizrt.store](https://vizrt.store){:target="_blank" rel="noopener"}

![VizMarket short presentation](https://github.com/dudintv/vizmarket/raw/master/public/images/for-github-readme/vizmarket-short-presentation.gif)

## Setup
```bash
clone https://github.com/dudintv/vizmarket.git
cd vizmarket
bundle
```

## Developer using

Current setup uses postgres in **docker** container. Rails server and webpack-dev-server run via **overmind**.

```bash
docker-compose up -d postgres; rm .overmind.sock; overmind s
```

### Rails 6 Credentials

```bash
# for development and test
EDITOR="code --wait" rails credentials:edit

# for production
EDITOR="code --wait" rails credentials:edit --environment production

# generate new secret_key_base string
rails secret

# using example in *.rb files
Rails.application.credentials.dig(Rails.env.to_sym, :omniauth, :facebook, :id)

# using example in *.yml files
url: <%= Rails.application.credentials.dig Rails.env.to_sym, :database, :url %>
```

## Deploy

```bash
cap production deploy
# or with deploy user password
DEPLOY_USER_PASSWORD=password cap production deploy
```

### Troubleshooting in deploy

#### Missed Tailwind style.

Error while capistrano deploying: ```TypeError: Cannot read property 'toLowerCase' of undefined```

Solution: find in SCSS files something like: ```theme('blue-50')```, and add 'colors.' to get that: ```theme('colors.blue-50')```

## Publisher Portal

### Frontend & Backend routes

Back-office:  
/publisher/products

Inside Vue route there is routes for editing a product:  
/publisher/products/:id  
/publisher/products/:id/title  
/publisher/products/:id/texts  
/publisher/products/:id/media  
/publisher/products/:id/files  

Back-office API for Vue.js:
/publisher/api/products

## Toasting / flash messages / global notification

Supports rails controller classic:
```ruby
flash[:notice] = 'message'
flash[:alert] = 'message'
flash[:warning] = 'message'
flash[:error] = 'message'
```

And, custom Vue.js or Vanilla JS notification/toast:
```javascript
FlashVM.notice('message')
FlashVM.alert('message')
```
It's avaliable everywhere, includes Vue and regular js code. **FlashVM** — is global Vue.js app.

## Z-index layers
* 101 — image preview in Image Input
* 102 — image preview in Image Input, .picture-inner
* 103 — image preview in Image Input, .loading-container, .status-container 
* 200 — popup toasts/flashes
* 300 — popup main menu
* 1000 — modal window
* 10000 — Dropdown menu ul.vs__dropdown-menu
