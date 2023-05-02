browserBg.windows.getCurrent().then((win) => {document.title = win.title})

/*
tri.dont_loop = false
var target = document.querySelector('title');
var observer = new MutationObserver(function(mutations) {
    mutations.forEach(function(mutation) {

    if (!tri.dont_loop) {
      browserBg.windows.getCurrent().then((win) => {document.title = win.title})
      tri.dont_loop = true
      } else {
tri.dont_loop = false;
      }
    });
});
var config = {
    childList: true,
};
observer.observe(target, config);
*/
