<?php

$menu_item_first = true;

function menu_start($title) {
    echo '<ul id="menu" class="nav nav-pills nav-fill flex-column me-2">';
    echo '  <li class="nav-item text-start">';
    echo '    <h4 class="ms-1 ,t-2 mb-3">';
    echo '      ', $title;
    echo '    </h4>';
    echo '  </li>';
}

function menu_item($name, $frame, $href) {
    global $menu_item_first;

    $active = $menu_item_first ? " active" : "";
    echo '  <li class="nav-item">';
    echo '    <button class="nav-link text-start text-white ',
         $active, '" data-frame="', $frame, '" data-href="', $href, '"';
    echo '      onclick="menu_click(event)">';
    echo '      ', $name;
    echo '    </button>';
    echo '  </li>';
    $menu_item_first = false;
}

function menu_start_item_with_tasks($menu_id, $name, $frame, $href, $fn="") {
    $data_fn = ($fn == "" ? "" : " data-fn='" . $fn . "'");
    echo '  <div class="d-flex">';
    echo '    <div>';
    echo '      <li class="nav-item">';
    echo '        <button class="nav-link text-start text-white" data-frame="'
         , $frame, '" data-href="', $href, '"', $data_fn;
    echo '          data-menu-child="'
         , $menu_id, '" onclick="menu_click(event)">';
    echo '          ', $name;
    echo '        </button>';
    echo '      </li>';
    echo '    </div>';
    echo '    <div>';
    echo '      <li class="dropdown ms-2">';
    echo '        <button id="', $menu_id,
         '" class="btn btn-dark disabled dropdown-toggle" data-bs-toggle="dropdown"';
    echo '          aria-expanded="false">';
    echo '          tasks';
    echo '        </button>';
    echo '        <ul class="dropdown-menu dropdown-menu-dark text-small shadow">';
}

function menu_item_task($name, $fn) {
    echo '          <li>';
    echo '            <button class="dropdown-item" data-fn="', $fn,
         '" onclick="menu_click(event)">';
    echo '              ', $name;
    echo '            </button>';
    echo '          </li>';
}

function menu_item_task_divider() {
    echo '          <li>';
    echo '            <hr class="dropdown-divider">';
    echo '          </li>';
}

function menu_end_item_with_tasks() {
    echo '        </ul>';
    echo '      </li>';
    echo '    </div>';
    echo '  </div>';
}

function menu_end() {
    echo '</ul>';
}

?>