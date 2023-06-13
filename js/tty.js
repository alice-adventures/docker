
let tty_frame = null;
let tty_isDisabled = false;
let tty_terminal = null;
let tty_terminalTextArea = null;
let tty_xterm = null;

function tty_onLoad() {
    setTimeout(() => tty_initTerminal(), 1000);
}

function tty_initTerminal() {
    tty_frame = document.getElementById("tty");
    tty_terminalTextArea = tty_frame.contentDocument.querySelector("textarea.xterm-helper-textarea");
    tty_terminal = tty_frame.contentWindow.term;
    tty_xterm = tty_frame.contentDocument.getElementsByClassName("terminal xterm")[0];

    tty_setThemeLight();
    // tty_xterm.addEventListener("focus", (event) => {
    //     tty_frame.classList.remove("border-secondary");
    //     tty_frame.classList.add("border-primary")
    // });
    // tty_xterm.addEventListener("blur", (event) => {
    //     tty_frame.classList.add("border-secondary");
    //     tty_frame.classList.remove("border-primary")
    // });
    tty_frame.classList.remove("invisible");
    tty_frame.classList.add("visible");
}

function tty_disableInput() {
    tty_terminal.setOption("cursorStyle", "bar");
    tty_terminal.setOption("disableStdin", true);
    tty_isDisabled = true;
}

function tty_enableInput() {
    tty_isDisabled = false;
    tty_terminal.setOption("cursorStyle", "block");
    tty_terminal.setOption("disableStdin", false);
}

function tty_writeCommand(cmd) {
    let disabled = tty_isDisabled;
    disabled && tty_enableInput();
    tty_terminal.paste(cmd);
    disabled && tty_disableInput();
}

function tty_sendCommand(cmd) {
    let disabled = tty_isDisabled;
    disabled && tty_enableInput();
    tty_terminal.paste(cmd);
    tty_terminalTextArea.dispatchEvent(new KeyboardEvent('keypress', { charCode: 13 }));
    disabled && tty_disableInput();
}

function tty_clear() {
    tty_sendCommand("clear");
}

function tty_setThemeDark() {
    tty_terminal.options.theme = {
        "background": "#151515",
        "black": "#000000",
        "blue": "#427ab3",
        "brightBlack": "#686a66",
        "brightBlue": "#84b0d8",
        "brightCyan": "#37e6e8",
        "brightGreen": "#99e343",
        "brightMagenta": "#bc94b7",
        "brightRed": "#f54235",
        "brightWhite": "#f1f1f0",
        "brightYellow": "#fdeb61",
        "cursor": "#adadad",
        "cyan": "#00a7aa",
        "foreground": "#d2d2d2",
        "green": "#5ea702",
        "magenta": "#89658e",
        "red": "#d81e00",
        "selectionBackground": "#264f78",
        "selectionForeground": "#d2d2d2",
        "selectionInactiveBackground": "3a3d41",
        "white": "#dbded8",
        "yellow": "#cfae00",
    };

}

function tty_setThemeLight() {
    tty_terminal.options.theme = {
        "background": "#f8f8f8",
        "black": "#000000",
        "blue": "#0451a5",
        "brightBlack": "#666666",
        "brightBlue": "#0451a5",
        "brightCyan": "#0598bc",
        "brightGreen": "#14ce14",
        "brightMagenta": "#bc05bc",
        "brightRed": "#cd3131",
        "brightWhite": "#a5a5a5",
        "brightYellow": "#b5ba00",
        "cursor": "#005fb8",
        "cyan": "#0598bc",
        "foreground": "#434343",
        "green": "#00bc00",
        "magenta": "#bc05bc",
        "red": "#cd3131",
        "selectionBackground": "#add6ff",
        "selectionForeground": "#434343",
        "selectionInactiveBackground": "#e5ebf1",
        "white": "#555555",
        "yellow": "#949800",
    };
}
