share.insert_cd_history = function()
    local cd_history_path = nyagos.getenv("APPDATA") .. '\\NYAOS_ORG\\nyagos.cd_history'
    f = io.open(cd_history_path, 'a+')
    f:write(nyagos.getwd() .. '\n')
    f:flush()
end

share.cd = function(args)
    arg1 = ''
    if #args > 0 then
        arg1 = '"' .. args[1]:gsub('\\', '/') .. '"'
    end
    r, err = nyagos.exec('__cd__ ' .. arg1)
    share.insert_cd_history()

    return r, err
end

share.peco_cd_history = function(this)
    local cd_history_path = nyagos.pathjoin(nyagos.env.appdata, 'NYAOS_ORG\\nyagos.cd_history')
    if not nyagos.access(cd_history_path, 0) then
        print(": can not get nyagos.cd_history")
        return nil -- TODO エラーを返したいけど返し方が不明
    end

    local target_path = nyagos.eval('type ' .. cd_history_path .. ' | peco')
    if target_path ~= nil then
        r, err = nyagos.exec('__cd__ ' .. target_path)
        share.insert_cd_history()
    end
    this:call("CLEAR_SCREEN")

    return nil
end


-- https://gist.github.com/balaam/3122129
share.reverse = function (tbl)
    for i=1, math.floor(#tbl / 2) do
        tbl[i], tbl[#tbl - i + 1] = tbl[#tbl - i + 1], tbl[i]
    end
end
share.uniq = function (tbl)
    local uniqtbl
    for elem in tbl do
        
    end
end

share.peco_history_fix = function(this)
    local path = nyagos.pathjoin(nyagos.env.appdata, 'NYAOS_ORG\\nyagos.history')

    local commands_str = nyagos.eval('type ' .. path) -- TODO luaの関数に直す
    commands = {}
    for command in string.gmatch(commands_str, "([^\n]+)") do
        commands.insert(command)
    end
    commands = share.reverse(commands)

    local result = nyagos.eval('peco < ' .. path)
    this:call("CLEAR_SCREEN")
    return result
end

-- 今後標準で搭載されるので消す予定
share.peco_history = function(this)
    local path = nyagos.pathjoin(nyagos.env.appdata, 'NYAOS_ORG\\nyagos.history')
    local result = nyagos.eval('peco < ' .. path)
    this:call("CLEAR_SCREEN")
    return result
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
