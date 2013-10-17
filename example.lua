local pn = require("procname")
local get_procname, set_procname = pn.get_procname, pn.set_procname

function example()
    local ok, errno, name
    
    name, errno = get_procname()
    if name then
        print("Process name (before change):   " .. name)
    else
        print(string.format("Error: Could not get process name. errno == %d.",
                            errno))
        return
    end

    name = "my_process"
    ok, errno = set_procname(name) 
    if not ok then
        print(string.format("Could not set process name '%s'. errno == %d.",
                            name, errno))
        return
    end

    name, errno = get_procname()
    if name then
        print("Process Name (after change):    " .. name)
    else
        print(string.format("Error: Could not get process name. errno == %d.", 
                            errno))
        return
    end
end

example()
