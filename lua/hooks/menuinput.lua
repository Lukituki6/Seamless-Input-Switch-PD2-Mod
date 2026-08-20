if not _G.SeamlessInputSwitch then
    dofile(ModPath .. "lua/bootstrap.lua")
end

local SIS = _G.SeamlessInputSwitch

if not MenuInput or SIS._menu_input_hooked then
    return
end

SIS._menu_input_hooked = true

local original_activate_mouse = MenuInput.activate_mouse
local original_open = MenuInput.open
local original_mouse_moved = MenuInput.mouse_moved
local original_mouse_pressed = MenuInput.mouse_pressed

function MenuInput:activate_mouse(position, controller_activated)
    if not SIS.settings.menu_mouse then
        return original_activate_mouse(self, position, controller_activated)
    end

    if self._mouse_active then
        SIS:sync_pointer()

        return
    end

    self._mouse_active = true

    managers.mouse_pointer:use_mouse({
        mouse_move = callback(self, self, "mouse_moved"),
        mouse_press = callback(self, self, "mouse_pressed"),
        mouse_release = callback(self, self, "mouse_released"),
        mouse_click = callback(self, self, "mouse_clicked"),
        mouse_double_click = callback(self, self, "mouse_double_click"),
        id = self._menu_name
    }, position)

    SIS:sync_pointer()
end

function MenuInput:open(...)
    local result = original_open(self, ...)

    SIS:sync_pointer()

    return result
end

function MenuInput:mouse_moved(o, x, y, mouse_ws, ...)

    if mouse_ws and not managers.mouse_pointer._controller_updater then
        SIS:set_active_type("pc", "menu-mouse")
    elseif not mouse_ws and SIS.active_family == "gamepad" then
    
        return
    end

    return original_mouse_moved(self, o, x, y, mouse_ws, ...)
end

function MenuInput:mouse_pressed(...)
    if not managers.mouse_pointer._controller_updater then
        SIS:set_active_type("pc", "menu-mouse-button")
    end

    return original_mouse_pressed(self, ...)
end

SIS:log("Menu mouse hook installed.", true)
