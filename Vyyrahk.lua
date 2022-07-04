--GAME SERVERS https://www.roblox.com/games/3415252509/Vyyrahk-Novarsk#!/game-instances
--Whole Library
local lib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
--Window
local Window = lib:MakeWindow ({
    Name = 'Vyyrahk',
    SaveConfig = true,
    ConfigFolder = "SmellyHub",
    IntroText = "Smelly Hub",
    IntroIcon = "rbxassetid://10089536418"
})
--Tab
local Tab = Window:MakeTab({
    Name = "Local",
    Icon = "rbxassetid://8950630609",
    PremiumOnly = false
})
--Killaura
while _G.Toggle do
    wait()
   for i, e in pairs(game.Players:GetChildren()) do
if e ~= game.Players.LocalPlayer then
   local meleeEvent = game:GetService("ReplicatedStorage").Machine.Events.GunClass.MeleeDamage
       meleeEvent:InvokeServer(e, "Fist")
   end 
end 
end
--Toggle for killaura
Tab:AddToggle({
    Name = "Killaura",
    Default = false,
    Callback = function(Value)
        _G.Toggle = Value
    end    
})
local syn_f = is_synapse_function
function search_funcs(scrpt, tabl)
    local fvx = {}
    for i, v in pairs(tabl) do
        if (type(v) == 'function') and not syn_f(v) then
            if tostring(getfenv(v).script) == tostring(scrpt) then
                fvx[#fvx+1] = v
            end
        end
    end
    return fvx
end
--Fast punch
Tab:AddButton({
	Name = "Fast punch!",
	Callback = function()
        a = game.Players.LocalPlayer.Character.Fist["SwordScript_Fist"]
            local func = search_funcs(a, getgc())
            debug.setconstant(func[4], 26, 0.01)
            debug.setconstant(func[7], 26, 0.01)
  	end    
})
Tab:AddButton({
	Name = "disable Fast punch!",
	Callback = function()
        a = game.Players.LocalPlayer.Character.Fist["SwordScript_Fist"]
            local func = search_funcs(a, getgc())
            debug.setconstant(func[4], 26, 0.8)
            debug.setconstant(func[7], 26, 0.8)
  	end    
})
--INf Stamina
Tab:AddButton({
	Name = "Infinite Stamina!",
	Callback = function()
	local env = getsenv(game:GetService("Players").LocalPlayer.PlayerGui.WeaponHud["WeaponHUD_Main"])
    env.StaminaCosts.Sprinting = 0
    env.StaminaCosts.Walking = 0
    env.StaminaCosts.Still = 0
    env.StaminaCosts.Jumping = 0
  	end    
})
--Slider for Walkspeed
Tab:AddSlider({
    Name = "Walkspeeds For Sprinting",
    Min = 25,
    Max = 200,
    Default = 25,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "",
    Callback = function(Value)
        for i,v in pairs(game.ReplicatedStorage.Machine.Modules:GetDescendants()) do 
            if v.Name == "Walkspeeds" then 
                a = require(v)
                --Ways of running
                a.Sprinting = Value --Change numbers to speed you want
            end      
        end
    end    
})
Tab:AddSlider({
    Name = "Walkspeeds For Walking",
    Min = 6.5,
    Max = 200,
    Default = 6.5,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "",
    Callback = function(Value)
        for i,v in pairs(game.ReplicatedStorage.Machine.Modules:GetDescendants()) do 
            if v.Name == "Walkspeeds" then 
                a = require(v)
                --Ways of running
                a.Walking = Value
            end      
        end
    end    
})
Tab:AddSlider({
    Name = "Walkspeeds For Jogging",
    Min = 15,
    Max = 200,
    Default = 15,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "",
    Callback = function(Value)
        for i,v in pairs(game.ReplicatedStorage.Machine.Modules:GetDescendants()) do 
            if v.Name == "Walkspeeds" then 
                a = require(v)
                --Ways of running
                a.Jogging = Value
            end      
        end
    end    
})
Tab:AddSlider({
    Name = "Walkspeeds For Crouching",
    Min = 8,
    Max = 200,
    Default = 8,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "",
    Callback = function(Value)
        for i,v in pairs(game.ReplicatedStorage.Machine.Modules:GetDescendants()) do 
            if v.Name == "Walkspeeds" then 
                a = require(v)
                a.Crouching = Value
            end      
        end
    end    
})
Tab:AddSlider({
    Name = "Walkspeeds For Prone",
    Min = 3.24,
    Max = 200,
    Default = 3.24,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "",
    Callback = function(Value)
        for i,v in pairs(game.ReplicatedStorage.Machine.Modules:GetDescendants()) do 
            if v.Name == "Walkspeeds" then 
                a = require(v)
                a.Prone = Value
            end      
        end
    end    
})
--Reset to default speeds
Tab:AddButton({
	Name = "Reset Defaults",
	Callback = function()
      		for i,v in pairs(game.ReplicatedStorage.Machine.Modules:GetDescendants()) do 
            if v.Name == "Walkspeeds" then 
                a = require(v)
                --Ways of running
                a.Sprinting = 25 --Change numbers to speed you want
                a.Walking = 6.5
                a.Jogging = 15
                a.Crouching = 8
                a.Prone = 3.24
            end      
        end
  	end    
})

--Teleports tab
local T_tab = Window:MakeTab({
    Name = "Teleports",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
getgenv().Speed = 50
--Teleports Dropdown
T_tab:AddDropdown({
	Name = "Teleports",
	Default = "",
	Options = {"Police Job", "Street Cleaner Job", "Paramedic Job", "Miner Job", "Garbage Collector Job", "Prison Guard Job", "Firefighter Job", "Factory Worker Job", "Bank", "Gun Dealer", "Food Inn", "Vacdonalds"},
	Callback = function(Value)
	    selected = Value
	    if selected == "Police Job" then local Time =
    (Vector3.new(-195.55441284179688, -240.20004272460938, 1595.0714111328125) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / getgenv().Speed
local Info = TweenInfo.new(Time, Enum.EasingStyle.Linear)
local Tween =
    game:GetService("TweenService"):Create(
    game.Players.LocalPlayer.Character.HumanoidRootPart,
    Info,
    {CFrame = CFrame.new(Vector3.new(-195.55441284179688, -240.20004272460938, 1595.0714111328125))}
)
Tween:Play() end
     if selected == "Street Cleaner Job" then local Time =
    (Vector3.new(348.3561706542969, -241.5914764404297, 1629.114990234375) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / getgenv().Speed
local Info = TweenInfo.new(Time, Enum.EasingStyle.Linear)
local Tween =
    game:GetService("TweenService"):Create(
    game.Players.LocalPlayer.Character.HumanoidRootPart,
    Info,
    {CFrame = CFrame.new(Vector3.new(348.3561706542969, -241.5914764404297, 1629.114990234375))}
)
Tween:Play() end
    if selected == "Paramedic Job" then local Time =
    (Vector3.new(539.838, -229.06, 1638.08) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / getgenv().Speed
local Info = TweenInfo.new(Time, Enum.EasingStyle.Linear)
local Tween =
    game:GetService("TweenService"):Create(
    game.Players.LocalPlayer.Character.HumanoidRootPart,
    Info,
    {CFrame = CFrame.new(Vector3.new(539.838, -229.06, 1638.08))}
)
Tween:Play() end
    if selected == "Miner Job" then local Time =
    (Vector3.new(545.01806640625, -234.3928680419922, 2108.991943359375) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / getgenv().Speed
local Info = TweenInfo.new(Time, Enum.EasingStyle.Linear)
local Tween =
    game:GetService("TweenService"):Create(
    game.Players.LocalPlayer.Character.HumanoidRootPart,
    Info,
    {CFrame = CFrame.new(Vector3.new(545.01806640625, -234.3928680419922, 2108.991943359375))}
)
Tween:Play() end
    if selected == "Garbage Collector Job" then local Time =
    (Vector3.new(168.6991729736328, -241.5191650390625, 2272.00634765625) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / getgenv().Speed
local Info = TweenInfo.new(Time, Enum.EasingStyle.Linear)
local Tween =
    game:GetService("TweenService"):Create(
    game.Players.LocalPlayer.Character.HumanoidRootPart,
    Info,
    {CFrame = CFrame.new(Vector3.new(168.6991729736328, -241.5191650390625, 2272.00634765625))}
)
Tween:Play() end
if selected == "Prison Guard Job" then local Time =
    (Vector3.new(-128.30029296875, -240.20004272460938, 1686.14306640625) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / getgenv().Speed
local Info = TweenInfo.new(Time, Enum.EasingStyle.Linear)
local Tween =
    game:GetService("TweenService"):Create(
    game.Players.LocalPlayer.Character.HumanoidRootPart,
    Info,
    {CFrame = CFrame.new(Vector3.new(-128.30029296875, -240.20004272460938, 1686.14306640625))}
)
Tween:Play() end
    if selected == "Firefighter Job" then local Time =
    (Vector3.new(-405.2517395019531, -241.03799438476562, 1291.3638916015625) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / getgenv().Speed
local Info = TweenInfo.new(Time, Enum.EasingStyle.Linear)
local Tween =
    game:GetService("TweenService"):Create(
    game.Players.LocalPlayer.Character.HumanoidRootPart,
    Info,
    {CFrame = CFrame.new(Vector3.new(-405.2517395019531, -241.03799438476562, 1291.3638916015625))}
)
Tween:Play() end
    if selected == "Factory Worker Job" then local Time =
    (Vector3.new(320.55340576171875, -232.268798828125, 2140.406494140625) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / getgenv().Speed
local Info = TweenInfo.new(Time, Enum.EasingStyle.Linear)
local Tween =
    game:GetService("TweenService"):Create(
    game.Players.LocalPlayer.Character.HumanoidRootPart,
    Info,
    {CFrame = CFrame.new(Vector3.new(320.55340576171875, -232.268798828125, 2140.406494140625))}
)
Tween:Play() end
if selected == "Bank" then local Time =
    (Vector3.new(-310.9496765136719, -241.03814697265625, 2202.167724609375) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / getgenv().Speed
local Info = TweenInfo.new(Time, Enum.EasingStyle.Linear)
local Tween =
    game:GetService("TweenService"):Create(
    game.Players.LocalPlayer.Character.HumanoidRootPart,
    Info,
    {CFrame = CFrame.new(Vector3.new(-310.9496765136719, -241.03814697265625, 2202.167724609375))}
)
Tween:Play() end
if selected == "Gun Dealer" then local Time =
    (Vector3.new(434.4190979003906, -230.00025939941406, 1449.8651123046875) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / getgenv().Speed
local Info = TweenInfo.new(Time, Enum.EasingStyle.Linear)
local Tween =
    game:GetService("TweenService"):Create(
    game.Players.LocalPlayer.Character.HumanoidRootPart,
    Info,
    {CFrame = CFrame.new(Vector3.new(434.4190979003906, -230.00025939941406, 1449.8651123046875))}
)
Tween:Play() end
if selected == "Food Inn" then local Time =
    (Vector3.new(384.6968994140625, -240.93807983398438, 1313.4134521484375) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / getgenv().Speed
local Info = TweenInfo.new(Time, Enum.EasingStyle.Linear)
local Tween =
    game:GetService("TweenService"):Create(
    game.Players.LocalPlayer.Character.HumanoidRootPart,
    Info,
    {CFrame = CFrame.new(Vector3.new(384.6968994140625, -240.93807983398438, 1313.4134521484375))}
)
Tween:Play() end
if selected == "Vacdonalds" then local Time =
    (Vector3.new(57.61149215698242, -240.1441650390625, 1956.604736328125) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / getgenv().Speed
local Info = TweenInfo.new(Time, Enum.EasingStyle.Linear)
local Tween =
    game:GetService("TweenService"):Create(
    game.Players.LocalPlayer.Character.HumanoidRootPart,
    Info,
    {CFrame = CFrame.new(Vector3.new(57.61149215698242, -237.1441650390625, 1956.604736328125))}
)
Tween:Play() end
	end    
})
T_tab:AddToggle({
	Name = "Noclip",
	Default = false,
	Callback = function(Value)
		
_G.NoClip = Value
game:GetService("RunService").Stepped:connect(function()
    if _G.NoClip then
        for i = 1, #CharParts do
            CharParts[i].CanCollide = false
        end
    end
end)
T_tab:AddButton({
	Name = "NO FALLDAMAGE NEEDED FOR TELEPORT",
	Callback = function()
    local Player = game.Players.LocalPlayer
    local hum = Player.Character.HumanoidRootPart
    local x, y, z = 0, 0, 0



    game:GetService("RunService"):BindToRenderStep("dad", 3, function()
        x = hum.AssemblyLinearVelocity.X
        z = hum.AssemblyLinearVelocity.Z
        y = math.clamp(hum.AssemblyLinearVelocity.Y, -50, math.huge)

        hum.AssemblyLinearVelocity = Vector3.new(x, y ,z)
    end)
end    
})
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
