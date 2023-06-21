
function solution_load(href) {
    solution.contentWindow.location = href;
}

let menu_frame = null;

function menu_click(event) {
    if (event.buttons == 0) {
        let menu = document.getElementById("menu");
        let is_active = menu.querySelector(".active");
        let activities = document.getElementById("activities");

        // apply href location
        if (event.target.attributes["data-href"]) {

            // get the target frame and window elements
            let target_frame = activities.querySelector("#" +
                event.target.attributes["data-frame"].value);
            let target_window = target_frame.contentWindow;

            if (is_active != event.target) {
                // change button active
                is_active.classList.remove("active");
                event.target.classList.add("active");

                // enable/disable menu-child for is_active and target
                if (is_active.attributes["data-menu-child"]) {
                    let menu_child = document.querySelector("#" +
                        is_active.attributes["data-menu-child"].value);
                    menu_child.classList.remove("enabled");
                    if (menu_child.classList.contains("show")) {
                        menu_child.click();
                    }
                    menu_child.classList.add("disabled");
                }
                if (event.target.attributes["data-menu-child"]) {
                    let menu_child = document.querySelector("#" +
                        event.target.attributes["data-menu-child"].value);
                    menu_child.classList.remove("disabled");
                    menu_child.classList.add("enabled");
                }

                // move target frame to foreground
                target_frame.classList.remove("z-0");
                target_frame.classList.add("z-3");

                // move current frame to background
                if (menu_frame == null) {
                    menu_frame = contents;
                }
                menu_frame.classList.remove("z-3");
                menu_frame.classList.add("z-0");
                menu_frame = target_frame;
            }

            // set src attribute on target frame
            let old_href = null;
            if (target_frame.attributes["data-href"]) {
                old_href = target_frame.attributes["data-href"].value;
            }

            // let old_href = target_window.location.pathname +
            //     target_window.location.search;
            let new_href = event.target.attributes["data-href"].value;
            if (old_href != new_href) {
                target_window.location = new_href;
                console.log("old href: " + old_href);
                console.log("new href: " + new_href);
                if (target_frame === tty) {
                    console.log("onLoad");
                    tty_onLoad();
                }
                if (old_href === null) {
                    target_frame.attributes["data-href"] = new_href;
                }
                else {
                    target_frame.attributes["data-href"].value = new_href;
                }
            }

            // eval function, if any
            if (event.target.attributes["data-fn"]) {
                let data_fn = event.target.attributes["data-fn"].value;
                console.log("eval fn: " + data_fn);
                eval(data_fn);
            }
        }
        else { // or call function
            let data_fn = event.target.attributes["data-fn"].value;
            console.log("eval fn: " + data_fn);
            eval(data_fn);
        }
    }
}
