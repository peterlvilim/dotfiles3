function update_title() {
  browserBg.windows.getCurrent().then((win) => {
    id = win.id;
    browser.runtime
      .sendMessage("simple-tab-groups@drive4ik", {
        action: "get-current-group",
        windowId: id,
      })
      .then((group) => {
        const group_title = group.group.title;
        if (!document.title.startsWith(group_title + " |")) {
          if (document.title.includes("|")) {
            const parts = document.title.split("|");
            const title = parts.slice(1).join("");
            document.title = group_title + " | " + title;
          } else {
            document.title = group_title + " | " + document.title;
          }
        }
      });
  });
}
// tab changes
new MutationObserver(function (mutations) {
  update_title();
}).observe(document.querySelector("title"), {
  subtree: true,
  characterData: true,
  childList: true,
});

// on load
update_title();
