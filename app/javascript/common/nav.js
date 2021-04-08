let close_nav_popups = () => {
  document.querySelectorAll('.popup').forEach( (popup) => {
    popup.style.display = 'none';
  });
}
window.onresize = close_nav_popups;

let setup_popup_opener = (opener_name, popup_name) => {
  let opener = document.getElementById(opener_name);
  let popup = document.getElementById(popup_name);
  if (opener && popup) {
    opener.onclick = (e) => {
      e.preventDefault();
      if (window.getComputedStyle(popup).display === 'block'){
        popup.style.display = 'none';
      }else{
        close_nav_popups();
        popup.style.display = 'block';
      }
    }
  }
}

// click outside to close menu
window.onmouseup = (e) => {
  let nav = document.querySelector('header nav');
  if (!nav.contains(e.target)) {
    close_nav_popups();
  }
}

onload = () => {
  setup_popup_opener('burger',      'nav-dropdown');
  setup_popup_opener('open-search', 'search-popup');
  // setup_popup_opener('open-signin-lg-md', 'signin-popup');
  // setup_popup_opener('open-signin-sm', 'signin-popup');
  setup_popup_opener('open-user-lg-md', 'user-popup');
  setup_popup_opener('open-user-sm', 'user-popup');
  setup_popup_opener('open-cart',   'cart-popup');

  // Select menu item by "[data-item]" == name_selected_item
  let name_selected_item = "Scenes";
  document.querySelectorAll("[data-item='" + name_selected_item + "']").forEach((item)=>{
    item.className += ' selected';
  });
}

window.onload = onload;
document.addEventListener("turbolinks:load", function() {
  onload();
})
