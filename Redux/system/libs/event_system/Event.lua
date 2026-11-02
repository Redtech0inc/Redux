local nativeEvents = {
    alarm = true,
    char = true,
    computer_command = true,
    disk = true,
    disk_eject = true,
    file_transfer = true,
    http_check = true,
    http_failure = true,
    http_success = true,
    key = true,
    key_up = true,
    modem_message = true,
    monitor_resize = true,
    monitor_touch = true,
    mouse_click = true,
    mouse_drag = true,
    mouse_scroll = true,
    mouse_up = true,
    paste = true,
    peripheral = true,
    peripheral_detached = true,
    rednet_message = true,
    redstone = true,
    setting_changed = true,
    speaker_audio_empty = true,
    task_complete = true,
    term_resize = true,
    terminate = true,
    timer = true,
    turtle_inventory = true,
    websocket_closed = true,
    websocket_failure = true,
    websocket_message = true,
    websocket_success = true
}

Event = {}

function Event.new(type, ...)
    local obj = {}

    obj.type = type

    if nativeEvents[type] then obj.isNative = true
    else obj.isNative = false
    end

    obj.args = {...}

    obj.copy = Event.copy;

    return obj
end

function Event.copy(event)
    local obj = {}

    obj.type = event.type
    obj.isNative = event.isNative
    obj.args = {table.unpack(event.args)}
    obj.copy = Event.copy;

    return obj
end