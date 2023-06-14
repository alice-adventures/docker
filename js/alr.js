function alr_toolchain_select() {
    tty_sendCommand("alr toolchain");
}

function alr_compile(path) {
    tty_sendCommand("cd ~/" + path);
    tty_sendCommand("");
    tty_sendCommand("alr --non-interactive build --development");
    tty_sendCommand("cd -");
}
