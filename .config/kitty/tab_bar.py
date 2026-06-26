from kitty.tab_bar import DrawData, ExtraData, TabBarData, Screen, draw_tab_with_powerline
from kitty.fast_data_types import get_boss
from kitty.tab_bar import as_rgb, color_as_int
from kitty.tab_bar import powerline_symbols 

def current_session_name(os_window_id: int) -> str:
    tm = get_boss().os_window_map.get(os_window_id)
    if tm is None:
        return ""
    tab = tm.active_tab
    if tab is None:
        return ""
    return tab.active_session_name or tab.created_in_session_name

def draw_tab(draw_data: DrawData, screen: Screen, tab: TabBarData,
             before: int, max_tab_length: int, index: int, is_last: bool,
             extra_data: ExtraData) -> int:
    # Draw the session name once, before the first tab
    if index == 1:
        sess_name = current_session_name(draw_data.os_window_id)
        if sess_name:
            tab_fg, tab_bg, orig_bold = screen.cursor.fg, screen.cursor.bg, screen.cursor.bold

            screen.cursor.fg = as_rgb(color_as_int(draw_data.active_fg))
            screen.cursor.bg = as_rgb(color_as_int(draw_data.inactive_bg))
            screen.cursor.bold = True
            screen.draw(f' {sess_name} 🦆  ')

            
            screen.cursor.fg, screen.cursor.bg, screen.cursor.bold = tab_fg, tab_bg, orig_bold   # restore

    return draw_tab_with_powerline(
        draw_data, screen, tab, before, max_tab_length, index, is_last, extra_data)
