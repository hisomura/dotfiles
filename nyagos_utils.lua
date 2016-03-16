share.insert_cd_history = function()
    local cd_history_path = nyagos.getenv("APPDATA") .. '\\NYAOS_ORG\\nyagos.cd_history'
    f = io.open(cd_history_path, 'a+')
    f:write(nyagos.getwd() .. '\n')
    f:flush()
end

share.cd = function(args)
    arg1 = ''
    if #args > 0 then
        arg1 = args[1]:gsub('\\', '/') 
        arg1 = '"' .. arg1 .. '"'
    end
    r, err = nyagos.exec('__cd__ ' .. arg1)
    share.insert_cd_history()

    return r, err
end

share.peco_cd_history = function(this)
    local cd_history_path = nyagos.getenv("APPDATA") .. '\\NYAOS_ORG\\nyagos.cd_history'
    local target_path = nyagos.eval('type ' .. cd_history_path .. ' | peco')
    if target_path ~= nil then
        r, err = nyagos.exec('__cd__ ' .. target_path)
    end
    this:call("CLEAR_SCREEN")
    -- エラーが出たらこの辺りで止めた方がいいかも
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
