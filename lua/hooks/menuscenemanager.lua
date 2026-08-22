if not _G.SeamlessInputSwitch then
    dofile(ModPath .. "lua/bootstrap.lua")
end

local SIS = _G.SeamlessInputSwitch

if not MenuSceneManager or SIS._menu_scene_manager_hooked then
    return
end

SIS._menu_scene_manager_hooked = true

local original_mouse_moved = MenuSceneManager.mouse_moved

function MenuSceneManager:mouse_moved(o, x, y, ...)
  
    if self._character_grabbed and
        (self._character_grabbed_current_x == nil or self._character_grabbed_current_y == nil) then
        self._character_grabbed = false
    end

    if self._item_grabbed and
        (self._item_grabbed_current_x == nil or self._item_grabbed_current_y == nil) then
        self._item_grabbed = false
    end

    return original_mouse_moved(self, o, x, y, ...)
end

SIS:log("Menu scene mixed-input crash guard installed.", true)
