luajit-procname - set/get process name
======================================

Get/set process name with prctl.

Example:


    local pn = require("procname")
    local get_procname, set_procname = pn.get_procname, pn.set_procname

    function example()
        local ok, errno, name
        
        name, errno = get_procname()
        if name then
            print("process name (before change):   " .. name)
        else
            print(string.format("error: could not get process name. errno == %d.",
                                errno))
            return
        end

        name = "my_process"
        ok, errno = set_procname(name) 
        if not ok then
            print(string.format("could not set process name '%s'. errno == %d.",
                                name, errno))
            return
        end

        name, errno = get_procname()
        if name then
            print("process name (after change):    " .. name)
        else
            print(string.format("error: could not get process name. errno == %d.", 
                                errno))
            return
        end
    end

    example()
        

