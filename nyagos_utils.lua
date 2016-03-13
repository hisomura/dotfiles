share.peco_cd = function(this)
    local history_path = nyagos.getenv("APPDATA") .. '\\NYAOS_ORG\\nyagos.history'
    local command = nyagos.eval('type ' .. history_path .. ' | peco')
    if command ~= nil then
        -- this.insert(command)
        return command
    else
        nyagos.prompt()
    end

    return nil
end

share.peco_history = function(this)
    local history_path = nyagos.getenv("APPDATA") .. '\\NYAOS_ORG\\nyagos.history'
    local command = nyagos.eval('type ' .. history_path .. ' | peco')
    this:call("CLEAR_SCREEN")

    return command
end

share.docker_machine_env = function (args) 
    if args[1] ~= nil then
        machine = args[1]
    else
        machine = 'default'
    end

    local env_data = nyagos.eval('docker-machine env --shell=cmd ' .. machine)
    for key, value in string.gmatch(env_data, "SET ([0-9a-ZA-Z_:/]+)=([^\n]+)") do
        if key ~= nil and value ~= nil then
            nyagos.setenv(key, value)
        end
    end
end
