<?php

$menu_item_first = true;

function menu_bar_start($name)
{
    echo '<div class="position-absolute top-0 h-100 left-0 p-3 text-bg-dark" style="width:280px;">' . "\n";
    echo '  <div class="d-flex flex-column flex-shrink-0 text-bg-dark">' . "\n";
    echo '    <div class="fs-3 display-3 mx-2 py-2">', $name, '</div>' . "\n";
    echo '    <hr>' . "\n";
}

function menu_start($title)
{
    echo '    <ul id="menu" class="nav nav-pills nav-fill flex-column me-2">' . "\n";
    echo '      <li class="nav-item text-start">' . "\n";
    echo '        <h4 class="ms-1 ,t-2 mb-3">' . "\n";
    echo '          ', $title;
    echo '        </h4>' . "\n";
    echo '      </li>' . "\n";
}

function menu_item($name, $frame, $href)
{
    global $menu_item_first;

    $active = $menu_item_first ? " active" : "";
    echo '      <li class="nav-item">' . "\n";
    echo '        <button class="nav-link text-start text-white ',
    $active, '" data-frame="', $frame, '" data-href="', $href, '"' . "\n";
    echo '          onclick="menu_click(event)">' . "\n";
    echo '          ', $name;
    echo '        </button>' . "\n";
    echo '      </li>' . "\n";
    $menu_item_first = false;
}

function menu_start_item_with_tasks($menu_id, $name, $frame, $href, $fn = "")
{
    $data_fn = ($fn == "" ? "" : " data-fn='" . $fn . "'");
    echo '      <div class="d-flex">' . "\n";
    echo '        <div>' . "\n";
    echo '          <li class="nav-item">' . "\n";
    echo '            <button class="nav-link text-start text-white" data-frame="', $frame, '" data-href="', $href, '"', $data_fn;
    echo '              data-menu-child="', $menu_id, '" onclick="menu_click(event)">' . "\n";
    echo '              ', $name;
    echo '            </button>' . "\n";
    echo '          </li>' . "\n";
    echo '        </div>' . "\n";
    echo '        <div>' . "\n";
    echo '          <li class="dropdown ms-2">' . "\n";
    echo '            <button id="', $menu_id,
    '" class="btn btn-dark disabled dropdown-toggle" data-bs-toggle="dropdown"' . "\n";
    echo '              aria-expanded="false">' . "\n";
    echo '              tasks' . "\n";
    echo '            </button>' . "\n";
    echo '            <ul class="dropdown-menu dropdown-menu-dark text-small shadow">' . "\n";
}

function menu_item_task($name, $fn)
{
    echo '              <li>' . "\n";
    echo '                <button class="dropdown-item" data-fn="', $fn,
    '" onclick="menu_click(event)">' . "\n";
    echo '                  ', $name;
    echo '                </button>' . "\n";
    echo '              </li>' . "\n";
}

function menu_item_task_divider()
{
    echo '              <li>' . "\n";
    echo '                <hr class="dropdown-divider">' . "\n";
    echo '              </li>' . "\n";
}

function menu_bottom($left, $left_href, $right, $right_href)
{
    echo '  <div class="position-absolute bottom-0 w-100 pe-3 pb-3">' . "\n";
    echo '    <hr class="me-3">' . "\n";
    echo '    <div class="d-flex justify-content-between my-1 mx-3 pe-3 text-center">' . "\n";
    echo '      <div>' . "\n";
    echo '        <a href="', $left_href, '" class="d-inline display fs-5 text-white text-decoration-none">' . "\n";
    echo '          &lt;&nbsp;', $left . "\n";
    echo '        </a>' . "\n";
    echo '      </div>' . "\n";
    echo '      <div>' . "\n";
    echo '        <a href="', $right_href, '" class="d-inline display fs-5 text-white text-decoration-none">' . "\n";
    echo '          ', $right, '&nbsp;&gt;' . "\n";
    echo '        </a>' . "\n";
    echo '      </div>' . "\n";
    echo '    </div>' . "\n";
    echo '  </div>' . "\n";
}

function menu_end_item_with_tasks()
{
    echo '            </ul>' . "\n";
    echo '          </li>' . "\n";
    echo '        </div>' . "\n";
    echo '      </div>' . "\n";
}

function menu_end()
{
    echo '    </ul>' . "\n";
}

function menu_bar_end()
{
    echo '  </div>' . "\n";
    echo '</div>' . "\n";
}
