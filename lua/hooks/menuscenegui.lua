if not _G.SeamlessInputSwitch then
    dofile(ModPath .. "lua/bootstrap.lua")
end

local SIS = _G.SeamlessInputSwitch

if not MenuSceneGui or SIS._menu_scene_gui_hooked then
    return
end

SIS._menu_scene_gui_hooked = true

local original_update = MenuSceneGui.update

local function raw_axis(controller, axis_name)
    if not controller or not controller.axis then
        return nil
    end

    local axis_id = Idstring(axis_name)

    if controller.has_axis then
        local ok, available = pcall(controller.has_axis, controller, axis_id)

        if ok and not available then
            return nil
        end
    end

    local ok, axis = pcall(controller.axis, controller, axis_id)

    return ok and axis or nil
end

local function active_axis(axis)
    local x, y = SIS:axis_components(axis)
    local deadzone = math.max(0.12, tonumber(SIS.settings.axis_threshold) or 0.18)

    if math.abs(x) < deadzone then
        x = 0
    end

    if math.abs(y) < deadzone then
        y = 0
    end

    return x, y, x ~= 0 or y ~= 0
end

function MenuSceneGui:update(t, dt, ...)
    local result = original_update(self, t, dt, ...)

    if SIS.active_family ~= "gamepad" or not managers or not managers.menu_scene then
        return result
    end

    local input = SIS:get_menu_input()
    local wrapper = input and input._controller
    local controller = wrapper and SIS:get_pad_controller(wrapper, true)

    if not controller then
        return result
    end

    local left_x, left_y, left_active = active_axis(raw_axis(controller, "left"))
    local right_x, right_y, right_active = active_axis(raw_axis(controller, "right"))

    if left_active then
        managers.menu_scene:controller_move(left_x * dt, left_y * dt)
    else
        managers.menu_scene:stop_controller_move()
    end

    if right_active then
        managers.menu_scene:controller_zoom(right_x * dt, right_y * dt)
    else
        managers.menu_scene:stop_controller_zoom()
    end

    return result
end

SIS:log("MenuSceneGui raw gamepad preview controls installed.", true)
