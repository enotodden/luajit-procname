--
-- procname, get/set process name (linux only)
--

local ffi = require("ffi")

ffi.cdef([[
int prctl(int option, unsigned long arg2, unsigned long arg3, 
    unsigned long arg4, unsigned long arg5);
]])

local PR_SET_NAME = 15
local PR_GET_NAME = 16

function set_procname (name) 
    local r = ffi.C.prctl(PR_SET_NAME, 
        ffi.cast("unsigned long", name), 0, 0, 0);
    if r ~= 0 then
        return false, ffi.errno()
    end
    return true, 0
end

function get_procname () 
    local name = ffi.new("char[17]")
    ffi.fill(name, 17, 0)
    local r = ffi.C.prctl(PR_GET_NAME,
        tonumber(ffi.cast("unsigned long", name)), 0, 0, 0)
    if r ~= 0 then
        return nil, ffi.errno()
    end
    return ffi.string(name), 0
end

return {
    set_procname=set_procname,
    get_procname=get_procname
}

