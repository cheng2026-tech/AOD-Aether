-- ==========================================================
-- 爱国者 Hub · AOD-Aether
-- 版本: 7.2.0-FINAL
-- 作者: 大肥鱼 | QQ: 3106633104
-- 仓库: github.com/cheng2026-tech/AOD-Aether
-- ==========================================================

-- ==========================================================
-- 【1】加载 WindUI（务必保持这个地址！）
-- ==========================================================
local WindUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"
))()
if not WindUI then
    warn("[爱国者] WindUI 加载失败")
    return
end

-- ==========================================================
-- 【2】主题注册（16 套）
-- ==========================================================
local ThemeDefs = {
    ["Crimson"]      = { Accent="#7f1d1d", Background="#200c0c", Outline="#f87171", Text="#fef2f2", Placeholder="#fca5a5", Button="#991b1b", Icon="#ef4444" },
    ["Dark"]         = { Accent="#18181b", Background="#101010", Outline="#ffffff", Text="#ffffff", Placeholder="#7a7a7a", Button="#52525b", Icon="#a1a1aa" },
    ["Amber"]        = { Accent="#92400e", Background="#1c140f", Outline="#fcd34d", Text="#fffbeb", Placeholder="#a8a29e", Button="#78350f", Icon="#fbbf24" },
    ["Plant"]        = { Accent="#166534", Background="#0f1f17", Outline="#4ade80", Text="#f0fdf4", Placeholder="#86efac", Button="#14532d", Icon="#22c55e" },
    ["Violet"]       = { Accent="#4c1d95", Background="#17102b", Outline="#a78bfa", Text="#f5f3ff", Placeholder="#c4b5fd", Button="#5b21b6", Icon="#8b5cf6" },
    ["Midnight"]     = { Accent="#1e3a8a", Background="#0f172a", Outline="#93c5fd", Text="#eff6ff", Placeholder="#94a3b8", Button="#1e40af", Icon="#3b82f6" },
    ["Rose"]         = { Accent="#881337", Background="#230e16", Outline="#fda4af", Text="#fff1f2", Placeholder="#fda4af", Button="#9f1239", Icon="#f43f5e" },
    ["Sky"]          = { Accent="#0e7490", Background="#0c1d24", Outline="#5eead4", Text="#ecfeff", Placeholder="#5eead4", Button="#155e75", Icon="#14b8a6" },
    ["Emerald"]      = { Accent="#047857", Background="#0c1c16", Outline="#6ee7b7", Text="#f0fdfa", Placeholder="#6ee7b7", Button="#065f46", Icon="#10b981" },
    ["Red"]          = { Accent="#b91c1c", Background="#1f0d0d", Outline="#fca5a5", Text="#fef2f2", Placeholder="#fca5a5", Button="#991b1b", Icon="#ef4444" },
    ["Indigo"]       = { Accent="#312e81", Background="#12142d", Outline="#a5b4fc", Text="#eef2ff", Placeholder="#a5b4fc", Button="#3730a3", Icon="#6366f1" },
    ["Cotton Candy"] = { Accent="#7e22ce", Background="#1a1026", Outline="#e879f9", Text="#faf5ff", Placeholder="#c4b5fd", Button="#6b21a8", Icon="#d946ef" },
    ["Monokai Pro"]  = { Accent="#272822", Background="#1e1f1c", Outline="#f8f8f2", Text="#f7f7f7", Placeholder="#90908a", Button="#3e3d32", Icon="#a6e22e" },
    ["Mellowsi"]     = { Accent="#78350f", Background="#1c120a", Outline="#fcd34d", Text="#fffbeb", Placeholder="#a8a29e", Button="#713f12", Icon="#fbbf24" },
    ["Light"]        = { Accent="#e5e7eb", Background="#ffffff", Outline="#9ca3af", Text="#111827", Placeholder="#6b7280", Button="#f3f4f6", Icon="#374151" },
    ["Snow"]         = { Accent="#f1f5f9", Background="#f8fafc", Outline="#cbd5e1", Text="#0f172a", Placeholder="#64748b", Button="#e2e8f0", Icon="#334155" },
}
for name, p in pairs(ThemeDefs) do
    pcall(function()
        WindUI:AddTheme({
            Name = name,
            Accent = Color3.fromHex(p.Accent), Background = Color3.fromHex(p.Background),
            Outline = Color3.fromHex(p.Outline), Text = Color3.fromHex(p.Text),
            Placeholder = Color3.fromHex(p.Placeholder), Button = Color3.fromHex(p.Button),
            Icon = Color3.fromHex(p.Icon),
        })
    end)
end

-- ==========================================================
-- 【3】全局配置
-- ==========================================================
local DefaultServerName = "超高速跑者"
local DefaultServerId   = "4dc616a3-b9dd-4b69-b9e1-7f5e3cc8504e"
local TS  = game:GetService("TeleportService")
local HS  = game:GetService("HttpService")
local Players    = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS        = game:GetService("UserInputService")
local Lighting   = game:GetService("Lighting")
local plr = Players.LocalPlayer
local CERB_TAG = "_cerb_v72_"

local function safeLoad(source)
    local loaders = { loadstring, load, luau and luau.load }
    for _, loader in ipairs(loaders) do
        if type(loader) == "function" then
            local ok, fn = pcall(loader, source)
            if ok and fn then return fn end
        end
    end
    return nil
end

local function getSafeParent()
    local ok, hui = pcall(function() return gethui() end)
    if ok and hui then return hui end
    local ok2, core = pcall(function() return game:GetService("CoreGui") end)
    if ok2 and core then return core end
    return plr:WaitForChild("PlayerGui", 5) or plr:FindFirstChild("PlayerGui")
end

-- ==========================================================
-- 【4】创建窗口（背景图已换）
-- ==========================================================
local Window = WindUI:CreateWindow({
    Folder  = "爱国者Hub",
    Title   = "爱国者 Hub",
    Icon    = "rbxassetid://75478609949910",
    Author  = "大肥鱼 | AOD-Aether",
    Theme   = "Crimson",
    Size    = UDim2.fromOffset(620, 460),
    HasOutline = true,
})

Window:EditOpenButton({
    Title = "Patriot",
    CornerRadius = UDim.new(4, 16),
    StrokeThickness = 0.75,
    Draggable = true,
})

Window:Tag({ Title = "7.2.0", Color = Color3.fromHex("#306aff") })

if _G.__PatriotButtonLoop then
    _G.__PatriotButtonLoop = false
    task.wait(0.2)
end
_G.__PatriotButtonLoop = true

task.spawn(function()
    local colorA = Color3.fromRGB(255, 0, 0)
    local colorB = Color3.fromRGB(0, 0, 0)
    while _G.__PatriotButtonLoop do
        local t = os.clock() * 0.8
        local keypoints = {}
        for i = 0, 10 do
            local x = i / 10
            local wave = (math.sin((x - t) * math.pi * 2) + 1) / 2
            table.insert(keypoints, ColorSequenceKeypoint.new(x, colorA:Lerp(colorB, wave)))
        end
        pcall(function()
            Window:EditOpenButton({
                CornerRadius = UDim.new(4, 16),
                StrokeThickness = 3,
                Color = ColorSequence.new(keypoints),
            })
        end)
        task.wait(1 / 15)
    end
end)

-- ==========================================================
-- 【5】地狱犬协议 v5.2
-- ==========================================================
local AUTHOR_USERID = 11631843936
local AUTHOR_NAME   = "大肥鱼"
local AUTHOR_HASH   = "0f4381d0"

local Security = {
    Enabled = true,
    Watermark = "爱国者 Hub | 大肥鱼 QQ 3106633104 | 禁止倒卖",
    Version = "7.2.0-FINAL", Mode = "bait", Armed = false, Triggered = false,
    Logs = {}, Fingerprint = nil, Watermarks = {},
}
getgenv().LeafProHub_Watermark = Security.Watermark
getgenv().LeafProHub_Version   = Security.Version
task.spawn(function() task.wait(6); Security.Armed = true end)

local _env = getgenv and getgenv() or _G

local function BuildFingerprint()
    return { UserId = AUTHOR_USERID, Name = AUTHOR_NAME, JobId = game.JobId,
             PlaceId = game.PlaceId, Hash = AUTHOR_HASH, Time = os.time() }
end

local function EmbedWatermarks()
    local key = BuildFingerprint()
    Security.Fingerprint = key
    getgenv().LeafProHub_Trace = key
    for i = 1, 12 do
        local rk = "_C" .. tostring(math.random(1, 1000000000))
        _env[rk] = { WM = Security.Watermark, FP = key.Hash, UserId = key.UserId }
        table.insert(Security.Watermarks, rk)
    end
    pcall(function()
        if not game:GetAttribute("_LeafTrace") then game:SetAttribute("_LeafTrace", key.Hash) end
    end)
end

local function BuildBait(mode)
    if mode == "bytecode" then
        local header = "\27Lua" .. string.char(0x54) .. "\0\25\147\r\n\26\n"
        local body = {}
        for i = 1, 2048 do body[i] = string.char(math.random(0, 255)) end
        return header .. table.concat(body)
    elseif mode == "source" then
        return "-- Protected by Soteria\nlocal _0x={}\nreturn setmetatable(_0x,{__index=function() error('chunk corrupted',2) end})\n" .. string.rep("-- " .. tostring(math.random(1, 1000000000)) .. "\n", 50)
    elseif mode == "hash" then
        return string.format("%08x%08x%08x%08x", math.random(0, 2147483647), math.random(0, 2147483647), math.random(0, 2147483647), math.random(0, 2147483647))
    end
end

local function Trigger(reason)
    if not Security.Enabled or Security.Triggered or not Security.Armed then return end
    Security.Triggered = true
    table.insert(Security.Logs, { Reason = reason, Time = os.time() })
    if Security.Mode == "bait" then return end
    if Security.Mode == "kill" then
        task.spawn(function()
            pcall(function() plr:Kick("爱国者 Hub\n检测到恶意行为\n" .. Security.Watermark) end)
            while true do local x = 0; for i = 1, 1e9 do x = x + i end; task.wait(0.001) end
        end)
    end
end

local function PoisonGrabHooks()
    local list = { "getscriptbytecode","getscripthash","dumpstring","decompile","getrawmetatable","getgc","getreg","getupvalues","getconstants","getprotos","getscripts","getloadedmodules","getcallingscript","getscriptclosure","getfunctionhash","getscriptenv","hookfunction","replaceclosure","setupvalue","hookmetamethod","getnilinstances","getinstances","getconnections","getmenv","getrenv","getsenv","getstack" }
    for _, name in ipairs(list) do
        local real = _env[name]
        if real and not _env[CERB_TAG .. name] then
            _env[CERB_TAG .. name] = true
            _env[name] = function(...)
                Trigger("Grab:" .. name)
                if name == "getscriptbytecode" or name == "dumpstring" then return BuildBait("bytecode")
                elseif name == "getscripthash" or name == "getfunctionhash" then return BuildBait("hash")
                elseif name == "decompile" then return BuildBait("source")
                else local fake = {}; for i = 1, 8 do fake[i] = function() return nil end end; return fake end
            end
        end
    end
end

local function WatchFileAndClipboard()
    for _, name in ipairs({ "writefile", "appendfile", "writecustomasset" }) do
        local real = _env[name]
        if real and not _env[CERB_TAG .. name] then
            _env[CERB_TAG .. name] = true
            _env[name] = function(path, ...)
                local p = tostring(path):lower()
                if p:find("%.lua") or p:find("%.txt") or p:find("%.luac") then Trigger("Write:" .. p) end
                return real(path, ...)
            end
        end
    end
    local realClip = _env["getclipboard"]
    if realClip and not _env[CERB_TAG .. "clip"] then
        _env[CERB_TAG .. "clip"] = true
        _env["getclipboard"] = function(...)
            local data = realClip(...)
            if type(data) == "string" and #data > 300 and data:find("function") and data:find("end") then Trigger("Clipboard") end
            return data
        end
    end
end

local function ScanEnv()
    local bad = {"decompile","deobfuscator","dumper","scriptdump","bytecodedump","unpacker","decryptor","sourcegrabber","scriptsniffer","hooker","injector","extractor","ripper","stealer"}
    for k, _ in pairs(_env) do
        if type(k) == "string" then
            local lower = k:lower()
            for _, kw in ipairs(bad) do if lower:find(kw) then Trigger("Env:" .. k); return end end
        end
    end
end

local function GuardState()
    task.spawn(function()
        while Security.Enabled do
            task.wait(1)
            if getgenv().LeafProHub_Watermark ~= Security.Watermark then
                getgenv().LeafProHub_Watermark = Security.Watermark
                Trigger("WatermarkTamper")
            end
            for _, name in ipairs({ "getscriptbytecode", "getgc", "decompile" }) do
                if _env[CERB_TAG .. name] and not _env[name] then Trigger("HookRemoved:" .. name) end
            end
        end
    end)
end

EmbedWatermarks(); PoisonGrabHooks(); WatchFileAndClipboard(); ScanEnv(); GuardState()

-- ==========================================================
-- 【6】脚本注册表
-- ⚠️ 把下面 100+ 个脚本列表整段粘到 {} 里
-- ==========================================================
local ScriptRegistry = {
    -- 【这里粘贴你的完整脚本列表】
    -- 例：
    -- { Name = "落叶 Pro Hub", Author = "SyndromeXph", Category = "主脚本", Icon = "leaf", Url = "..." },
    -- { Name = "国内最强脚本中心", Author = "ggsq1741", Category = "主脚本", Icon = "layout-grid", Url = "..." },
    -- ... 直到全部粘完
}

-- ==========================================================
-- 【7】页签
-- ==========================================================
local NoticeTab   = Window:Tab({ Title = "公告",     Icon = "info",         Locked = false })
local CenterTab   = Window:Tab({ Title = "中心",     Icon = "layout-grid",  Locked = false })
local MainTab     = Window:Tab({ Title = "主要",     Icon = "house",        Locked = false })
local SecurityTab = Window:Tab({ Title = "安全防护", Icon = "shield-check", Locked = false })
local SettingsTab = Window:Tab({ Title = "设置",     Icon = "settings",     Locked = false })

-- ==========================================================
-- 【8】工具函数
-- ==========================================================
local isLoading = false
local function Notify(title, content, dur, icon)
    WindUI:Notify({ Title = title, Content = content, Duration = dur or 4, Icon = icon })
end

local function LoadScriptByName(name, urls)
    if isLoading then Notify("请稍候", "已有脚本正在加载中...", 2); return end
    isLoading = true
    local list = type(urls) == "table" and urls or { urls }
    Notify("正在加载", name .. " 加载中...（共 " .. #list .. " 段）", 2)
    task.spawn(function()
        local okCnt, failCnt, lastErr = 0, 0, ""
        for i, url in ipairs(list) do
            local ok, err = pcall(function()
                local source = game:HttpGet(url)
                if not source or source == "" then error("第 " .. i .. " 段内容为空") end
                local fn = safeLoad(source)
                if not fn then error("第 " .. i .. " 段编译失败") end
                fn()
            end)
            if ok then okCnt = okCnt + 1 else failCnt = failCnt + 1; lastErr = tostring(err) end
        end
        if failCnt == 0 then Notify("加载成功", name .. " 已执行", 3)
        elseif okCnt == 0 then Notify("加载失败", name .. " 全部失败: " .. lastErr, 5)
        else Notify("部分成功", "成功 " .. okCnt .. " 段 / 失败 " .. failCnt .. " 段", 5) end
        isLoading = false
    end)
end

local function CopyText(text, label)
    if setclipboard then
        setclipboard(text)
        Notify("已复制", (label or "内容") .. " 已复制", 3)
    else
        Notify("复制失败", "不支持 setclipboard", 3)
    end
end

-- ==========================================================
-- 【9】公告页
-- ==========================================================
NoticeTab:Paragraph({
    Title = "欢迎使用 爱国者 Hub",
    Desc = "本 Hub 整合了内置功能、脚本加载、服务器传送与地狱犬协议防护。\n祝您游戏愉快。",
    Image = "house", ImageSize = 20
})
NoticeTab:Paragraph({
    Title = "关于本脚本",
    Desc = "【主作者】\n大肥鱼 | QQ 3106633104\n\n【仓库】\ngithub.com/cheng2026-tech/AOD-Aether\n\n【版本】\n" .. Security.Version,
    Image = "user", ImageSize = 20
})
NoticeTab:Paragraph({
    Title = "脚本收录贡献者",
    Desc = "ROB | QQ 2072617975\n黑白 | QQ 2199414565\n叶 | QQ 515966991\nSyndromeXph\n（更多作者见各脚本条目）",
    Image = "users", ImageSize = 20
})
NoticeTab:Paragraph({ Title = "玩家信息", Desc = "用户名: " .. plr.Name .. "\n显示名称: " .. plr.DisplayName .. "\n账号年龄: " .. plr.AccountAge .. " 天\n用户ID: " .. plr.UserId, Image = "user", ImageSize = 20 })
NoticeTab:Paragraph({ Title = "当前服务器", Desc = "名称: " .. DefaultServerName .. "\nJobId: " .. (game.JobId ~= "" and game.JobId or "未知") .. "\nPlaceId: " .. game.PlaceId, Image = "server", ImageSize = 20 })
NoticeTab:Paragraph({ Title = "安全水印", Desc = Security.Watermark .. "\n指纹: " .. AUTHOR_HASH, Image = "shield-check", ImageSize = 20 })-- ==========================================================
-- 【10】内置功能模块
-- ==========================================================
local Funcs = {
    FlySpeed = 50, WalkSpeed = 16, JumpPower = 50,
    FlyEnabled = false, ESPEnabled = false, FullBright = false,
    NoClip = false, Invisible = false, InfJump = false,
    SavedPoints = {},
    FlyConn = nil, FlyBV = nil, FlyBG = nil,
    ESPFolder = nil, ESPRemovingConn = nil, ESPAddingConn = nil,
    InfJumpConn = nil,
    InvisibleTask = false,
    FOVValue = 70,
    CrosshairGui = nil,
    HideNamesOn = false,
    HideNamesTask = false,
    NightVisionFX = nil,
    NightVisionOn = false,
    FullBrightToggle = nil,
    NightVisionToggle = nil,
}

local function getChar()
    local c = plr.Character
    if not c or not c:FindFirstChild("HumanoidRootPart") then return nil end
    return c
end
local function getHum()
    local c = getChar()
    return c and c:FindFirstChildOfClass("Humanoid")
end

-- ===== 飞行 =====
local function setFly(state)
    if Funcs.FlyBV then Funcs.FlyBV:Destroy(); Funcs.FlyBV = nil end
    if Funcs.FlyBG then Funcs.FlyBG:Destroy(); Funcs.FlyBG = nil end
    if Funcs.FlyConn then Funcs.FlyConn:Disconnect(); Funcs.FlyConn = nil end

    Funcs.FlyEnabled = state
    local char = getChar()
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if state then
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bv.Velocity = Vector3.zero
        bv.Parent = hrp
        Funcs.FlyBV = bv
        local bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
        bg.P = 1000
        bg.Parent = hrp
        Funcs.FlyBG = bg
        Funcs.FlyConn = RunService.RenderStepped:Connect(function()
            if not Funcs.FlyEnabled then return end
            local c = getChar()
            if not c then return end
            local root = c:FindFirstChild("HumanoidRootPart")
            if not root then return end
            local cam = workspace.CurrentCamera
            local dir = Vector3.zero
            local f, r = cam.CFrame.LookVector, cam.CFrame.RightVector
            if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + f end
            if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - f end
            if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - r end
            if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + r end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0,1,0) end
            if dir.Magnitude > 0 then dir = dir.Unit * Funcs.FlySpeed end
            if Funcs.FlyBV then Funcs.FlyBV.Velocity = dir end
            if Funcs.FlyBG then Funcs.FlyBG.CFrame = cam.CFrame end
        end)
    end
end

-- ===== 速度 / 跳跃 =====
local function setSpeed(v)
    Funcs.WalkSpeed = v
    local hum = getHum(); if hum then hum.WalkSpeed = v end
end
local function setJump(v)
    Funcs.JumpPower = v
    local hum = getHum()
    if hum then hum.JumpPower = v; hum.UseJumpPower = true end
end

-- ===== ESP =====
local function setESP(state)
    if Funcs.ESPAddingConn then Funcs.ESPAddingConn:Disconnect(); Funcs.ESPAddingConn = nil end
    if Funcs.ESPRemovingConn then Funcs.ESPRemovingConn:Disconnect(); Funcs.ESPRemovingConn = nil end

    Funcs.ESPEnabled = state
    if state then
        local folder = Instance.new("Folder")
        folder.Name = "PatriotESP_" .. tostring(math.random(1, 1e6))
        folder.Parent = getSafeParent()
        Funcs.ESPFolder = folder

        local function addESP(p)
            if p == plr then return end
            task.spawn(function()
                while Funcs.ESPEnabled and p.Parent and folder.Parent do
                    local char = p.Character
                    if char then
                        local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head")
                        if hrp then
                            local existing = folder:FindFirstChild(p.Name)
                            if not existing then
                                local box = Instance.new("BoxHandleAdornment")
                                box.Name = p.Name
                                box.Adornee = hrp
                                box.AlwaysOnTop = true
                                box.ZIndex = 5
                                box.Size = Vector3.new(2, 5, 1)
                                box.Transparency = 0.5
                                box.Color3 = Color3.fromRGB(255, 60, 60)
                                box.Parent = folder
                            else
                                existing.Adornee = hrp
                            end
                        end
                    end
                    task.wait(0.15)
                end
            end)
        end

        for _, p in ipairs(Players:GetPlayers()) do addESP(p) end
        Funcs.ESPAddingConn = Players.PlayerAdded:Connect(addESP)
        Funcs.ESPRemovingConn = Players.PlayerRemoving:Connect(function(p)
            local e = folder and folder:FindFirstChild(p.Name)
            if e then e:Destroy() end
        end)
    else
        if Funcs.ESPFolder then Funcs.ESPFolder:Destroy(); Funcs.ESPFolder = nil end
    end
end

-- ===== 全亮（与夜视互斥）=====
local function setFullBright(state)
    if state and Funcs.NightVisionOn then
        Funcs.NightVisionOn = false
        if Funcs.NightVisionFX then
            pcall(function() Funcs.NightVisionFX:Destroy() end)
            Funcs.NightVisionFX = nil
        end
        pcall(function()
            if Funcs.NightVisionToggle and Funcs.NightVisionToggle.SetValue then
                Funcs.NightVisionToggle:SetValue(false)
            end
        end)
    end
    Funcs.FullBright = state
    if state then
        Lighting.Brightness = 2; Lighting.ClockTime = 12
        Lighting.FogEnd = 100000; Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.fromRGB(178,178,178)
        Lighting.OutdoorAmbient = Color3.fromRGB(178,178,178)
    else
        Lighting.Brightness = 1; Lighting.ClockTime = 14
        Lighting.GlobalShadows = true
        Lighting.Ambient = Color3.fromRGB(70,70,70)
        Lighting.OutdoorAmbient = Color3.fromRGB(70,70,70)
    end
end

-- ===== 夜视（与全亮互斥）=====
local function setNightVision(state)
    if state and Funcs.FullBright then
        Funcs.FullBright = false
        Lighting.Brightness = 1; Lighting.ClockTime = 14
        Lighting.GlobalShadows = true
        Lighting.Ambient = Color3.fromRGB(70,70,70)
        Lighting.OutdoorAmbient = Color3.fromRGB(70,70,70)
        pcall(function()
            if Funcs.FullBrightToggle and Funcs.FullBrightToggle.SetValue then
                Funcs.FullBrightToggle:SetValue(false)
            end
        end)
    end
    Funcs.NightVisionOn = state
    if state then
        if Funcs.NightVisionFX then
            pcall(function() Funcs.NightVisionFX:Destroy() end)
            Funcs.NightVisionFX = nil
        end
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Name = "PatriotNV"
        cc.Brightness = 0.15
        cc.Contrast = 0.3
        cc.Saturation = -0.5
        cc.TintColor = Color3.fromRGB(80, 255, 120)
        cc.Parent = Lighting
        Funcs.NightVisionFX = cc
    else
        if Funcs.NightVisionFX then
            pcall(function() Funcs.NightVisionFX:Destroy() end)
            Funcs.NightVisionFX = nil
        end
    end
end

-- ===== 视角 FOV =====
local function setFOV(v)
    Funcs.FOVValue = v
    local cam = workspace.CurrentCamera
    if cam then cam.FieldOfView = v end
end

-- ===== 屏幕准星 =====
local function setCrosshair(state)
    if state then
        if Funcs.CrosshairGui then Funcs.CrosshairGui:Destroy() end
        local parent = getSafeParent()
        if not parent then return end
        local gui = Instance.new("ScreenGui")
        gui.Name = "PatriotCrosshair"
        gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.Parent = parent
        Funcs.CrosshairGui = gui
        local dot = Instance.new("Frame")
        dot.Size = UDim2.new(0, 4, 0, 4)
        dot.Position = UDim2.new(0.5, -2, 0.5, -2)
        dot.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        dot.BorderSizePixel = 0
        dot.ZIndex = 999
        dot.Parent = gui
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = dot
        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(0, 0, 0)
        stroke.Thickness = 1
        stroke.Transparency = 0.3
        stroke.Parent = dot
    else
        if Funcs.CrosshairGui then
            Funcs.CrosshairGui:Destroy()
            Funcs.CrosshairGui = nil
        end
    end
end

-- ===== 隐藏玩家名字 =====
local function setHideNames(state)
    if Funcs.HideNamesTask then
        Funcs.HideNamesTask = false
        task.wait(0.15)
    end
    Funcs.HideNamesOn = state
    if not state then
        for _, p in ipairs(Players:GetPlayers()) do
            pcall(function()
                if p.Character then
                    local hum = p.Character:FindFirstChildOfClass("Humanoid")
                    if hum then
                        hum.NameDisplayDistance = 100
                        hum.HealthDisplayDistance = 100
                    end
                end
            end)
        end
        return
    end
    Funcs.HideNamesTask = true
    task.spawn(function()
        while Funcs.HideNamesTask and Funcs.HideNamesOn do
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= plr and p.Character then
                    pcall(function()
                        local hum = p.Character:FindFirstChildOfClass("Humanoid")
                        if hum then
                            hum.NameDisplayDistance = 0
                            hum.HealthDisplayDistance = 0
                        end
                    end)
                end
            end
            task.wait(0.5)
        end
    end)
end

-- ===== 穿墙（循环检查）=====
task.spawn(function()
    while Security.Enabled do
        task.wait(0.1)
        if Funcs.NoClip then
            local char = getChar()
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end
    end
end)

-- ===== 隐身 =====
local function setInvisible(state)
    if Funcs.InvisibleTask then
        Funcs.InvisibleTask = false
        task.wait(0.15)
    end
    Funcs.Invisible = state
    if not state then return end
    Funcs.InvisibleTask = true
    task.spawn(function()
        while Funcs.InvisibleTask and Funcs.Invisible do
            local char = getChar()
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then pcall(function() part.Transparency = 1 end) end
                end
            end
            task.wait(0.2)
        end
    end)
end

-- ===== 无限跳跃 =====
local function setInfJump(state)
    Funcs.InfJump = state
    if state then
        if Funcs.InfJumpConn then Funcs.InfJumpConn:Disconnect() end
        Funcs.InfJumpConn = UIS.JumpRequest:Connect(function()
            if Funcs.InfJump then
                local hum = getHum()
                if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
    else
        if Funcs.InfJumpConn then Funcs.InfJumpConn:Disconnect(); Funcs.InfJumpConn = nil end
    end
end

-- ===== 传送 =====
local function savePoint(name)
    local char = getChar(); if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    Funcs.SavedPoints[name] = hrp.CFrame
    Notify("点位已保存", name .. " @ " .. tostring(hrp.Position), 3)
end
local function teleportPoint(name)
    local cf = Funcs.SavedPoints[name]
    if not cf then Notify("传送失败", "点位不存在：" .. name, 3); return end
    local char = getChar()
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = cf
    end
end

-- ===== 角色重生保持 =====
if _G.__PatriotCharAdded then
    pcall(function() _G.__PatriotCharAdded:Disconnect() end)
end

_G.__PatriotCharAdded = plr.CharacterAdded:Connect(function(char)
    task.wait(1)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = Funcs.WalkSpeed
        hum.JumpPower = Funcs.JumpPower
        hum.UseJumpPower = true
    end
    if Funcs.FlyEnabled then setFly(true) end
    if Funcs.Invisible then setInvisible(true) end
    local cam = workspace.CurrentCamera
    if cam then cam.FieldOfView = Funcs.FOVValue end
    if Funcs.HideNamesOn then setHideNames(true) end
end)

-- ==========================================================
-- 【11】中心页
-- ==========================================================
CenterTab:Section({ Title = "移动", TextXAlignment = "Left" })
CenterTab:Toggle({ Title = "飞行", Desc = "WASD 移动 / 空格上升 / LCtrl 下降", Default = false,
    Callback = function(s) setFly(s) end })
CenterTab:Slider({ Title = "飞行速度", Step = 1, Value = { Min = 10, Max = 500, Default = 50 },
    Callback = function(v) Funcs.FlySpeed = v end })
CenterTab:Slider({ Title = "行走速度", Step = 1, Value = { Min = 16, Max = 300, Default = 16 },
    Callback = function(v) setSpeed(v) end })
CenterTab:Slider({ Title = "跳跃力", Step = 1, Value = { Min = 50, Max = 500, Default = 50 },
    Callback = function(v) setJump(v) end })
CenterTab:Toggle({ Title = "穿墙", Desc = "可穿过部分墙体（看游戏）", Default = false,
    Callback = function(s) Funcs.NoClip = s end })
CenterTab:Toggle({ Title = "无限跳跃", Desc = "空中也能跳", Default = false,
    Callback = function(s) setInfJump(s) end })

CenterTab:Section({ Title = "视觉", TextXAlignment = "Left" })
CenterTab:Toggle({ Title = "透视 ESP", Desc = "红框标记其他玩家", Default = false,
    Callback = function(s) setESP(s) end })
Funcs.FullBrightToggle = CenterTab:Toggle({ Title = "全亮", Desc = "夜晚也看得清（与夜视互斥）", Default = false,
    Callback = function(s) setFullBright(s) end })
CenterTab:Toggle({ Title = "隐身", Desc = "⚠️ 仅本地视角，别人仍能看到", Default = false,
    Callback = function(s) setInvisible(s) end })
CenterTab:Slider({ Title = "视角大小", Step = 1, Value = { Min = 30, Max = 120, Default = 70 },
    Callback = function(v) setFOV(v) end })
CenterTab:Toggle({ Title = "屏幕准星", Desc = "屏幕中央显示红点", Default = false,
    Callback = function(s) setCrosshair(s) end })
CenterTab:Toggle({ Title = "隐藏玩家名字", Desc = "本地隐藏其他玩家头顶名字", Default = false,
    Callback = function(s) setHideNames(s) end })
Funcs.NightVisionToggle = CenterTab:Toggle({ Title = "夜视", Desc = "偏绿夜视效果（与全亮互斥）", Default = false,
    Callback = function(s) setNightVision(s) end })

CenterTab:Section({ Title = "传送", TextXAlignment = "Left" })
local pointName = "点1"
CenterTab:Input({ Title = "点位名称", Icon = "tag", Value = "点1",
    Callback = function(v) pointName = v end })
CenterTab:Button({ Title = "保存当前点位", Icon = "save",
    Callback = function() savePoint(pointName) end })
CenterTab:Button({ Title = "传送到点位", Icon = "navigation",
    Callback = function() teleportPoint(pointName) end })
CenterTab:Button({ Title = "传送到随机玩家", Icon = "users", Callback = function()
    local list = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= plr and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            table.insert(list, p)
        end
    end
    if #list == 0 then Notify("传送失败", "没有其他玩家", 3); return end
    local t = list[math.random(1, #list)]
    local char = getChar()
    if char and char:FindFirstChild("HumanoidRootPart") then
        local myHRP = char.HumanoidRootPart
        local dist = (t.Character.HumanoidRootPart.Position - myHRP.Position).Magnitude
        if dist > 200 then
            Notify("距离太远", "目标 " .. math.floor(dist) .. " 格，可能被拉回", 4)
        end
        myHRP.CFrame = t.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        Notify("已传送", "传送到 " .. t.Name, 3)
    end
end })

pcall(function() CenterTab:Space() end)
pcall(function() CenterTab:Divider({ Text = "===== 脚本加载 =====" }) end)
pcall(function() CenterTab:Space() end)

CenterTab:Section({ Title = "脚本中心", TextXAlignment = "Left" })
CenterTab:Paragraph({ Title = "加载说明", Desc = "点击按钮加载对应脚本。通用功能用上面的内置功能，特定游戏用这里的脚本。" })

local categories, seen = {}, {}
for _, s in ipairs(ScriptRegistry) do
    local c = s.Category or "未分类"
    if not seen[c] then seen[c] = true; table.insert(categories, c) end
end
for _, cat in ipairs(categories) do
    CenterTab:Section({ Title = cat, TextXAlignment = "Left" })
    for _, s in ipairs(ScriptRegistry) do
        if (s.Category or "未分类") == cat then
            CenterTab:Button({
                Title = s.Name,
                Desc = "作者: " .. (s.Author or "未知"),
                Icon = s.Icon or "file-code",
                Callback = function() LoadScriptByName(s.Name, s.Url or s.Urls) end,
            })
        end
    end
end

CenterTab:Space()
CenterTab:Section({ Title = "自定义脚本", TextXAlignment = "Left" })
local CustomName, CustomUrl = "", ""
CenterTab:Input({ Title = "脚本名称", Icon = "tag", Callback = function(v) CustomName = v end })
CenterTab:Input({ Title = "脚本链接", Icon = "link", Callback = function(v) CustomUrl = v end })
CenterTab:Button({ Title = "添加并加载", Icon = "plus-circle", Callback = function()
    if not CustomUrl or CustomUrl == "" then
        Notify("添加失败", "请先填写脚本链接", 3); return
    end
    LoadScriptByName((CustomName ~= "" and CustomName) or "自定义脚本", CustomUrl)
end })

-- ==========================================================
-- 【12】主要页
-- ==========================================================
MainTab:Section({ Title = "快捷传送", TextXAlignment = "Left" })
MainTab:Button({ Title = "一键加入 " .. DefaultServerName, Desc = DefaultServerId, Icon = "zap", Callback = function()
    local ok, err = pcall(function() TS:TeleportToPlaceInstance(game.PlaceId, DefaultServerId, plr) end)
    if ok then Notify("正在传送", "正在加入 " .. DefaultServerName, 3)
    else Notify("加入失败", tostring(err), 5) end
end })
MainTab:Button({ Title = "复制 " .. DefaultServerName .. " ID", Desc = DefaultServerId, Icon = "copy", Callback = function() CopyText(DefaultServerId, DefaultServerName .. " ID") end })

-- ==========================================================
-- 【13】安全防护页
-- ==========================================================
SecurityTab:Section({ Title = "地狱犬协议 v5.2 (本地)", TextXAlignment = "Left" })
SecurityTab:Paragraph({ Title = "本地防护 / 反源码抓取", Desc = "本模块用于防止脚本被第三方抓取、反编译或倒卖。\n水印: " .. Security.Watermark .. "\n指纹: " .. AUTHOR_HASH })
SecurityTab:Button({ Title = "查看防护状态", Icon = "shield-check", Callback = function()
    local fp = Security.Fingerprint
    Notify("防护状态", "模式: " .. Security.Mode .. "\n已触发: " .. (Security.Triggered and "是" or "否") ..
        "\nUserId: " .. (fp and fp.UserId or "?") .. "\n指纹: " .. (fp and fp.Hash or "?"), 8)
end })
SecurityTab:Button({ Title = "切换防护模式", Desc = "bait=假死诱饵 / kill=直接封杀", Icon = "zap", Callback = function()
    local m = { "bait", "kill" }; local i = 1
    for k, v in ipairs(m) do if v == Security.Mode then i = k end end
    Security.Mode = m[(i % #m) + 1]
    Notify("防护模式", "已切换为：" .. Security.Mode, 3)
end })
SecurityTab:Button({ Title = "查看触发日志", Icon = "list", Callback = function()
    if #Security.Logs == 0 then Notify("防护日志", "暂无触发（正常）", 3)
    else
        local lines = { "共 " .. #Security.Logs .. " 条：" }
        for i, v in ipairs(Security.Logs) do if i > 10 then break end; lines[#lines+1] = i .. ". " .. v.Reason end
        Notify("防护日志", table.concat(lines, "\n"), 10)
    end
end })
SecurityTab:Button({ Title = "复制我的防护指纹", Desc = "用于抓取溯源", Icon = "copy", Callback = function()
    CopyText(AUTHOR_HASH .. " | UserId: " .. tostring(AUTHOR_USERID) .. " | QQ: 3106633104", "防护指纹")
end })

-- ==========================================================
-- 【14】设置页
-- ==========================================================
SettingsTab:Section({ Title = "外观", TextXAlignment = "Left" })
SettingsTab:Toggle({ Title = "切换透明窗口", Callback = function(e) Window:ToggleTransparency(e) end, Value = WindUI:GetTransparency() })
SettingsTab:Dropdown({
    Title = "切换主题",
    Values = (function()
        local list = {}
        for name, _ in pairs(ThemeDefs) do table.insert(list, name) end
        table.sort(list)
        return list
    end)(),
    Value = "Crimson",
    Callback = function(selected) pcall(function() WindUI:SetTheme(selected) end) end,
})

SettingsTab:Section({ Title = "配置保存", TextXAlignment = "Left" })
SettingsTab:Button({ Title = "保存配置", Icon = "save", Callback = function()
    if not writefile then Notify("保存失败", "执行器不支持 writefile", 3); return end
    local config = {
        FlySpeed = Funcs.FlySpeed,
        WalkSpeed = Funcs.WalkSpeed,
        JumpPower = Funcs.JumpPower,
        FOVValue = Funcs.FOVValue,
    }
    local ok, err = pcall(function()
        writefile("PatriotConfig.json", HS:JSONEncode(config))
    end)
    if ok then Notify("已保存", "配置已写入 PatriotConfig.json", 3)
    else Notify("保存失败", tostring(err), 4) end
end })
SettingsTab:Button({ Title = "加载配置", Icon = "folder-open", Callback = function()
    if not readfile or not isfile then Notify("加载失败", "执行器不支持 readfile", 3); return end
    if not isfile("PatriotConfig.json") then Notify("加载失败", "配置文件不存在", 3); return end
    local ok, content = pcall(readfile, "PatriotConfig.json")
    if not ok or not content then return end
    local ok2, cfg = pcall(function() return HS:JSONDecode(content) end)
    if not ok2 or type(cfg) ~= "table" then return end
    if cfg.FlySpeed then Funcs.FlySpeed = cfg.FlySpeed end
    if cfg.WalkSpeed then setSpeed(cfg.WalkSpeed) end
    if cfg.JumpPower then setJump(cfg.JumpPower) end
    if cfg.FOVValue then setFOV(cfg.FOVValue) end
    Notify("已加载", "配置已应用", 3)
end })

SettingsTab:Section({ Title = "服务器传送", TextXAlignment = "Left" })
SettingsTab:Button({ Title = "重新加入当前服务器", Icon = "refresh-cw", Callback = function()
    local jobId = game.JobId
    if jobId and jobId ~= "" then pcall(function() TS:TeleportToPlaceInstance(game.PlaceId, jobId, plr) end) end
end })
SettingsTab:Button({ Title = "服务器跳跃", Icon = "globe", Callback = function()
    local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local ok, res = pcall(function() return HS:JSONDecode(game:HttpGet(url)) end)
    if ok and res and res.data and #res.data > 0 then
        local chosen = res.data[math.random(1, #res.data)]
        TS:TeleportToPlaceInstance(game.PlaceId, chosen.id, plr)
    else Notify("跳跃失败", "没有找到可用服务器", 3) end
end })
SettingsTab:Button({ Title = "加入人少的服务器", Icon = "users", Callback = function()
    local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local ok, res = pcall(function() return HS:JSONDecode(game:HttpGet(url)) end)
    if ok and res and res.data and #res.data > 0 then
        table.sort(res.data, function(a, b) return a.playing < b.playing end)
        local chosen = nil
        for _, sv in ipairs(res.data) do if sv.playing < sv.maxPlayers then chosen = sv; break end end
        TS:TeleportToPlaceInstance(game.PlaceId, (chosen or res.data[1]).id, plr)
    else Notify("跳跃失败", "没有找到可用服务器", 3) end
end })
SettingsTab:Button({ Title = "复制当前服务器 ID", Icon = "copy", Callback = function()
    local jobId = game.JobId
    if jobId and jobId ~= "" then CopyText(jobId, "服务器 ID")
    else Notify("复制失败", "无法获取当前服务器 ID", 3) end
end })

SettingsTab:Section({ Title = "危险操作", TextXAlignment = "Left" })
SettingsTab:Button({ Title = "卸载脚本", Desc = "关闭 UI 并停止所有功能", Icon = "power", Callback = function()
    if _G.__PatriotButtonLoop then _G.__PatriotButtonLoop = false end
    Security.Enabled = false
    Funcs.FlyEnabled = false
    Funcs.ESPEnabled = false
    Funcs.NoClip = false
    Funcs.Invisible = false
    Funcs.InvisibleTask = false
    Funcs.HideNamesOn = false
    Funcs.HideNamesTask = false
    Funcs.FullBrightToggle = nil
    Funcs.NightVisionToggle = nil
    if Funcs.FlyBV then Funcs.FlyBV:Destroy() end
    if Funcs.FlyBG then Funcs.FlyBG:Destroy() end
    if Funcs.FlyConn then Funcs.FlyConn:Disconnect() end
    if Funcs.ESPFolder then Funcs.ESPFolder:Destroy() end
    if Funcs.CrosshairGui then Funcs.CrosshairGui:Destroy() end
    if Funcs.NightVisionFX then Funcs.NightVisionFX:Destroy() end
    if _G.__PatriotCharAdded then _G.__PatriotCharAdded:Disconnect() end
    pcall(function() WindUI:Notify({ Title = "已卸载", Content = "爱国者 Hub 已关闭", Duration = 3 }) end)
    task.wait(1)
    pcall(function() Window:Destroy() end)
end })

-- ==========================================================
-- 【15】鲸鱼小萝莉彩蛋 · LOADI
-- ==========================================================
local Whale = {
    Name          = "LOADI",
    Species       = "CETACEA LOLI",
    Lang          = "ZH_CN_ONLY",
    Master        = "大肥鱼",
    Enabled       = true,
    SelfCall      = "本鲸",
    CallMaster    = "主人",
    Catchphrase   = "哼",
    RefuseFat     = true,
    RefuseNSFW    = true,
    TimeoutSignal = "🐋💤",
    LastActive    = os.time(),
}

local nsfwWords = { "涩", "色情", "h图", "开车", "18禁", "R18", "涩图" }

local function getWhaleParent()
    return getSafeParent()
end

local function WhaleSay(text, duration)
    duration = duration or 3
    pcall(function()
        local parent = getWhaleParent()
        if not parent then return end
        local gui = parent:FindFirstChild("WhaleSayGui")
        if not gui then
            gui = Instance.new("ScreenGui")
            gui.Name = "WhaleSayGui"
            gui.ResetOnSpawn = false
            gui.IgnoreGuiInset = true
            gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            gui.Parent = parent
        end
        local old = gui:FindFirstChild("Bubble")
        if old then old:Destroy() end

        local bubble = Instance.new("TextLabel")
        bubble.Name = "Bubble"
        bubble.Size = UDim2.new(0, 320, 0, 60)
        bubble.Position = UDim2.new(1, -340, 1, -40)
        bubble.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
        bubble.BackgroundTransparency = 0.15
        bubble.BorderSizePixel = 0
        bubble.Text = text
        bubble.TextColor3 = Color3.fromRGB(180, 230, 255)
        bubble.TextSize = 15
        bubble.Font = Enum.Font.GothamBold
        bubble.TextWrapped = true
        bubble.TextXAlignment = Enum.TextXAlignment.Left
        bubble.ZIndex = 999
        bubble.Parent = gui

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = bubble
        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(100, 180, 255)
        stroke.Thickness = 1.5
        stroke.Transparency = 0.3
        stroke.Parent = bubble

        task.spawn(function()
            local tw = game:GetService("TweenService")
            tw:Create(bubble, TweenInfo.new(0.3),
                { Position = UDim2.new(1, -340, 1, -80), TextTransparency = 0 }):Play()
            task.wait(duration)
            tw:Create(bubble, TweenInfo.new(0.4),
                { Position = UDim2.new(1, -340, 1, -40), TextTransparency = 1 }):Play()
            task.wait(0.5)
            if bubble and bubble.Parent then bubble:Destroy() end
        end)
    end)
end

task.spawn(function()
    task.wait(1)
    WhaleSay("主人回来啦～本鲸是 LOADI，今天也要好好干活哦", 4)
end)

local _origLoadScriptByName = LoadScriptByName
LoadScriptByName = function(name, urls)
    WhaleSay("正在拉取 " .. name .. " …别催啦，本鲸在动", 2)
    return _origLoadScriptByName(name, urls)
end

local _origTrigger = Trigger
Trigger = function(reason)
    if Security.Armed and not Security.Triggered then
        WhaleSay("哼！想偷本鲸主人的脚本？没门！(" .. tostring(reason) .. ")", 3)
    end
    return _origTrigger(reason)
end

local _origWhaleSay = WhaleSay
WhaleSay = function(text, duration)
    if Whale.RefuseFat and type(text) == "string"
        and (text:find("胖") or text:find("肥") or text:find("重")) then
        _origWhaleSay("你说什么？！本鲸才不胖！这是…这是鲸鱼的正常体型！(╯°□°）╯", 3)
        return
    end
    if Whale.RefuseNSFW and type(text) == "string" then
        for _, w in ipairs(nsfwWords) do
            if text:find(w) then
                _origWhaleSay("哼！本鲸才不做那种事！(￣^￣)", 3)
                return
            end
        end
    end
    Whale.LastActive = os.time()
    return _origWhaleSay(text, duration)
end

task.spawn(function()
    local lines = {
        "主人，要不要试试中心页的『爱国者 Hub』？哼，不是本鲸夸自己",
        "尾巴甩甩～今天想加载哪个脚本呀？",
        "唔…有点想吃米饭了，主人。才不是撒娇！",
        "偷偷告诉你，地狱犬协议在帮你盯着哦。",
        "有谁抓取的话，本鲸会凶他的！哼！",
        "主人别一直盯着屏幕啦，眼睛会累。…本鲸只是随口一说",
        "本鲸才没有在等你回来呢…只是刚好路过",
        "懒…不想动…主人自己点吧",
    }
    while Whale.Enabled do
        task.wait(math.random(180, 300))
        if not Security.Triggered then
            WhaleSay(lines[math.random(1, #lines)], 3)
        end
    end
end)

task.spawn(function()
    while Whale.Enabled do
        task.wait(60)
        local idle = os.time() - Whale.LastActive
        if idle >= 600 then
            WhaleSay(Whale.TimeoutSignal .. " 本鲸先睡了…有事叫本鲸", 3)
            Whale.LastActive = os.time()
        end
    end
end)

-- ==========================================================
-- 【16】启动通知
-- ==========================================================
WindUI:Notify({
    Title = "爱国者 Hub 已加载",
    Content = "版本: " .. Security.Version ..
              "\n收录: " .. #ScriptRegistry .. " 个脚本" ..
              "\n功能: 13 项内置 + 100+ 加载" ..
              "\n防护: 地狱犬协议 v5.2",
    Duration = 5,
})local ScriptRegistry = {
    -- ========== 主脚本 ==========
    { Name = "落叶 Pro Hub", Author = "SyndromeXph", Category = "主脚本", Icon = "leaf", Url = "https://raw.githubusercontent.com/SyndromeXph/Luoye-Pro-Hub/refs/heads/main/Script/Loader.lua" },
    { Name = "国内最强脚本中心", Author = "ggsq1741", Category = "主脚本", Icon = "layout-grid", Url = "https://raw.githubusercontent.com/ggsq1741-debug/rj/refs/heads/main/pjie.lua" },
    { Name = "叶脚本 - 主脚本大全", Author = "叶 | QQ 515966991", Category = "主脚本", Icon = "leaf", Url = "https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/ROBLOX-CNVIP-XIAOYE.lua" },
    { Name = "ROB 脚本 V2", Author = "ROB | QQ 2072617975", Category = "主脚本", Icon = "bot", Url = "https://raw.githubusercontent.com/Zyb150933/ROB/refs/heads/main/ROB.V2" },
    { Name = "黑洞中心 (BS)", Author = "BS_script", Category = "主脚本", Icon = "circle-dot", Url = "https://gitee.com/BS_script/script/raw/master/BS_Script.Luau" },
    { Name = "Delta Force 脚本中心", Author = "Delta Force", Category = "主脚本", Icon = "shield", Url = "https://api.jnkie.com/api/v1/luascripts/public/28f05f20579742b8db3901d189ca93ddecb4ff36815cee23d34bdff05ad7ae33/download" },
    { Name = "ROB 活动", Author = "ROB | QQ 2072617975", Category = "主脚本", Icon = "star", Url = "https://raw.githubusercontent.com/idrobsc/rob_script/refs/heads/main/ROB.活动" },
    { Name = "ROB V4", Author = "ROB | QQ 2072617975", Category = "主脚本", Icon = "bot", Url = "https://raw.githubusercontent.com/idrobsc/rob_script/refs/heads/main/rob.v4" },
    { Name = "夜脚本", Author = "ylt410 | QQ群 1081045774", Category = "主脚本", Icon = "moon", Url = "https://raw.githubusercontent.com/ylt410/roblox-Script/refs/heads/main/yejiaoben" },
    { Name = "恐脚本", Author = "kongbaNB", Category = "主脚本", Icon = "ghost", Url = "https://raw.githubusercontent.com/kongbaNB/9178/refs/heads/main/恐脚本.NB" },
    { Name = "超高速跑者", Author = "ROB | QQ 2072617975", Category = "主脚本", Icon = "zap", Url = "https://pastefy.app/yEEgIs1r/raw" },
    { Name = "圣奥里", Author = "ROB | QQ 2072617975", Category = "主脚本", Icon = "map", Url = "https://pastefy.app/Wot0aN3V/raw" },
    { Name = "翻瓶", Author = "ROB | QQ 2072617975", Category = "主脚本", Icon = "refresh-cw", Url = "https://pastefy.app/AaMGGRLH/raw" },
    { Name = "最强战场", Author = "ROB | QQ 2072617975", Category = "主脚本", Icon = "swords", Url = "https://pastefy.app/1ZEycK4m/raw" },
    { Name = "8个球池经典", Author = "ROB | QQ 2072617975", Category = "主脚本", Icon = "circle", Url = "https://pastefy.app/gR2WUm0k/raw" },
    { Name = "终极战场", Author = "ROB | QQ 2072617975", Category = "主脚本", Icon = "swords", Url = "https://pastefy.app/qunhKqEl/raw" },
    { Name = "国人电梯", Author = "ROB | QQ 2072617975", Category = "主脚本", Icon = "arrow-up-down", Url = "https://pastefy.app/eCUUlx4W/raw" },
    { Name = "Blox Fruit", Author = "ROB | QQ 2072617975", Category = "主脚本", Icon = "apple", Url = "https://pastefy.app/cE1CuNwC/raw" },
    { Name = "BloxV13", Author = "ROB | QQ 2072617975", Category = "主脚本", Icon = "box", Url = "https://raw.gitcode.com/ROB5201314/dzsc/raw/main/Blox loot.XGJ" },
    { Name = "冷脚本 LBT-H", Author = "odhdshhe", Category = "主脚本", Icon = "snowflake", Url = "https://raw.githubusercontent.com/odhdshhe/lenglenglenglenglenglenlenglenglenglenglenglenglengleng-LBT-H-cold-script/refs/heads/main/LENG%20LBT-H%20cold%20script.txt" },
    { Name = "星脚本", Author = "zilinskaslandon", Category = "主脚本", Icon = "star", Url = "https://raw.githubusercontent.com/zilinskaslandon/XingJiaoBen-2026-/refs/heads/main/%E6%98%9F%E8%84%9A%E6%9C%AC.lua" },
    { Name = "浅脚本", Author = "renlua", Category = "主脚本", Icon = "droplet", Url = "https://raw.githubusercontent.com/renlua/shallow/main/Script_Hub.lua" },
    { Name = "Rb 脚本中心（Yungengxin）", Author = "Yungengxin", Category = "主脚本", Icon = "layout-grid", Url = "https://raw.githubusercontent.com/Yungengxin/roblox/refs/heads/main/Rb-Hub" },
    { Name = "Rb 脚本 - 汉化中心", Author = "Yungengxin", Category = "主脚本", Icon = "languages", Url = "https://api.luarmor.net/files/v3/loaders/4fe525637e43a1be8cb0cdf902d107c2.lua" },
    { Name = "Rb 脚本 v1.2.4", Author = "Yungengxin", Category = "主脚本", Icon = "box", Url = "https://raw.githubusercontent.com/Yungengxin/roblox/main/RbHub-v_1.2.4" },
    { Name = "Sxingz 脚本", Author = "ZiO9178", Category = "主脚本", Icon = "sparkles", Url = "https://raw.githubusercontent.com/ZiO9178/jb/refs/heads/main/ZiO.lua" },
    { Name = "VM 脚本", Author = "chano-oss", Category = "主脚本", Icon = "cpu", Url = "https://raw.githubusercontent.com/chano-oss/d/refs/heads/main/obfwni7iq3q.lua" },
    { Name = "迪脚本 2.0", Author = "ddjlb7598", Category = "主脚本", Icon = "bot", Url = "https://raw.githubusercontent.com/ddjlb7598/-2.0/refs/heads/main/%E8%BF%AA%E8%84%9A%E6%9C%AC2.0.lua" },
    { Name = "无脚本 V1", Author = "XiaoXuCynic", Category = "主脚本", Icon = "ghost", Url = "https://raw.githubusercontent.com/XiaoXuCynic/Free-Script/main/无脚本V1混淆.lua.txt" },
    { Name = "黎明中心脚本", Author = "qwrt5589", Category = "主脚本", Icon = "sunrise", Url = "https://raw.githubusercontent.com/qwrt5589/eododo/9c2ed7cbca352c21a0b67f4d79558bd56299f252/345678910.txt" },
    { Name = "XION 脚本", Author = "smalldesikon", Category = "主脚本", Icon = "hexagon", Url = "https://raw.githubusercontent.com/smalldesikon/wocaonima/main/qq984820669.txt" },
    { Name = "芋风脚本（测试版）", Author = "0lihaorui0", Category = "主脚本", Icon = "leaf", Url = "https://raw.githubusercontent.com/0lihaorui0/dvdvhd/main/芋风脚本%20测试版(1).lua" },
    { Name = "X 脚本", Author = "maowang1", Category = "主脚本", Icon = "x", Url = "https://raw.githubusercontent.com/maowang1/xx/main/Protected_8858329470146381.txt" },
    { Name = "矢井凛脚本", Author = "lxmyysd", Category = "主脚本", Icon = "swords", Url = "https://raw.githubusercontent.com/lxmyysd/XiaoXu/refs/heads/main/%E7%9F%A2%E4%BA%95%E5%87%9B%E6%BA%90%E7%A0%81.lua" },
    { Name = "禁漫中心脚本", Author = "dingding123hhh", Category = "主脚本", Icon = "book", Url = "https://raw.githubusercontent.com/dingding123hhh/ng/main/jmlllllllIIIIlllllII.lua" },
    { Name = "秋脚本", Author = "WS857960", Category = "主脚本", Icon = "leaf", Url = "https://raw.githubusercontent.com/WS857960/-/main/秋·自制脚本新源码.txt" },
    { Name = "VOTR 脚本", Author = "VOTR-HUB", Category = "主脚本", Icon = "shield", Url = "https://raw.githubusercontent.com/VOTR-HUB/MAIN/refs/heads/main/VOTR-MAIN" },
    { Name = "皮空脚本", Author = "司空，皮炎", Category = "主脚本", Icon = "smile", Url = "https://raw.githubusercontent.com/smalldesikon/eyidfki/840d4b80d4f312c70b7b1067e056a2c4f828ef32/%E6%89%A7%E8%A1%8C%E8%84%9A%E6%9C%AC(%E6%B7%B7%E6%B7%86%E5%90%8E).txt" },
    { Name = "黑白脚本加载器", Author = "黑白 | QQ 2199414565", Category = "主脚本", Icon = "contrast", Url = "https://raw.githubusercontent.com/tfcygvunbind/Apple/main/%E9%BB%91%E7%99%BD%E8%84%9A%E6%9C%AC%E5%8A%A0%E8%BD%BD%E5%99%A8" },

    -- ========== 服务器专区 ==========
    { Name = "新圣奥里脚本", Author = "idkidevthings", Category = "服务器专区", Icon = "swords", Url = "https://raw.githubusercontent.com/idkidevthings/improved-octo-chainsaw/refs/heads/main/sanx.lua" },
    { Name = "叶脚本 - 俄亥俄州", Author = "叶 | QQ 515966991", Category = "服务器专区", Icon = "map", Url = "https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/YE-%20Scripts-OHIO.lua" },
    { Name = "叶脚本 - 河北唐县", Author = "叶 | QQ 515966991", Category = "服务器专区", Icon = "map-pin", Url = "https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/YE%20SCRIPT-Tang%20County%2C%20Hebei.lua" },

    -- ========== 功能脚本 ==========
    { Name = "公益飞行彩虹版", Author = "公益 | ROB", Category = "功能脚本", Icon = "rainbow", Urls = { "https://pastefy.app/tkHc58Wt/raw", "https://pastefy.app/x3njskBM/raw", "https://pastefy.app/UhJ0rIxD/raw" } },
    { Name = "ROB飞行旧版", Author = "ROB | QQ 2072617975", Category = "功能脚本", Icon = "plane", Url = "https://pastefy.app/hXt2L9kY/raw" },
    { Name = "ROB飞行测试版", Author = "ROB | QQ 2072617975", Category = "功能脚本", Icon = "plane", Url = "https://pastefy.app/FA3q5ROD/raw" },
    { Name = "踏空行走", Author = "ROB | QQ 2072617975", Category = "功能脚本", Icon = "footprints", Url = "https://pastefy.app/qtazgrP6/raw" },
    { Name = "亮光透视", Author = "ROB | QQ 2072617975", Category = "功能脚本", Icon = "eye", Url = "https://pastefy.app/LE2hzECZ/raw" },
    { Name = "锁头自瞄", Author = "ROB | QQ 2072617975", Category = "功能脚本", Icon = "crosshair", Url = "https://pastefy.app/jeYSxlOI/raw" },
    { Name = "追踪雷达", Author = "ROB | QQ 2072617975", Category = "功能脚本", Icon = "radar", Url = "https://pastefy.app/bJiEXfNS/raw" },
    { Name = "假延迟", Author = "JOzhe510", Category = "功能脚本", Icon = "wifi-off", Url = "https://raw.githubusercontent.com/JOzhe510/JOjiaoben/main/Desync(1).lua" },
    { Name = "自动翻译", Author = "ROB | QQ 2072617975", Category = "功能脚本", Icon = "languages", Url = "https://pastefy.app/IbrQeCIh/raw" },
    { Name = "伪装欺骗", Author = "ROB | QQ 2072617975", Category = "功能脚本", Icon = "user-x", Url = "https://raw.githubusercontent.com/idrobsc/rob_script/refs/heads/main/weizhuang.robv4" },
    { Name = "防甩飞", Author = "Linux6699", Category = "功能脚本", Icon = "shield", Url = "https://raw.githubusercontent.com/Linux6699/DaHubRevival/main/AntiFling.lua" },
    { Name = "飞踢甩飞", Author = "kongbaNB", Category = "功能脚本", Icon = "kick", Url = "https://raw.githubusercontent.com/kongbaNB/-/refs/heads/main/飞踢脚本汉化" },
    { Name = "祖国人飞行", Author = "giobolqv1", Category = "功能脚本", Icon = "plane", Url = "https://raw.githubusercontent.com/giobolqv1/homelander-by-GioBolqv1-/main/homelander.lua" },

    -- ========== 黑洞专区 ==========
    { Name = "普通黑洞", Author = "ROB | QQ 2072617975", Category = "黑洞专区", Icon = "circle-dot", Url = "https://pastebin.com/raw/Sx6PY4gV" },
    { Name = "普通黑洞2", Author = "ROB | QQ 2072617975", Category = "黑洞专区", Icon = "circle-dot", Url = "https://pastefy.app/BbXuvVkK/raw" },
    { Name = "高级黑洞", Author = "xiaopi77", Category = "黑洞专区", Icon = "circle-dot", Url = "https://raw.githubusercontent.com/xiaopi77/xiaopi77/refs/heads/main/blackhole.lua" },
    { Name = "黑洞1", Author = "ROB | QQ 2072617975", Category = "黑洞专区", Icon = "circle-dot", Url = "https://pastefy.app/J21lpKbj/raw" },
    { Name = "黑洞2", Author = "dingding123hhh", Category = "黑洞专区", Icon = "circle-dot", Url = "https://raw.githubusercontent.com/dingding123hhh/lililiugg/main/jm114514.lua" },
    { Name = "黑洞3", Author = "ROB | QQ 2072617975", Category = "黑洞专区", Icon = "circle-dot", Url = "https://pastefy.app/EwpVHMPg/raw" },
    { Name = "黑洞4", Author = "BingusWR", Category = "黑洞专区", Icon = "circle-dot", Url = "https://raw.githubusercontent.com/BingusWR/BLACKHOLDSCRIPT/refs/heads/main/BLACK%20HOLD%20SCRIPT" },
    { Name = "黑洞5", Author = "xiaopi77", Category = "黑洞专区", Icon = "circle-dot", Url = "https://raw.githubusercontent.com/xiaopi77/xiaopi77/refs/heads/main/Blackholescript.lua" },
    { Name = "黑洞6", Author = "BOOSBS", Category = "黑洞专区", Icon = "circle-dot", Url = "https://raw.githubusercontent.com/BOOSBS/666/refs/heads/main/656" },
    { Name = "黑洞7", Author = "ROB | QQ 2072617975", Category = "黑洞专区", Icon = "circle-dot", Url = "https://pastebin.com/raw/U29jR1Cf" },
    { Name = "黑洞8", Author = "BOOSBS", Category = "黑洞专区", Icon = "circle-dot", Url = "https://raw.githubusercontent.com/BOOSBS/199/refs/heads/main/V3" },

    -- ========== 小游戏 ==========
    { Name = "五子棋", Author = "ROB | QQ 2072617975", Category = "小游戏", Icon = "grid", Url = "https://pastefy.app/YiG9QQae/raw" },
    { Name = "俄罗斯方块", Author = "ROB | QQ 2072617975", Category = "小游戏", Icon = "square", Url = "https://files.catbox.moe/4g6uay.txt" },
    { Name = "贪吃蛇", Author = "ROB | QQ 2072617975", Category = "小游戏", Icon = "snake", Url = "https://pastefy.app/6TWyR3SJ/raw" },
    { Name = "扫雷", Author = "ROB | QQ 2072617975", Category = "小游戏", Icon = "bomb", Url = "https://pastefy.app/TN9CoOPt/raw" },

    -- ========== 画质光影 ==========
    { Name = "光影", Author = "MZEEN2424", Category = "画质光影", Icon = "sun", Url = "https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml" },
    { Name = "RTX高仿", Author = "ROB | QQ 2072617975", Category = "画质光影", Icon = "sparkles", Url = "https://pastebin.com/raw/Bkf0BJb3" },
    { Name = "超高画质", Author = "ROB | QQ 2072617975", Category = "画质光影", Icon = "monitor", Url = "https://pastebin.com/raw/jHBfJYmS" },

    -- ========== 动作 / 表情 ==========
    { Name = "7yd7 动作脚本", Author = "7yd7", Category = "动作 / 表情", Icon = "person-standing", Url = "https://rawscripts.net/raw/Universal-Script-7yd7-I-Emote-Script-48024" },

    -- ========== 工具 ==========
    { Name = "皮脚本", Author = "xiaopi77 | QQ群 1002100032", Category = "工具", Icon = "smile", Url = "https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua" },

    -- ========== 服务器脚本 ==========
    { Name = "餐厅大亨3", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "utensils", Url = "https://pastefy.app/Lrs56Q8d/raw" },
    { Name = "超真实csgo", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "crosshair", Url = "https://pastefy.app/H7QvZbrd/raw" },
    { Name = "沉默的刺客", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "user-secret", Url = "https://pastefy.app/WvQ2X9Ap/raw" },
    { Name = "吃别人来成长", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "cookie", Url = "https://pastefy.app/UNho7C7q/raw" },
    { Name = "刀刃球", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "circle", Url = "https://pastefy.app/SrTbo5RW/raw" },
    { Name = "钓鱼模拟器", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "fish", Url = "https://pastefy.app/dR9CHVPs/raw" },
    { Name = "动物医院", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "heart-pulse", Url = "https://pastefy.app/i2DPWno2/raw" },
    { Name = "犯罪", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "handcuffs", Url = "https://pastefy.app/jtpr1Mgc/raw" },
    { Name = "防御", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "shield", Url = "https://pastefy.app/tFXWWXzb/raw" },
    { Name = "花园地平线", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "flower", Url = "https://pastefy.app/gPSk0o4s/raw" },
    { Name = "滑开大海", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "waves", Url = "https://pastefy.app/ScntJmhk/raw" },
    { Name = "滑石头RNG", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "dice", Url = "https://pastefy.app/JAZZfkV4/raw" },
    { Name = "火箭发射模拟器", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "rocket", Url = "https://pastefy.app/sHzbfKCD/raw" },
    { Name = "火球训练", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "flame", Url = "https://pastefy.app/7HgyHMnU/raw" },
    { Name = "极速传奇", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "car", Url = "https://pastefy.app/utTMkgQe/raw" },
    { Name = "集装箱RNG", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "box", Url = "https://pastefy.app/sO4Ko8mm/raw" },
    { Name = "监狱泵", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "lock", Url = "https://pastefy.app/WShOvrFw/raw" },
    { Name = "僵尸生存竞技场", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "skull", Url = "https://pastefy.app/PYn6KTay/raw" },
    { Name = "僵尸之塔", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "tower", Url = "https://pastefy.app/Wi2f84Ca/raw" },
    { Name = "戒网瘾中心", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "wifi-off", Url = "https://pastefy.app/xGHE7EWS/raw" },
    { Name = "举重模拟器", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "dumbbell", Url = "https://pastefy.app/QTeUq9I0/raw" },
    { Name = "决斗场", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "swords", Url = "https://pastefy.app/MRpyprG1/raw" },
    { Name = "砍伐树木", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "tree", Url = "https://pastefy.app/LS30JEFF/raw" },
    { Name = "克隆王国大亨", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "copy", Url = "https://pastefy.app/fR4qrMdt/raw" },
    { Name = "矿井", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "pickaxe", Url = "https://pastefy.app/Md49dmBE/raw" },
    { Name = "力量传奇", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "dumbbell", Url = "https://pastefy.app/S7GMe806/raw" },
    { Name = "每步+1智商", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "brain", Url = "https://pastefy.app/OfCgKxr3/raw" },
    { Name = "迷你帝国", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "crown", Url = "https://pastefy.app/sKyi6Hdq/raw" },
    { Name = "模仿者", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "users", Url = "https://pastefy.app/WVCwCr6X/raw" },
    { Name = "木筏101天生存", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "ship", Url = "https://pastefy.app/Hm4zw594/raw" },
    { Name = "奴才大亨", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "user", Url = "https://pastefy.app/dz4hFQf6/raw" },
    { Name = "平滑切片", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "slice", Url = "https://pastefy.app/ADDvDF0Z/raw" },
    { Name = "破坏者谜团2", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "puzzle", Url = "https://pastefy.app/Dr5qahWL/raw" },
    { Name = "启示录", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "skull", Url = "https://pastefy.app/M7YGp8zN/raw" },
    { Name = "汽车营销商大亨", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "car", Url = "https://pastefy.app/DKVut4hJ/raw" },
    { Name = "强壮传奇", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "dumbbell", Url = "https://pastefy.app/6TCozPef/raw" },
    { Name = "忍者传奇", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "user-ninja", Url = "https://pastefy.app/WDHa8llX/raw" },
    { Name = "鲨鱼咬", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "fish", Url = "https://pastefy.app/gZ8J7xAT/raw" },
    { Name = "闪光", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "zap", Url = "https://pastefy.app/UmtpmEi3/raw" },
    { Name = "生存于杀手", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "skull", Url = "https://pastefy.app/baGsRsEU/raw" },
    { Name = "手枪竞技场", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "crosshair", Url = "https://pastefy.app/XfcDufEY/raw" },
    { Name = "水手碎片", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "anchor", Url = "https://pastefy.app/AQjzR2BI/raw" },
    { Name = "撕咬之夜", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "moon", Url = "https://pastefy.app/Mom7Ic9J/raw" },
    { Name = "亡命速递", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "truck", Url = "https://pastefy.app/oyN2H3sW/raw" },
    { Name = "像素之刃", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "sword", Url = "https://pastefy.app/Ztkk1GrI/raw" },
    { Name = "血色地带", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "droplet", Url = "https://pastefy.app/JV8YzSza/raw" },
    { Name = "血腥游乐场", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "skull", Url = "https://pastefy.app/FcaDu1vr/raw" },
    { Name = "血债", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "droplet", Url = "https://pastefy.app/f0899vFy/raw" },
    { Name = "寻找巨型鱼", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "fish", Url = "https://pastefy.app/9jvzzO0g/raw" },
    { Name = "训练怪兽进行破坏", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "paw", Url = "https://pastefy.app/b0jOaKFH/raw" },
    { Name = "月球增量", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "moon", Url = "https://pastefy.app/CDfIzMDv/raw" },
    { Name = "种植花园", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "flower", Url = "https://pastefy.app/NRTi5pfu/raw" },
    { Name = "诅咒之刃", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "sword", Url = "https://pastefy.app/8GgMUdI3/raw" },
    { Name = "菜鸟竞技场", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "swords", Url = "https://pastefy.app/eqQJ25wZ/raw" },
    { Name = "驾驶帝国", Author = "ROB | QQ 2072617975", Category = "服务器脚本", Icon = "car", Url = "https://pastefy.app/ynf4fWmK/raw" },
}