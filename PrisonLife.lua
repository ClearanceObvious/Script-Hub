--Remove fade frame
game.Players.LocalPlayer.PlayerGui.Home.fadeFrame.Visible = false

--Boot
local lib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local hwnd = lib:MakeWindow {
    Name = 'Prison Life v0.2b'
}
--Local Variables
local player = game.Players.LocalPlayer
local _char = player.Character
local hum = _char.Humanoid or _char:WaitForChild('Humanoid')
hum.UseJumpPower = true
local team = workspace.Remote.TeamEvent

local def_wk = hum.WalkSpeed
local def_jp = hum.JumpPower

local POLICE = CFrame.new(834, 101.5, 2268)
local PRISON = CFrame.new(919, 101.5, 2376)
local BASE = CFrame.new(-953.4, 95.7, 2047.6)
local YARD = CFrame.new(803, 99.5, 2451)


--Hooks
local oldh
oldh = hookmetamethod(player, "__newindex", function(slf, prop, value)
    if not checkcaller() and slf == player then
       if tostring(prop) == "Team" then return end 
    end
    return oldh(slf, prop, value) 
end)

--Variables
Mouse = game.Players.LocalPlayer:GetMouse()
UserInputService = game:GetService('UserInputService')
--Local Tab
local tab_local = hwnd:MakeTab {
    Name = 'Local',
    Icon = '',
    PremiumOnly = false
}
s_wk = tab_local:AddSlider {
    Name = 'WalkSpeed',
    Min = 16,
    Max = 200,
    Default = def_wk,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = 'Velocity',
    Callback = function(val)
        _char = player.Character
        hum = _char.Humanoid or _char:WaitForChild('Humanoid')
        hum.WalkSpeed = val
    end
}
s_jp = tab_local:AddSlider {
    Name = 'Jump Power',
    Min = 50,
    Max = 200,
    Default = def_jp,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = 'High',
    Callback = function(val)
        _char = player.Character
        hum = _char.Humanoid or _char:WaitForChild('Humanoid')
        hum.JumpPower = val
    end
}
tab_local:AddButton {
    Name = 'Reset [To Default]',
    Callback = function()
        s_wk:Set(def_wk)
        s_jp:Set(def_jp)
    end
}
tab_local:AddToggle({
	Name = "Noclip",
	Default = false,
	Callback = function(Value)
local CharParts = {}
_G.NoClip = Value
game:GetService("RunService").Stepped:connect(function()
    if _G.NoClip then
        for i = 1, #CharParts do
            CharParts[i].CanCollide = false
        end
    end
end)

function SetupCharCollide(Char)
    CharParts = {}
    Char:WaitForChild("Head")
    for i, v in pairs(Char:GetChildren()) do
        if v:IsA("BasePart") then
            table.insert(CharParts, v)
        end
    end
end

if game.Players.LocalPlayer.Character then
    SetupCharCollide(game.Players.LocalPlayer.Character)
end
game.Players.LocalPlayer.CharacterAdded:connect(function(Ch)
    SetupCharCollide(Ch)
end)
end
})
tab_local:AddDropdown({
	Name = "Teams",
	Default = "",
	Options = {"Prisoner", "Cop", "Neutral", "Criminal"},
	Callback = function(Value)
		local selected = Value
		if selected == "Prisoner" then team:FireServer("Bright orange") end --Prisoner Team
        if selected == "Cop" then team:FireServer("Bright blue") end --Cop Team
        if selected == "Neutral" then team:FireServer("Medium stone grey") end --Neutral Team
        if selected == "Criminal" then
            CrimSpawn = game.Workspace["Criminals Spawn"].SpawnLocation
 
            CrimSpawn.CanCollide = false
            CrimSpawn.Size = Vector3.new(51.05, 24.12, 54.76)
            CrimSpawn.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            CrimSpawn.Transparency = 1
            wait(0.5)
            CrimSpawn.CFrame = CFrame.new(-920.510803, 92.2271957, 2138.27002, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CrimSpawn.Size = Vector3.new(6, 0.2, 6)
            CrimSpawn.Transparency = 0 
        end
	end    
})

--Weapons Tab
local tab_guns = hwnd:MakeTab {
    Name = 'Guns',
    Icon = '',
    PremiumOnly = false
}
tab_guns:AddButton {
    Name = 'Pistol',
    Callback = function()
        local arg = workspace.Prison_ITEMS.giver:FindFirstChild('M9').ITEMPICKUP
        workspace.Remote.ItemHandler:InvokeServer(arg)
    end
}
tab_guns:AddButton {
    Name = 'AK-47',
    Callback = function()
        local arg = workspace.Prison_ITEMS.giver:FindFirstChild('AK-47').ITEMPICKUP
        workspace.Remote.ItemHandler:InvokeServer(arg)
    end
}
tab_guns:AddButton {
    Name = 'Shotgun',
    Callback = function()
        local arg = workspace.Prison_ITEMS.giver:FindFirstChild('Remington 870').ITEMPICKUP
        workspace.Remote.ItemHandler:InvokeServer(arg)
    end
}
        _char = player.Character

--Teleport Tab
local tab_teleports = hwnd:MakeTab {
    Name = 'Teleports',
    Icon = '',
    PremiumOnly = false
}
--Teleport Dropdown
tab_teleports:AddDropdown({
	Name = "Teleports",
	Default = "",
	Options = {"Prison", "Criminal Base", "Yard", "Police"},
	Callback = function(Value)
		local selected = Value
		if selected == "Criminal Base" then _char:SetPrimaryPartCFrame(BASE) end
		if selected == "Prison" then _char:SetPrimaryPartCFrame(PRISON) end
		if selected == "Yard" then _char:SetPrimaryPartCFrame(YARD) end
		if selected == "Police" then _char:SetPrimaryPartCFrame(POLICE) end
	end    
})
--Rage Tab
local tab_rage = hwnd:MakeTab {
    Name = 'Rage',
    Icon = '',
    PremiumOnly = false
}
--Killaura TOGGLE
tab_rage:AddToggle({
	Name = "Killaura",
	Default = false,
	Callback = function(value)
    _G.Toggle = value
    while _G.Toggle == true do
    wait()
    for i, e in pairs(game.Players:GetChildren()) do
        if e ~= game.Players.LocalPlayer then
            local meleeEvent = game:GetService("ReplicatedStorage").meleeEvent
                meleeEvent:FireServer(e)
            end 
        end 
    end
end
})
--AutoRespawn
tab_rage:AddToggle({
	Name = "Auto Respawn",
	Default = false,
	Callback = function(value)
    _G.Toggle = value
    while _G.Toggle do 
    wait()
	if game.Players.LocalPlayer.Character.Humanoid.Health < 1 then 
    		local lastPos = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").position
    		local plr = game.Players.LocalPlayer.Name
    		local gayevent = game:GetService("Workspace").Remote.loadchar
    		gayevent:InvokeServer(plr)
    		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(lastPos)
	    end
    end
end
})
--Super punch (one punch)
tab_rage:AddToggle({
	Name = "Super Punch",
	Default = false,
	Callback = function(Value)
	    SuperPunchF = Value
		local Scooldown = false
 
function punch()
 
	local mainRemotes = game.ReplicatedStorage
	local meleeRemote = mainRemotes['meleeEvent']
	local mouse = game.Players.LocalPlayer:GetMouse()
	local punching = false
	Scooldown = true
	local part = Instance.new("Part", game.Players.LocalPlayer.Character)
	part.Transparency = 1
	part.Size = Vector3.new(5, 2, 3)
	part.CanCollide = false
	local w1 = Instance.new("Weld", part)
	w1.Part0 = game.Players.LocalPlayer.Character.Torso
	w1.Part1 = part
	w1.C1 = CFrame.new(0,0,2)
	part.Touched:connect(function(hit)
	if game.Players:FindFirstChild(hit.Parent.Name) then
	local plr = game.Players:FindFirstChild(hit.Parent.Name)	
	if plr.Name ~= game.Players.LocalPlayer.Name then
		part:Destroy()
 
	for i = 1,100 do
	meleeRemote:FireServer(plr)
	end
	end
	end
	end)
 
	wait(1)
	Scooldown = false
	part:Destroy()
end
 
 
Mouse.KeyDown:connect(function(key)
	if SuperPunchF == true then
if Scooldown == false then
if key:lower() == "f" then
 
punch()
 
end
end
end
end)
	end    
})
--Arrest All
tab_rage:AddButton {
    Name = 'Arrest All',
    Callback = function()
        wait(0.1)
	    Player = game.Players.LocalPlayer
	    Pcf = Player.Character.HumanoidRootPart.CFrame
        	for i,v in pairs(game.Teams.Criminals:GetPlayers()) do
	    if v.Name ~= Player.Name then
	    local i = 10
        repeat
        wait()
        i = i-1
        game.Workspace.Remote.arrest:InvokeServer(v.Character.HumanoidRootPart)
        Player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
        until i == 0
        end
    end
end
}
--Cars Tab
local tab_cars = hwnd:MakeTab {
    Name = 'Cars',
    Icon = '',
    PremiumOnly = false
}
tab_cars:AddLabel('Coming Soon')
--Credits Tab
local tab_creds = hwnd:MakeTab {
    Name = 'Credits',
    Icon = '',
    PremiumOnly = false
}
--Credits
tab_creds:AddLabel('Click to copy!')
tab_creds:AddButton {
    Name = 'Developer - Iann#4631',
    Callback = function()
        setclipboard("Iann#4631")
    end
}
tab_creds:AddButton {
    Name = 'Developer - Tony_.#5397',
    Callback = function()
        setclipboard("Tony_.#5397")
    end
}
tab_creds:AddButton {
    Name = 'UI Library - shlex#0001',
    Callback = function()
        setclipboard("shlex#0001")
    end
}
tab_creds:AddButton {
    Name = 'Discord Server',
    Callback = function()
        setclipboard("https://discord.gg/V7snxs5aFM")
    end
}
