
let terminalElement = null;
let terminalTextArea = null;
let terminal = null;

function initTerminal() {
    terminalElement = document.getElementById("ttyd");
    terminalTextArea = terminalElement.contentDocument.querySelector("textarea.xterm-helper-textarea");
    terminal = terminalElement.contentWindow.term;
}

function sendCommand(cmd) {
    if (terminal === null) {
        initTerminal();
    }
    terminal.paste(cmd);
    terminalTextArea.dispatchEvent(new KeyboardEvent('keypress', { charCode: 13 }));
}