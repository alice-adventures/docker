function alr_toolchain_select() {
    tty_clear();
    tty_sendCommand("alr toolchain");
}

function alr_compile_project_euler() {
    tty_clear();
    tty_sendCommand("cd ~/alice/project_euler");
    tty_sendCommand("alr --non-interactive build --development");
}
