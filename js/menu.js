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
                    menu_child.classList.add("disabled");
                }
                if (event.target.attributes["data-menu-child"]) {
                    let menu_child = document.querySelector("#" +
                        event.target.attributes["data-menu-child"].value);
                    menu_child.classList.remove("disabled");
                    menu_child.classList.add("enabled");
                }

                if (menu_frame != null) {
                    menu_frame.classList.remove("z-3");
                    menu_frame.classList.add("z-0");
                }

                // move target frame depth
                target_frame.classList.remove("z-0");
                target_frame.classList.add("z-3");
                menu_frame = target_frame;
                console.log(target_frame);
                console.log(target_window.location.href);
            }

            // set src attribute on target frame
            if (target_window.location.href === "about:blank"
                || target_frame === contents) {
                let data_href = event.target.attributes["data-href"].value;
                target_window.location.replace(data_href);
                console.log("apply href: " + data_href);
                if (target_frame === tty) {
                    console.log("onLoad");
                    tty_onLoad();
                }
            }
        }
        else { // or call function
            let data_fn = event.target.attributes["data-fn"].value;
            console.log("eval fn: " + data_fn);
            eval(data_fn);
        }
    }
}
