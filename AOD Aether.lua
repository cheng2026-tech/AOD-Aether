-- 1. 加载 WindUI（加了加速代理，保证能连上）
local WindUI = loadstring(game:HttpGet("https://gh-proxy.com/https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- 2. 获取游戏核心数据
local player = game.Players.LocalPlayer
local Network = game:GetService("ReplicatedStorage"):WaitForChild("Network")

-- 3. 创建窗口（⭐ 名字和作者已改好）
local Window = WindUI:CreateWindow({
    Title = "BS Aether",
    Icon = "egg",
    Author = "大肥鱼 | QQ: 3106633104",
})

-- 4. 创建标签页
local MainTab = Window:Tab({ Title = "主要功能", Icon = "house" })
local TeleportTab = Window:Tab({ Title = "快捷传送", Icon = "map-pin" })

-- ================= 功能代码区 =================

-- 功能1：自动升级基地
MainTab:Toggle({
    Title = "自动升级基地",
    Desc = "自动发送升级请求",
    Value = false,
    Callback = function(state)
        task.spawn(function()
            while state do
                local remote = Network:FindFirstChild("Plots: RequestBaseUpgrade")
                if remote then pcall(function() remote:FireServer() end) end
                task.wait(1)
            end
        end)
    end
})

-- 功能2：打飞光环
local auraEnabled = false
MainTab:Toggle({
    Title = "打飞光环",
    Desc = "自动攻击周围玩家",
    Value = false,
    Callback = function(state)
        auraEnabled = state
        if state then
            task.spawn(function()
                while auraEnabled do
                    local myChar = player.Character
                    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
                    if myHRP then
                        for _, plr in ipairs(game.Players:GetPlayers()) do
                            if plr ~= player and plr.Character then
                                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                                if hrp and (hrp.Position - myHRP.Position).Magnitude <= 20 then
                                    local batRemote = Network:FindFirstChild("Bat:Activate")
                                    if batRemote then
                                        pcall(function()
                                            batRemote:FireServer(plr, "11406186857:16:1786605357845")
                                        end)
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})

-- 功能3：传送函数
local function doTeleport(pos)
    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            pcall(function()
                hum.Health = math.huge
                hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            end)
        end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            pcall(function()
                hrp.Velocity = Vector3.zero
                hrp.CFrame = CFrame.new(pos) * (hrp.CFrame - hrp.CFrame.Position)
            end)
        end
    end
end

TeleportTab:Button({
    Title = "传送到家里",
    Icon = "home",
    Callback = function()
        doTeleport(Vector3.new(519.1, 70.6, -365.4))
        WindUI:Notify({ Title = "传送", Content = "已传送到家里", Icon = "check", Duration = 2 })
    end
})

TeleportTab:Button({
    Title = "传送到最后区域",
    Icon = "flag",
    Callback = function()
        doTeleport(Vector3.new(3405.4, 70.6, -353.4))
        WindUI:Notify({ Title = "传送", Content = "已传送到终点", Icon = "check", Duration = 2 })
    end
})

-- 启动通知（⭐ 通知内容也帮你改了）
WindUI:Notify({
    Title = "BS Aether",
    Content = "创作者：大肥鱼\nQQ：3106633104\n脚本加载成功",
    Icon = "check",
    Duration = 5,
})