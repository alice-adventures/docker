let menu_frame = null;

function menu_click(event) {
    if (event.buttons == 0) {
        let menu = document.getElementById("menu");
        let is_active = menu.querySelector(".active");
        let activities = document.getElementById("activities");

        // get the target frame and window elements
        let target_frame = activities.querySelector("#" +
            event.target.attributes["data-frame"].value);
        let target_window = target_frame.contentWindow;


        if (is_active != event.target && event.target.nodeName === "BUTTON") {
            // change button active
            is_active.classList.remove("active");
            event.target.classList.add("active");

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

        // apply href location
        if (event.target.attributes["data-href"]) {
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
