-- ==========================================================
-- 黑曜石 UI · 简体中文整改版
-- 作者：大肥鱼
-- 特性：自动展开 / 中文界面 / 代理加速 / 快捷键 G
-- ==========================================================

-- ==================== 网络代理 ====================
local repo = "https://gh-proxy.com/https://raw.githubusercontent.com/JanseJYC/Script/refs/heads/UI/"

local function safeHttpGet(url)
    local ok, res = pcall(function()
        return game:HttpGet(url)
    end)
    if not ok or type(res) ~= "string" or res == "" then
        return nil
    end
    return res
end

print("═══════ 黑曜石 UI 加载中 ═══════")

-- ==================== 拉取库 ====================
local libSrc = safeHttpGet(repo .. "Library.lua")
if not libSrc then warn("[黑曜石] Library.lua 加载失败"); return end
print("[1] Library.lua 长度: " .. #libSrc)

local themeSrc = safeHttpGet(repo .. "ThemeManager.lua")
if not themeSrc then warn("[黑曜石] ThemeManager.lua 加载失败"); return end

local saveSrc = safeHttpGet(repo .. "SaveManager.lua")
if not saveSrc then warn("[黑曜石] SaveManager.lua 加载失败"); return end

-- ==================== 编译库 ====================
local Library = loadstring(libSrc)()
if not Library then warn("[黑曜石] Library 编译失败"); return end

local ThemeManager = loadstring(themeSrc)()
if not ThemeManager then warn("[黑曜石] ThemeManager 编译失败"); return end

local SaveManager = loadstring(saveSrc)()
if not SaveManager then warn("[黑曜石] SaveManager 编译失败"); return end

ThemeManager:SetLibrary(Library)

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true

-- ==================== 创建窗口 ====================
local Window = Library:CreateWindow({
    Title = "画图",
    Footer = "版本: 整改版",
    Icon = 95816097006870,
    NotifySide = "Right",
    ShowCustomCursor = true,
})

-- ==================== 自动展开窗口 ====================
-- 黑曜石窗口默认是折叠的，用小标签显示
-- 这段代码会找到那个标签并模拟点击，让窗口自动展开
task.spawn(function()
    for attempt = 1, 15 do
        task.wait(0.3)
        local found = false

        -- 遍历所有容器找那个折叠按钮
        local containers = {}
        pcall(function() table.insert(containers, game:GetService("CoreGui")) end)
        pcall(function() table.insert(containers, gethui()) end)
        pcall(function() table.insert(containers, game.Players.LocalPlayer.PlayerGui) end)

        for _, container in ipairs(containers) do
            if container then
                for _, obj in ipairs(container:GetDescendants()) do
                    -- 找带标题文字的按钮
                    if (obj:IsA("TextButton") or obj:IsA("ImageButton")) and obj.Visible then
                        local text = ""
                        pcall(function() text = obj.Text or "" end)
                        if text == "画图" or text == "测试窗口" or text == "mspaint" then
                            pcall(function()
                                if firesignal then
                                    firesignal(obj.MouseButton1Click)
                                else
                                    obj:Activate()
                                end
                            end)
                            print("[自动展开] 已点击折叠标签: " .. text)
                            found = true
                            break
                        end
                    end

                    -- 找 Frame 标题（有些版本用 Frame）
                    if obj:IsA("Frame") and obj.Visible then
                        local label = obj:FindFirstChildWhichIsA("TextLabel")
                        if label and label.Visible then
                            local text = ""
                            pcall(function() text = label.Text or "" end)
                            if text == "画图" or text == "测试窗口" then
                                pcall(function()
                                    local btn = obj:FindFirstChildWhichIsA("TextButton")
                                    if btn then
                                        if firesignal then
                                            firesignal(btn.MouseButton1Click)
                                        else
                                            btn:Activate()
                                        end
                                    end
                                end)
                                print("[自动展开] 已点击折叠标签: " .. text)
                                found = true
                                break
                            end
                        end
                    end
                end
            end
            if found then break end
        end

        if found then break end
    end
end)

-- ==================== 主题 ====================
ThemeManager.BuiltInThemes["Default"][2] = {
    FontColor = "ffffff",
    MainColor = "191919",
    AccentColor = "ffffff",
    BackgroundColor = "000000",
    OutlineColor = "ffffff",
    FontFace = "RobotoMono"
}

ThemeManager:ApplyTheme("Default")

-- ==================== 页签 ====================
local Tabs = {
    Main = Window:AddTab("主要", "user"),
    Key = Window:AddKeyTab("密钥系统"),
    ["UI Settings"] = Window:AddTab("界面设置", "settings"),
}

local LeftGroupBox = Tabs.Main:AddLeftGroupbox("分组框", "boxes")

-- ==================== 开关 + 颜色选择器 ====================
LeftGroupBox:AddToggle("MyToggle", {
    Text = "这是一个开关",
    Tooltip = "这是一个提示",
    DisabledTooltip = "我已禁用！",
    Default = true,
    Disabled = false,
    Visible = true,
    Risky = false,
    Callback = function(Value)
        print("[回调] MyToggle 改变为:", Value)
    end,
})
    :AddColorPicker("ColorPicker1", {
        Default = Color3.new(1, 0, 0),
        Title = "颜色1",
        Transparency = 0,
        Callback = function(Value)
            print("[回调] 颜色改变！", Value)
        end,
    })
    :AddColorPicker("ColorPicker2", {
        Default = Color3.new(0, 1, 0),
        Title = "颜色2",
        Callback = function(Value)
            print("[回调] 颜色改变！", Value)
        end,
    })

Toggles.MyToggle:OnChanged(function()
    print("MyToggle 改变为:", Toggles.MyToggle.Value)
end)

Toggles.MyToggle:SetValue(false)

-- ==================== 复选框 ====================
LeftGroupBox:AddCheckbox("MyCheckbox", {
    Text = "这是一个复选框",
    Tooltip = "这是一个提示",
    DisabledTooltip = "我已禁用！",
    Default = true,
    Disabled = false,
    Visible = true,
    Risky = false,
    Callback = function(Value)
        print("[回调] MyCheckbox 改变为:", Value)
    end,
})

Toggles.MyCheckbox:OnChanged(function()
    print("MyCheckbox 改变为:", Toggles.MyCheckbox.Value)
end)

-- ==================== 按钮 ====================
local MyButton = LeftGroupBox:AddButton({
    Text = "按钮",
    Func = function()
        print("你点击了一个按钮！")
    end,
    DoubleClick = false,
    Tooltip = "这是主按钮",
    DisabledTooltip = "我已禁用！",
    Disabled = false,
    Visible = true,
    Risky = false,
})

local MyButton2 = MyButton:AddButton({
    Text = "子按钮",
    Func = function()
        print("你点击了一个子按钮！")
    end,
    DoubleClick = true,
    Tooltip = "这是子按钮",
    DisabledTooltip = "我已禁用！",
})

local MyDisabledButton = LeftGroupBox:AddButton({
    Text = "禁用按钮",
    Func = function()
        print("你竟然点到了禁用按钮！")
    end,
    DoubleClick = false,
    Tooltip = "这是一个禁用按钮",
    DisabledTooltip = "我已禁用！",
    Disabled = true,
})

-- ==================== 标签 ====================
LeftGroupBox:AddLabel("这是一个标签")
LeftGroupBox:AddLabel("这是一个标签\n\n它会自动换行！", true)
LeftGroupBox:AddLabel("这是一个暴露给 Labels 的标签", true, "TestLabel")
LeftGroupBox:AddLabel("SecondTestLabel", {
    Text = "这是一个使用表选项和索引的标签",
    DoesWrap = true,
})
LeftGroupBox:AddLabel("SecondTestLabel", {
    Text = "这是一个不会自动换行的标签",
    DoesWrap = false,
})

LeftGroupBox:AddDivider()

-- ==================== 滑块 ====================
LeftGroupBox:AddSlider("MySlider", {
    Text = "这是我的滑块！",
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        print("[回调] 滑块改变！新值:", Value)
    end,
    Tooltip = "我是一个滑块！",
    DisabledTooltip = "我已禁用！",
    Disabled = false,
    Visible = true,
})

local Number = Options.MySlider.Value
Options.MySlider:OnChanged(function()
    print("滑块改变！新值:", Options.MySlider.Value)
end)

Options.MySlider:SetValue(3)

LeftGroupBox:AddSlider("MySlider2", {
    Text = "这是我的自定义显示滑块！",
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 0,
    Compact = false,
    FormatDisplayValue = function(slider, value)
        if value == slider.Max then return '全部' end
        if value == slider.Min then return '无' end
    end,
    Tooltip = "我是一个滑块！",
    DisabledTooltip = "我已禁用！",
    Disabled = false,
    Visible = true,
})

-- ==================== 文本框 ====================
LeftGroupBox:AddInput("MyTextbox", {
    Default = "我的文本框！",
    Numeric = false,
    Finished = false,
    ClearTextOnFocus = true,
    Text = "这是一个文本框",
    Tooltip = "这是一个提示",
    Placeholder = "占位文字",
    Callback = function(Value)
        print("[回调] 文本更新。新文本:", Value)
    end,
})

Options.MyTextbox:OnChanged(function()
    print("文本更新。新文本:", Options.MyTextbox.Value)
end)

-- ==================== 下拉框 ====================
local DropdownGroupBox = Tabs.Main:AddRightGroupbox("下拉框")

DropdownGroupBox:AddDropdown("MyDropdown", {
    Values = { "这个", "是", "一个", "下拉框" },
    Default = 1,
    Multi = false,
    Text = "一个下拉框",
    Tooltip = "这是一个提示",
    DisabledTooltip = "我已禁用！",
    Searchable = false,
    Callback = function(Value)
        print("[回调] 下拉框改变。新值:", Value)
    end,
    Disabled = false,
    Visible = true,
})

Options.MyDropdown:OnChanged(function()
    print("下拉框改变。新值:", Options.MyDropdown.Value)
end)

Options.MyDropdown:SetValue("这个")

DropdownGroupBox:AddDropdown("MySearchableDropdown", {
    Values = { "这个", "是", "一个", "可搜索的", "下拉框" },
    Default = 1,
    Multi = false,
    Text = "一个可搜索的下拉框",
    Tooltip = "这是一个提示",
    DisabledTooltip = "我已禁用！",
    Searchable = true,
    Callback = function(Value)
        print("[回调] 下拉框改变。新值:", Value)
    end,
    Disabled = false,
    Visible = true,
})

DropdownGroupBox:AddDropdown("MyDisplayFormattedDropdown", {
    Values = { "这个", "是", "一个", "格式化的", "下拉框" },
    Default = 1,
    Multi = false,
    Text = "一个显示格式化的下拉框",
    Tooltip = "这是一个提示",
    DisabledTooltip = "我已禁用！",
    FormatDisplayValue = function(Value)
        if Value == "格式化的" then
            return "显示格式化"
        end
        return Value
    end,
    Searchable = false,
    Callback = function(Value)
        print("[回调] 显示格式化的下拉框改变。新值:", Value)
    end,
    Disabled = false,
    Visible = true,
})

DropdownGroupBox:AddDropdown("MyMultiDropdown", {
    Values = { "这个", "是", "一个", "下拉框" },
    Default = 1,
    Multi = true,
    Text = "一个多选下拉框",
    Tooltip = "这是一个提示",
    Callback = function(Value)
        print("[回调] 多选下拉框改变:")
        for key, value in next, Options.MyMultiDropdown.Value do
            print(key, value)
        end
    end,
})

Options.MyMultiDropdown:SetValue({
    这个 = true,
    是 = true,
})

DropdownGroupBox:AddDropdown("MyDisabledDropdown", {
    Values = { "这个", "是", "一个", "下拉框" },
    Default = 1,
    Multi = false,
    Text = "一个禁用的下拉框",
    Tooltip = "这是一个提示",
    DisabledTooltip = "我已禁用！",
    Callback = function(Value)
        print("[回调] 禁用的下拉框改变。新值:", Value)
    end,
    Disabled = true,
    Visible = true,
})

DropdownGroupBox:AddDropdown("MyDisabledValueDropdown", {
    Values = { "这个", "是", "一个", "下拉框", "带有", "禁用的", "值" },
    DisabledValues = { "禁用的" },
    Default = 1,
    Multi = false,
    Text = "一个带有禁用值的下拉框",
    Tooltip = "这是一个提示",
    DisabledTooltip = "我已禁用！",
    Callback = function(Value)
        print("[回调] 带有禁用值的下拉框改变。新值:", Value)
    end,
    Disabled = false,
    Visible = true,
})

DropdownGroupBox:AddDropdown("MyVeryLongDropdown", {
    Values = {
        "这个", "是", "一个", "非常", "长的", "下拉框", "里面", "有", "很多", "值", "但是", "你", "可以", "看到", "超过", "8", "个", "值"
    },
    Default = 1,
    Multi = false,
    MaxVisibleDropdownItems = 12,
    Text = "一个非常长的下拉框",
    Tooltip = "这是一个提示",
    DisabledTooltip = "我已禁用！",
    Searchable = false,
    Callback = function(Value)
        print("[回调] 非常长的下拉框改变。新值:", Value)
    end,
    Disabled = false,
    Visible = true,
})

DropdownGroupBox:AddDropdown("MyPlayerDropdown", {
    SpecialType = "Player",
    ExcludeLocalPlayer = true,
    Text = "一个玩家下拉框",
    Tooltip = "这是一个提示",
    Callback = function(Value)
        print("[回调] 玩家下拉框改变:", Value)
    end,
})

DropdownGroupBox:AddDropdown("MyTeamDropdown", {
    SpecialType = "Team",
    Text = "一个队伍下拉框",
    Tooltip = "这是一个提示",
    Callback = function(Value)
        print("[回调] 队伍下拉框改变:", Value)
    end,
})

-- ==================== 颜色选择器 ====================
LeftGroupBox:AddLabel("颜色"):AddColorPicker("ColorPicker", {
    Default = Color3.new(0, 1, 0),
    Title = "某个颜色",
    Transparency = 0,
    Callback = function(Value)
        print("[回调] 颜色改变！", Value)
    end,
})

Options.ColorPicker:OnChanged(function()
    print("颜色改变！", Options.ColorPicker.Value)
    print("透明度改变！", Options.ColorPicker.Transparency)
end)

Options.ColorPicker:SetValueRGB(Color3.fromRGB(0, 255, 140))

-- ==================== 快捷键 ====================
LeftGroupBox:AddLabel("快捷键"):AddKeyPicker("KeyPicker", {
    Default = "MB2",
    SyncToggleState = false,
    Mode = "Toggle",
    Text = "自动开锁保险箱",
    NoUI = false,
    Callback = function(Value)
        print("[回调] 快捷键点击！", Value)
    end,
    ChangedCallback = function(NewKey, NewModifiers)
        print("[回调] 快捷键改变！", NewKey, table.unpack(NewModifiers or {}))
    end,
})

Options.KeyPicker:OnClick(function()
    print("快捷键点击！", Options.KeyPicker:GetState())
end)

Options.KeyPicker:OnChanged(function()
    print("快捷键改变！", Options.KeyPicker.Value, table.unpack(Options.KeyPicker.Modifiers or {}))
end)

task.spawn(function()
    while task.wait(1) do
        local state = Options.KeyPicker:GetState()
        if state then
            print("KeyPicker 被按住")
        end
        if Library.Unloaded then
            break
        end
    end
end)

Options.KeyPicker:SetValue({ "MB2", "Hold" })

local KeybindNumber = 0

LeftGroupBox:AddLabel("按下快捷键"):AddKeyPicker("KeyPicker2", {
    Default = "X",
    Mode = "Press",
    WaitForCallback = false,
    Text = "增加数字",
    Callback = function()
        KeybindNumber = KeybindNumber + 1
        print("[回调] 快捷键点击！数字增加到:", KeybindNumber)
    end
})

-- ==================== 第二个分组框 ====================
local LeftGroupBox2 = Tabs.Main:AddLeftGroupbox("分组框 #2")
LeftGroupBox2:AddLabel(
    "这个标签跨越了多行！我们会用完界面空间……\n开玩笑的！往下滚动！\n\n\n来自下方的问候！",
    true
)

local TabBox = Tabs.Main:AddRightTabbox()

local Tab1 = TabBox:AddTab("标签页 1")
Tab1:AddToggle("Tab1Toggle", { Text = "标签页 1 开关" })

local Tab2 = TabBox:AddTab("标签页 2")
Tab2:AddToggle("Tab2Toggle", { Text = "标签页 2 开关" })

Library:OnUnload(function()
    print("已卸载！")
end)

-- ==================== 密钥系统 ====================
Tabs.Key:AddLabel({
    Text = "密钥：Banana",
    DoesWrap = true,
    Size = 16,
})

Tabs.Key:AddKeyBox("Banana", function(Success, ReceivedKey)
    print("预期密钥: Banana - 收到密钥:", ReceivedKey, "| 成功:", Success)
    Library:Notify({
        Title = "预期密钥: Banana",
        Description = "收到密钥: " .. ReceivedKey .. "\n成功: " .. tostring(Success),
        Time = 4,
    })
end)

Tabs.Key:AddLabel({
    Text = "无密钥",
    DoesWrap = true,
    Size = 16,
})

Tabs.Key:AddKeyBox(function(Success, ReceivedKey)
    print("预期密钥: 无 | 成功:", Success)
    Library:Notify("成功: " .. tostring(Success), 4)
end)

-- ==================== 界面设置 ====================
local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("菜单", "wrench")

MenuGroup:AddToggle("KeybindMenuOpen", {
    Default = Library.KeybindFrame.Visible,
    Text = "打开快捷键菜单",
    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end,
})
MenuGroup:AddToggle("ShowCustomCursor", {
    Text = "自定义光标",
    Default = true,
    Callback = function(Value)
        Library.ShowCustomCursor = Value
    end,
})
MenuGroup:AddDropdown("NotificationSide", {
    Values = { "左", "右" },
    Default = "右",
    Text = "通知位置",
    Callback = function(Value)
        Library:SetNotifySide(Value)
    end,
})
MenuGroup:AddDropdown("DPIDropdown", {
    Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
    Default = "100%",
    Text = "DPI 缩放",
    Callback = function(Value)
        Value = Value:gsub("%%", "")
        local DPI = tonumber(Value)
        Library:SetDPIScale(DPI)
    end,
})
MenuGroup:AddDivider()
MenuGroup:AddLabel("菜单绑定")
    :AddKeyPicker("MenuKeybind", { Default = "G", NoUI = true, Text = "菜单快捷键" })

MenuGroup:AddButton("卸载", function()
    Library:Unload()
end)

-- ★ 不用快捷键，靠自动展开
-- Library.ToggleKeybind = Options.MenuKeybind

-- ==================== 管理器 ====================
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })

ThemeManager:SetFolder("MyScriptHub")
SaveManager:SetFolder("MyScriptHub/specific-game")
SaveManager:SetSubFolder("specific-place")

SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])

-- ★ 注释掉自动加载，防止旧存档覆盖
-- SaveManager:LoadAutoloadConfig()

print("═══════════════════════════════════════")
print("✅ 黑曜石 UI 已加载")
print("自动展开尝试已启动，若窗口还没展开，")
print("请手动点击左下角的折叠标签")
print("═══════════════════════════════════════")
