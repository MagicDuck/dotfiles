from kitty.tab_bar import DrawData, ExtraData, TabBarData, Screen, draw_tab_with_powerline
from kitty.fast_data_types import get_boss
from kitty.tab_bar import as_rgb, color_as_int
from kitty.rgb import to_color

# LOGGER - turn on for debug

# import logging
# from logging.handlers import RotatingFileHandler
# from pathlib import Path
#
# log_path = Path.home() / ".cache" / "kitty" / "tab_bar.log"
# log_path.parent.mkdir(parents=True, exist_ok=True)

# logger = logging.getLogger("kitty.custom_tab_bar")
# logger.setLevel(logging.DEBUG)
# logger.propagate = False
#
# # Avoid duplicate handlers after reloading kitty.conf.
# if not logger.handlers:
#     handler = RotatingFileHandler(
#         log_path,
#         maxBytes=1_000_000,
#         backupCount=3,
#         encoding="utf-8",
#     )
#     handler.setFormatter(
#         logging.Formatter("%(asctime)s %(levelname)s %(message)s")
#     )
#     logger.addHandler(handler)

def current_session_name(os_window_id: int) -> str:
    tm = get_boss().os_window_map.get(os_window_id)
    if tm is None:
        return ""
    tab = tm.active_tab
    if tab is None:
        return ""
    return tab.active_session_name or tab.created_in_session_name

def os_window_var(os_window_id: int, name: str) -> str | None:
    manager = get_boss().os_window_map.get(os_window_id)
    if manager:
        for tab in manager:
            for window in tab:
                if value := window.user_vars.get(name):
                    return value
    return None

def os_window_class(os_window_id: int) -> str:
    tab_manager = get_boss().os_window_map.get(os_window_id)
    return tab_manager.wm_class if tab_manager else None

def draw_tab(draw_data: DrawData, screen: Screen, tab: TabBarData,
             before: int, max_tab_length: int, index: int, is_last: bool,
             extra_data: ExtraData) -> int:
    # logger.debug(
    #     "accent_color=%s os_window_id=%s wm_class=%s",
    #     accent_color if accent_color else draw_data.inactive_bg,
    #     draw_data.os_window_id,
    #     os_window_class(draw_data.os_window_id)
    # )

    # Draw the session name once, before the first tab
    if index == 1:
        sess_name = current_session_name(draw_data.os_window_id)

        if sess_name:
            tab_fg, tab_bg, orig_bold, orig_italic = screen.cursor.fg, screen.cursor.bg, screen.cursor.bold, screen.cursor.italic
            accent_color = os_window_var(draw_data.os_window_id, "accent_color")
            accent_icon = os_window_var(draw_data.os_window_id, "accent_icon")

            screen.cursor.fg = as_rgb(color_as_int(draw_data.active_fg))
            screen.cursor.bg = as_rgb(color_as_int(to_color(accent_color) if accent_color else draw_data.inactive_bg))
            screen.cursor.bold = True
            screen.cursor.italic = False
            screen.draw(f' {sess_name} ' +  (accent_icon if accent_icon else '🦆') + '  ')

            screen.cursor.fg, screen.cursor.bg, screen.cursor.bold, screen.cursor.italic = tab_fg, tab_bg, orig_bold, orig_italic  # restore

    return draw_tab_with_powerline(
        draw_data, screen, tab, before, max_tab_length, index, is_last, extra_data)
