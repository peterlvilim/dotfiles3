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
//js browserBg.tabs.query({}).then((tabs) => tri.native.write("/tmp/tabs", JSON.stringify(tabs)))
// doc load thing that calls function with url
// url check for special one
// if special one then loop and read /tmp/tridactyl_cmd location
// read in and split on \n then truncate
// run command and output to /tmp/tridactyl_output
// whole thing involves some sleeps but oh well
// can use ping timestamps for comms
