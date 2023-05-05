//browser.runtime.sendMessage({action: 'getActiveGroup'}).then(function(response) {console.log(response.groupName);})
//browserBg.runtime.sendMessage({action: 'getActiveGroup'}).then(function(response) {console.log(response.groupName);})

//browserBg.windows.getCurrent().then((win) => {document.title = win.title})
//js browser.runtime.sendMessage('simple-tab-groups@drive4ik', {action: 'get-current-group', windowId: 3}).then(group => console.log("Current group:", group));
//js browser.runtime.sendMessage('simple-tab-groups@drive4ik', {action: 'are-you-here'}).then(group => console.log("Current group:", group));
//browserBg.windows.getCurrent().then((win) => {console.log(win)})
//js browser.windows.getCurrent()
//simple-tab-groups@drive4ik

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
