if not _G.SeamlessInputSwitch then
    dofile(ModPath .. "lua/bootstrap.lua")
end

local SIS = _G.SeamlessInputSwitch

if not MenuSceneGui or SIS._menu_scene_gui_hooked then
    return
end

SIS._menu_scene_gui_hooked = true

local original_update = MenuSceneGui.update

function MenuSceneGui:update(...)
   
    if managers and managers.menu and not managers.menu:is_pc_controller() and (not self._left_axis_vector or not self._right_axis_vector) then
        local ok, error_message = pcall(function()
            self:_setup_controller_input()
        end)

        if not ok or not self._left_axis_vector or not self._right_axis_vector then
            SIS:log("MenuSceneGui controller-state guard blocked an unsafe update: " .. tostring(error_message or "vectors unavailable"))

            return
        end

        if not SIS._menu_scene_guard_announced then
            SIS._menu_scene_guard_announced = true
            SIS:log("MenuSceneGui controller state initialized safely after a runtime type change.")
        end
    end

    return original_update(self, ...)
end

SIS:log("MenuSceneGui native-vector guard installed.", true)
