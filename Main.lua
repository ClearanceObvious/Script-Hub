local lib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local hwnd = lib:MakeWindow {Name = "Smelly Hub"}
lib:MakeNotification {
    Title = "Smelly Hub UI",
    Content = "Welcome Back!",
    Time = 5
}


--Variables
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local mouse = player:GetMouse()

local __teleport = false


--Functions
function CheckID()
    if game.PlaceId ~= 155615604 then
        return false, game.PlaceId
    end
    
    return true, game.PlaceId
end


--Events
mouse.Button1Up:Connect(function()
    if __teleport and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
        character:SetPrimaryPartCFrame(mouse.Hit * CFrame.new(0, 1, 0))
    end
end)


--Tabs
local tab1 = hwnd:MakeTab {
    Name = "Self"
}
local tab2 = hwnd:MakeTab {
    Name = "Game"
}


--Self Tab

--Walkspeed 
tab1:AddSlider({
	Name = "Walkspeed",
	Min = 16,
	Max = 200,
	Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 2,
	ValueName = "",
	Callback = function(Value)
		humanoid.WalkSpeed = Value
	end    
})

--JumpPower 
tab1:AddSlider({
	Name = "JumpPower",
	Min = 50,
	Max = 200,
	Default = 50,
	Color = Color3.fromRGB(255,255,255),
	Increment = 2,
	ValueName = "",
	Callback = function(Value)
		humanoid.JumpPower = Value
	end    
})

--Teleport
tab1:AddToggle {
    Name = "Click to Teleport",
    Default = false,
    Callback = function(val)
        __teleport = val
    end
}


--Game Tab

--Check Game Button
tab2:AddButton {
    Name = "Load Game",
    Callback = function()
        if not CheckID() then
            lib:MakeNotification {
                Title = "Oops!",
                Content = "Couldn't find game",
                Time = 5
            }
            return
        end
        
        local args = table.pack(CheckID())
        if args[2] == 155615604 then    --Prison Life
            loadstring(game:HttpGet "https://raw.githubusercontent.com/ClearanceObvious/Script-Hub/main/PrisonLife.lua")()
        end
    end
}
