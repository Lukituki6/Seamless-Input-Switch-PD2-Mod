if not _G.SeamlessInputSwitch then
    dofile(ModPath .. "lua/bootstrap.lua")
end

local SIS = _G.SeamlessInputSwitch

if not CrimeNetGui or not CrimeNetGui.update or not CrimeNetGui.close or SIS._crimenet_manager_hooked then
    return
end

SIS._crimenet_manager_hooked = true

local original_update = CrimeNetGui.update
local original_close = CrimeNetGui.close

local function pack(...)
    return { n = select("#", ...), ... }
end

local function pad_controller()
    local input = SIS:get_menu_input()
    local wrapper = input and input._controller

    return wrapper and SIS:get_pad_controller(wrapper, true) or nil
end

local function activate_crimenet_pointer(gui)
    if gui._sis_crimenet_pointer or not SIS.settings.menu_mouse or not managers or not managers.mouse_pointer then
        return
    end

    local controller = pad_controller()
    local pointer = managers.mouse_pointer

    if not controller or pointer._controller_updater or not pointer.change_mouse_to_controller then
        return
    end

    local ok, changed = pcall(pointer.change_mouse_to_controller, pointer, controller)

    if not ok or not changed then
        return
    end

    gui._sis_crimenet_pointer = true

    if pointer._mouse_callbacks and #pointer._mouse_callbacks > 0 and pointer._activate then
        pointer:_activate()
    end

    if gui._panel and pointer.confine_mouse_pointer then
        pointer:confine_mouse_pointer(gui._panel)
    end

    if gui._panel and pointer.set_mouse_world_position and managers.gui_data and managers.gui_data.safe_to_full then
        pointer:set_mouse_world_position(managers.gui_data:safe_to_full(gui._panel:world_center()))
    end
end

local function restore_mouse_pointer(gui)
    if not gui._sis_crimenet_pointer or not managers or not managers.mouse_pointer then
        return
    end

    local pointer = managers.mouse_pointer

    gui._sis_crimenet_pointer = nil

    if pointer.change_controller_to_mouse then
        pcall(pointer.change_controller_to_mouse, pointer)
    end

    if pointer._mouse_callbacks and #pointer._mouse_callbacks > 0 and pointer._activate then
        pointer:_activate()
    end

    if pointer.release_mouse_pointer then
        pointer:release_mouse_pointer()
    end
end

function CrimeNetGui:update(...)
    if SIS.active_family == "gamepad" then
        activate_crimenet_pointer(self)
    else
        restore_mouse_pointer(self)
    end

    return original_update(self, ...)
end

function CrimeNetGui:close(...)
    local result = pack(pcall(original_close, self, ...))

    restore_mouse_pointer(self)

    if not result[1] then
        error(result[2])
    end

    return unpack(result, 2, result.n)
end

SIS:log("Crime.net isolated gamepad cursor hook installed.", true)
