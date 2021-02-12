-- Walking time out: 5s
-- 

local tool
 for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do 
      if v:IsA("Tool") then 
            tool = v
      
      end
            end
            function Dig()
                  tool.ClickEvent:FireServer()
                  end


local selling = false

local farming = false

local act6temp = false

local debug = true

local automob = false

local autopolar = false

local AppQuest = game.ReplicatedStorage.Events.CompleteQuestFromPool
local GiveQuest = game.ReplicatedStorage.Events.GiveQuestFromPool

local QuestF = game.Players.LocalPlayer.PlayerGui.ScreenGui.Menus.Children.Quests.Content
function DonePolar()
AppQuest:FireServer("Polar Bear")
end

function GivePolar()
GiveQuest:FireServer("Polar Bear")
end

function GetPolarQuest()
      if QuestF:FindFirstChild("Frame") then
            for k,v in pairs(QuestF.Frame:GetChildren()) do
                  if v:IsA("Frame") then
                        if string.match(v.TitleBar.Text,"Polar")  then
                              if string.match(v.TitleBar.Text,"Polar Bear's Beesmas Feast") then
                                    --return v
                              else
                                    return v
                              end
                             -- print(v.TitleBar.Text)
                              
                        end
                  end

            end

      end
end

function IsQuestDone(Quest)
      if Quest:FindFirstChild("Description") then
      if string.match(Quest.Description.Text,"Complete") then
            return true
      else
            return false

      end
else
      return true
end


end

local fieldlistpolar = {
      "Spider Field",
      "Mushroom Field",
      "Rose Field",
      "Strawberry Field",
      "Bamboo Field",
      "Pumpkin Patch",
      "Sunflower Field",
      "Cactus Field",
      "Blue Flower Field",
      "Clover Field",
      "Pineapple Patch",
      "Dandelion Field",
      "Pine Tree Forest"
}

local moblistpolar = {
      "Spider",
      "Scorpion",
      "Werewol",
      "Mantises",
      "Ladybug",
      "Rhino Beetles",
}

local fieldmob = {
["Rhino Beetles"] = {"Bamboo Field", "Pineapple Patch","Blue Flower Field","Clover Field"},
["Spider"] = {"Spider Field"},
["Werewol"] = {"Cactus Field"},
["Scorpion"] = {"Rose Field"},
["Mantises"] = {"Pine Tree Forest","Pineapple Patch"},
["Ladybug"] = {"Strawberry Field","Mushroom Field","Clover Field"}
}
function CheckMob(field)
      local rootpart = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
      local old = rootpart.CFrame
      rootpart.CFrame=game.Workspace.FlowerZones[field].CFrame
      
      wait(.5)
      if string.match(field,"Cactus") then wait(2) end
      for k,v in pairs(game.Workspace.Monsters:GetChildren()) do
          if v:FindFirstChild("Head") then 
          if (game.Workspace.FlowerZones[field].CFrame.p-v.Head.Position).magnitude <= 60 then rootpart.CFrame = old; return true end
          end
          
          end
      
      return false

end
function GetQuestMob(Quest)
      for k,v in pairs(moblistpolar) do
            if string.match(Quest,v) then
                  --print(v)
                  return v
            end
      end

end
function KillAllMobList(fields) 
    for k,v in pairs(fields) do
        if CheckMob(v) then
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.FlowerZones[v].CFrame
            while(autopolar and CheckMob(v)) do wait() end
            wait(1)
            CollectAllTokenInField(v)
    
        end
    end
    

end
function GetQuestField(Quest)
      for k,v in pairs(fieldlistpolar) do
            if string.match(Quest,v) then
                  --print(v)
                  return v
            end
      end



end

function CollectAllTokenInField(Field)
      local player = game:GetService("Players").LocalPlayer
      local sanghuman = player.Character.HumanoidRootPart
      local hotboi = sanghuman.CFrame
      local sangzboi = workspace.FlowerZones[Field].CFrame
      for k,v in pairs(game.Workspace.Collectibles:GetChildren()) do
            if ( (v.Position-sangzboi.p).magnitude <= 60) and ((sanghuman.Position-v.Position).magnitude<=60) then
                  --local old = act6temp
                  
                  tp(CFrame.new(v.Position.X,sanghuman.Position.Y,v.Position.Z),0.2)
                  act6temp = false
                  Dig()
                  wait(.1)
            end           
      end

end

local ss = coroutine.wrap(function()
      while wait() do
            if autopolar then
            DonePolar()
            GivePolar()
            end
      end
end)
ss()

local polar = coroutine.wrap(function()
      while wait() do
            if autopolar then
                  --print("auto")
                  local t = GetPolarQuest()
                  --print(t)
                  if t then
                  for k,v in pairs(t:GetChildren()) do
                        if v:IsA("Frame") then
                              if v:FindFirstChild("Description") then
                              if not IsQuestDone(v) then
                                
                                    if string.match(v.Description.Text,"Collect") then
                                        
                                          local field = GetQuestField(v.Description.Text)
                                          --print(v.Description.Text)
                                          if field then
                                          game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.FlowerZones[field].CFrame
                                          
                                          while(autopolar and IsQuestDone(v) == false) do
                                                Dig()
                                                CollectAllTokenInField(field)
                                                wait()
                                          end
                                        end

                                    else 
                                         
                                          if string.match(v.Description.Text,"Defeat") then
                                                local mob = GetQuestMob(v.Description.Text)
                                                local field = fieldmob[mob]
                                                KillAllMobList(field)
                                                
                                          end

                                    
                              end
                              end
                        end



                        end
                  end
                end

            end

      end

end)
polar()

local mob = coroutine.wrap(function() 
while wait() do
      --print(automob)
if automob then
      
local fieldlist = {
      "Mushroom Field",
      "Clover Field",
      
      "Blue Flower Field",
      "Bamboo Field",
      "Spider Field",
      "Strawberry Field",
      "Cactus Field",
      "Pine Tree Forest",
      "Rose Field",
      "Pineapple Patch"
}
local rootpart = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
for k,v in pairs(fieldlist) do
--print(CheckMob(v))
if CheckMob(v) == true then

rootpart.CFrame=game.Workspace.FlowerZones[v].CFrame
while(CheckMob(v) == true) do
if automob==false then break end

end
wait(1)
local player = game:GetService("Players").LocalPlayer
local sanghuman = player.Character.HumanoidRootPart
local hotboi = sanghuman.CFrame
local sangzboi = workspace.FlowerZones[v].CFrame
for k,v in pairs(game.Workspace.Collectibles:GetChildren()) do 
      if ((v.Position-sangzboi.p).magnitude <= 60) and (sanghuman.Position-v.Position).magnitude<=60 then
            if automob then
            --rootpart.CFrame = CFrame.new(v.Position.x, sanghuman.Position.y, v.Position.z)
            tp(CFrame.new(v.Position.x, sanghuman.Position.y, v.Position.z),0.2)
            wait()
            end
      end
end

end

end
end
end
end)

mob()
function GetNerestToken() 
local token = game.Workspace.Collectibles:GetChildren()[0]
local h = game:GetService("Players").Character.HumanoidRootPart.Position
for k,v in pairs(game.Workspace.Collectibles:GetChildren()) do 
      if (h-v.Position).magnitude < (h.Position - token.position).magnitude then 
            token = v
      
      end
end


end



pcall(function()
      local g = getrawmetatable(game)
      local oldindex = g.__namecall
      setreadonly(g,false)
      g.__namecall = newcclosure(function(Self,...)
      local method = getnamecallmethod() 
      if Self == game.Players.LocalPlayer and tostring(method) == "Kick" then
      return
      end
      return oldindex(Self,...)
      end)


end)


function WalkToHive(cf) 
local Pt = game:GetService("PathfindingService")
local spawnpos = cf.p
local torso = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
local hm = game:GetService("Players").LocalPlayer.Character.Humanoid
local path = Pt:CreatePath()
path:ComputeAsync(torso.Position,spawnpos)
local waypoints = path:GetWaypoints()

for k,v in pairs(waypoints) do 
local stop = false
if v.Action == Enum.PathWaypointAction.Jump then 
      hm:ChangeState(Enum.HumanoidStateType.Jumping)
  
  end
hm:MoveTo(v.Position)
hm.MoveToFinished:Connect(function()
stop = true
end)
local ticks = tick()
while stop == false do
      wait() 
if (tick() - ticks)>=5 then stop = true end
if act6temp then stop = true end

end


end

end


function ProtectUI(UI)
      local Exploit =
          (KRNL_LOADED and "KRNL") or (secure_load and "Sentinel") or (pebc_execute and "ProtoSmasher") or (is_sirhurt_closure and "Sirhurt") or
          (syn and "Synapse X") 
      if Exploit == "Synapse X" then
          pcall(
              function()
                  syn.protect_gui(UI)
                  
              end
          )
          UI.Parent = game.CoreGui

      else
          if Exploit == "ProtoSmasher" or Exploit == "Sirhurt" then
              UI.Parent = get_hidden_gui()

          else
              if Exploit=="KRNL" then
                  UI.Parent = gethui()
              else 
                  UI.Parent = game.CoreGui
              end

          end
      end
  end

for _,v in pairs(game.workspace.Collectibles:GetChildren()) do
if string.find(v.Name,"") then
v:Destroy()
end
end 
local TokenId = 
{
	["TokenLink"] = "rbxassetid://1629547638",
      ["BlueBomb"] = "rbxassetid://1442725244",
      ["BlueBomb+"] = "rbxassetid://1442764904",
      ["Frog"] = "http://www.roblox.com/asset/?id=4528414666",
      ["Ticket"] = "rbxassetid://1674871631",
      ["Glue"] = "rbxassetid://2504978518",
      ["Pineapple"] = "rbxassetid://1952796032",
      ["Strawberry"] = "rbxassetid://1952740625",
      ["BlueBoost"] = "rbxassetid://1442863423",
      ["Blueberry"] = "rbxassetid://2028453802" ,
      ["SunflowerSeed"] = "rbxassetid://1952682401",
      ["Treat"] = "rbxassetid://2028574353",
      ["Snowflake"] = "rbxassetid://6087969886",
      ["Gumdrop"] = "rbxassetid://1838129169",
      ["Micro"] = "rbxassetid://2863122826",
      ["Star"] = "rbxassetid://2000457501",
      ["Bear1"] = "rbxassetid://1472532912"
}
local PopStarAura = "5101328809"
local PlGui = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:WaitForChild("TileGrid")

function IsPopStar()
      
      for k,v in pairs(PlGui:GetChildren()) do 
            if v:FindFirstChild("BG") then 
                  if v.BG:FindFirstChild("Icon") then 
                        if string.match(v.BG.Icon.Image,PopStarAura) then return true end
                        --print(v.BG.Icon.Image)
                  end
            end
      
      end
      return false
end

--print(IsPopStar())

function GetTokenLink()
local t = {}
local i = 0
for k,v in pairs (game.Workspace.Collectibles:GetChildren()) do

if v:FindFirstChild("FrontDecal") then 
if v.FrontDecal.Texture == TokenId["TokenLink"] then
t[i] = v
end

end
i = i+1
end
return t


end

function GetToken(TokenId)
      local t = {}
      local i = 0
      for k,v in pairs (game.Workspace.Collectibles:GetChildren()) do
      
      if v:FindFirstChild("FrontDecal") then 
      if v.FrontDecal.Texture == TokenId[id] then
      t[i] = v
      end
      
      end
      i = i+1
      end
      return t
end

local snowflake = false



local HoneyBeeDecal = "rbxassetid://1472135114"
local tuoidz = "Sunflower Field"
local DarkCyberMainGUI = Instance.new("ScreenGui")
local MiniPage = Instance.new("Frame")
local Destroy = Instance.new("TextButton")
local GameText = Instance.new("TextLabel")
local MainPage = Instance.new("Frame")
local VersionText = Instance.new("TextLabel")
local HomePage = Instance.new("Frame")
local ImageGang = Instance.new("ImageLabel")
local CreditText = Instance.new("TextLabel")
local JoinText = Instance.new("TextLabel")
local DiscordlinkTest = Instance.new("TextLabel")
local Copylinkdiscord = Instance.new("TextButton")
local FarmingPage = Instance.new("Frame")
local FieldSelectPage = Instance.new("ScrollingFrame")
local SunflowerButton = Instance.new("TextButton")
local MushroomButton = Instance.new("TextButton")
local SpiderButton = Instance.new("TextButton")
local BambooButton = Instance.new("TextButton")
local RoseButton = Instance.new("TextButton")
local PineTreeButton = Instance.new("TextButton")
local CactusButton = Instance.new("TextButton")
local PumpkinButton = Instance.new("TextButton")
local PineappleButton = Instance.new("TextButton")
local StumpButton = Instance.new("TextButton")
local MountainTopButton = Instance.new("TextButton")
local CoconutButton = Instance.new("TextButton")
local PepperButton = Instance.new("TextButton")
local StawberryButton = Instance.new("TextButton")
local BlueflowerButton = Instance.new("TextButton")
local DanrButton = Instance.new("TextButton")
local DanrButton_2 = Instance.new("TextButton")
local FieldSelectText = Instance.new("TextLabel")
local HoneyText = Instance.new("TextLabel")
local FieldText = Instance.new("TextLabel")
local TimeElapsedText = Instance.new("TextLabel")
local StartButton = Instance.new("TextButton")
local FieldSelectText_2 = Instance.new("TextLabel")
local WaypointPage = Instance.new("ScrollingFrame")
local Suntp = Instance.new("TextButton")
local Mushtp = Instance.new("TextButton")
local Dantp = Instance.new("TextButton")
local Blueftp = Instance.new("TextButton")
local Clovertp = Instance.new("TextButton")
local Bambootp = Instance.new("TextButton")
local Spidertp = Instance.new("TextButton")
local Strawtp = Instance.new("TextButton")
local Castustp = Instance.new("TextButton")
local Pumtp = Instance.new("TextButton")
local Pintreetp = Instance.new("TextButton")
local Rosetp = Instance.new("TextButton")
local Toptp = Instance.new("TextButton")
local Coconuttp = Instance.new("TextButton")
local Stumptp = Instance.new("TextButton")
local Pineappletp = Instance.new("TextButton")
local Peppertp = Instance.new("TextButton")
local SummonSprouttp = Instance.new("TextButton")
local Coconutshoptp = Instance.new("TextButton")
local Petaltp = Instance.new("TextButton")
local Shopproctp = Instance.new("TextButton")
local Shoptoptp = Instance.new("TextButton")
local Shopmoontp = Instance.new("TextButton")
local Shopbasictp = Instance.new("TextButton")
local Shopsprinklertp = Instance.new("TextButton")
local InstantConversiontp = Instance.new("TextButton")
local MegaMemorytp = Instance.new("TextButton")
local NightMemorytp = Instance.new("TextButton")
local ExtremeMemorytp = Instance.new("TextButton")
local StartHalltp = Instance.new("TextButton")
local Anttp = Instance.new("TextButton")
local Demonmasktp = Instance.new("TextButton")
local TunelBeartp = Instance.new("TextButton")
local WindyBeetp = Instance.new("TextButton")
local Diamondmasktp = Instance.new("TextButton")
local Soon = Instance.new("TextButton")
local GummyMask = Instance.new("TextButton")
local Afkstumptp = Instance.new("TextButton")
local Stinger = Instance.new("TextButton")
local Kingamulettp = Instance.new("TextButton")
local ExtraPage = Instance.new("ScrollingFrame")
local Autodig = Instance.new("TextButton")
local Autobuffitem = Instance.new("TextButton")
local Killcoconutcrab = Instance.new("TextButton")
local KillTunnel = Instance.new("TextButton")
local Usenightbell = Instance.new("TextButton")
local Usefielddice = Instance.new("TextButton")
local Autokillvicious = Instance.new("TextButton")
local Autokillwindy = Instance.new("TextButton")
local Autokillmonster = Instance.new("TextButton")
local RemoteQuest = Instance.new("TextButton")
local Autogumdrop = Instance.new("TextButton")
local FindWindBee = Instance.new("TextButton")
local Useglitter = Instance.new("TextButton")
local Autogliter = Instance.new("TextButton")
local Autococonut = Instance.new("TextButton")
local Autostinger = Instance.new("TextButton")
local Eqipdemonmask = Instance.new("TextButton")
local Equipdemonmask = Instance.new("TextButton")
local Equipgummymask = Instance.new("TextButton")
local Automagicbean = Instance.new("TextButton")
local Bringtornado = Instance.new("TextButton")
local Killstumnail = Instance.new("TextButton")
local Dropweapon = Instance.new("TextButton")
local Noclip = Instance.new("TextButton")
local AutoDispenser = Instance.new("TextButton")
local Autotop = Instance.new("TextButton")
local AutoDispenser_2 = Instance.new("TextButton")
local Autored = Instance.new("TextButton")
local Autoblue = Instance.new("TextButton")
local ExtrasButton = Instance.new("TextButton")
local FarmingButton = Instance.new("TextButton")
local HomeButton = Instance.new("TextButton")
local SettingButton = Instance.new("TextButton")
local WaypointsButton = Instance.new("TextButton")
local SettingPage = Instance.new("Frame")
local Antiafk = Instance.new("TextLabel")
local Antiafkbutton = Instance.new("TextButton")
local Close = Instance.new("TextButton")
local DarkCyberLoadingGUI = Instance.new("ScreenGui")
local LoadingFrame = Instance.new("Frame")
local Loadingimage = Instance.new("ImageLabel")
local Createtitle = Instance.new("TextLabel")
local NameTitle = Instance.new("TextLabel")
local Loadingtext = Instance.new("TextLabel")
local DarkCyberSynapshitGUI = Instance.new("ScreenGui")
local SynapShitPage = Instance.new("Frame")
local Createtitle = Instance.new("TextLabel")
local NameTitle = Instance.new("TextLabel")
local Welcome = Instance.new("TextLabel")
local Ingnore = Instance.new("TextButton")
local OnlyHoney = Instance.new("TextButton")
local FarmBublle = Instance.new("TextButton")
local TweenBtn = Instance.new("TextButton")
local TpBtn = Instance.new("TextButton")
local WalkBtn = Instance.new("TextButton")
local WalkBtn2 = Instance.new("TextButton")
local TypeF = Instance.new("TextLabel")
local Mobbtn = Instance.new("TextButton")
local AutoPolar = Instance.new("TextButton")




local onlyhoney = false
local nothoney = false
local farmbubble = false
--local automob = false
local TypeFarming = "Tween"

function tpT(t,k) 

      if k == nil then k=1 end
      local plr = game:service"Players".LocalPlayer;
      local tween_s = game:service"TweenService";
      local info = TweenInfo.new(k,Enum.EasingStyle.Quad);
      local tic_k = tick();
     --local params = {...};
     --local cframe = CFrame.new(params[1],params[2],params[3]);
     local cframe = t;
     local tween,err = pcall(function()
         local tween = tween_s:Create(plr.Character["HumanoidRootPart"],info,{CFrame=cframe});
         local done = false;
         --print(done)
         tween.Completed:Connect(function() 
            done=true;
         end)
           noclip = true
         tween:Play();
         while(done==false) do
            wait()
            if act6temp then 
                  tween:Pause()
                  
                  done = true end
          --print(tostring(done.."k"))
         
         end
           noclip = false
        -- print(done)
         
         
     end)
     --syn.write_clipboard(err)
     --print(err)
     if not tween then return err end


end


function tp(t,k)
 if TypeFarming == "Tween" then 
   tpT(t,k)

else if TypeFarming=="Tp" then 
      game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = t
      if k then wait(k) else wait(1) end
else if TypeFarming=="Walking" then
      --game:GetService("Players").LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(t.Position.X,t.Position.Y,t.Position.Z))
      --game:GetService("Players").LocalPlayer.Character.Humanoid.MoveToFinished:Wait()
      --WalkToHive(t)
      local Players = game:GetService("Players")
      local Character = Players.LocalPlayer.Character
      local Humanoid = Character.Humanoid
      local stop = false
      Humanoid:MoveTo(t.p)
      Humanoid.MoveToFinished:Connect(function() 
      stop = true
      end)
      local a = tick()
      while (stop == false)do
      wait()
      if act6temp then
      Humanoid:Move(Vector3.new(0, 0, 0))
      stop = true
      
      end
      Dig()
      if tick()-a>=5 then
            Humanoid:Move(Vector3.new(0, 0, 0)) 
            --Character.HumanoidRootPart.CFrame = game.Workspace.FlowerZones[tuoidz].CFrame
            stop = true
            --wait(1)
       end
      end
else
      WalkToHive(t)

end
end
end
      
         
      end

--Properties:
DarkCyberMainGUI.Name = "[DarkCyber]MainGUI"
ProtectUI(DarkCyberMainGUI)

TweenBtn.Name = "TweenBtn"
TweenBtn.Parent = SettingPage
TweenBtn.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
TweenBtn.BorderSizePixel = 0
TweenBtn.Position = UDim2.new(0.3264150947, 0, 0.0853963569, 0)
TweenBtn.Size = UDim2.new(0, 98, 0, 20)
TweenBtn.Font = Enum.Font.GothamBold
TweenBtn.Text = "Tween Farm"
TweenBtn.TextColor3 = Color3.new(1, 1, 1)
TweenBtn.TextSize = 14


TpBtn.Name = "TpBtn"
TpBtn.Parent = SettingPage
TpBtn.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
TpBtn.BorderSizePixel = 0
TpBtn.Position = UDim2.new(0.5264150947, 0, 0.0853963569, 0)
TpBtn.Size = UDim2.new(0, 98, 0, 20)
TpBtn.Font = Enum.Font.GothamBold
TpBtn.Text = "Tp Farm"
TpBtn.TextColor3 = Color3.new(1, 1, 1)
TpBtn.TextSize = 14

WalkBtn.Name = "WalkBtn"
WalkBtn.Parent = SettingPage
WalkBtn.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
WalkBtn.BorderSizePixel = 0
WalkBtn.Position = UDim2.new(0.7264150947, 0, 0.0853963569, 0)
WalkBtn.Size = UDim2.new(0, 98, 0, 20)
WalkBtn.Font = Enum.Font.GothamBold
WalkBtn.Text = "Walk Farm"
WalkBtn.TextColor3 = Color3.new(1, 1, 1)
WalkBtn.TextSize = 14

WalkBtn2.Name = "WalkBtn2"
WalkBtn2.Parent = SettingPage
WalkBtn2.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
WalkBtn2.BorderSizePixel = 0
WalkBtn2.Position = UDim2.new(0.3264150947, 0, 0.2853963569, 0)
WalkBtn2.Size = UDim2.new(0, 98, 0, 20)
WalkBtn2.Font = Enum.Font.GothamBold
WalkBtn2.Text = "Walk Farm 2"
WalkBtn2.TextColor3 = Color3.new(1, 1, 1)
WalkBtn2.TextSize = 14
WalkBtn2.Visible = false


TypeF.Name = "TypeF"
TypeF.Parent = SettingPage
TypeF.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
TypeF.BorderSizePixel = 0
TypeF.Position = UDim2.new(0.0264150947, 0, 0.2853963569, 0)
TypeF.Size = UDim2.new(0, 98, 0, 20)
TypeF.Font = Enum.Font.GothamBold
TypeF.Text = "Type farming: Tween"
TypeF.TextColor3 = Color3.new(1, 1, 1)
TypeF.TextSize = 14


-- TweenBtn.Name = "TweenBtn"
-- TweenBtn.Parent = SettingPage
-- TweenBtn.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
-- TweenBtn.BorderSizePixel = 0
-- TweenBtn.Position = UDim2.new(0.3264150947, 0, 0.0853963569, 0)
-- TweenBtn.Size = UDim2.new(0, 98, 0, 20)
-- TweenBtn.Font = Enum.Font.GothamBold
-- TweenBtn.Text = "Tween Farm"
-- TweenBtn.TextColor3 = Color3.new(1, 1, 1)
-- TweenBtn.TextSize = 14


Ingnore.Name = "Ingnore"
Ingnore.Parent = ExtraPage
Ingnore.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Ingnore.BorderSizePixel = 0
Ingnore.Position = UDim2.new(0.016, 0, 0.319999999, 0)
Ingnore.Size = UDim2.new(0, 200, 0, 20)
Ingnore.Font = Enum.Font.GothamBold
Ingnore.Text = "Ingnore honey token"
Ingnore.TextColor3 = Color3.new(1, 1, 1)
Ingnore.TextSize = 14

Mobbtn.Name = "Mobbtn"
Mobbtn.Parent = ExtraPage
Mobbtn.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Mobbtn.BorderSizePixel = 0
Mobbtn.Position = UDim2.new(0.4, 0, 0.37, 0)
Mobbtn.Size = UDim2.new(0, 200, 0, 20)
Mobbtn.Font = Enum.Font.GothamBold
Mobbtn.Text = "Auto mob"
Mobbtn.TextColor3 = Color3.new(1, 1, 1)
Mobbtn.TextSize = 14

AutoPolar.Name = "AutoPolar"
AutoPolar.Parent = ExtraPage
AutoPolar.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
AutoPolar.BorderSizePixel = 0
AutoPolar.Position = UDim2.new(0.016, 0, 0.42, 0)
AutoPolar.Size = UDim2.new(0, 400, 0, 20)
AutoPolar.Font = Enum.Font.GothamBold
AutoPolar.Text = "Auto Farm Polar Quest (Quest menu must open)"
AutoPolar.TextColor3 = Color3.new(1, 1, 1)
AutoPolar.TextSize = 14
--AutoPolar.TextWrap = true

OnlyHoney.Name = "OnlyHoney"
OnlyHoney.Parent = ExtraPage
OnlyHoney.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
OnlyHoney.BorderSizePixel = 0
OnlyHoney.Position = UDim2.new(0.4, 0, 0.319999999, 0)
OnlyHoney.Size = UDim2.new(0, 200, 0, 20)
OnlyHoney.Font = Enum.Font.GothamBold
OnlyHoney.Text = "Only honey token"
OnlyHoney.TextColor3 = Color3.new(1, 1, 1)
OnlyHoney.TextSize = 14

FarmBublle.Name = "FarmBublle"
FarmBublle.Parent = ExtraPage
FarmBublle.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
FarmBublle.BorderSizePixel = 0
FarmBublle.Position = UDim2.new(0.016, 0, 0.37, 0)
FarmBublle.Size = UDim2.new(0, 200, 0, 20)
FarmBublle.Font = Enum.Font.GothamBold
FarmBublle.Text = "Auto Farm Bubble Float"
FarmBublle.TextColor3 = Color3.new(1, 1, 1)
FarmBublle.TextSize = 14

MiniPage.Name = "MiniPage"
MiniPage.Parent = DarkCyberMainGUI
MiniPage.BackgroundColor3 = Color3.new(0.321569, 0.462745, 1)
MiniPage.BorderSizePixel = 0
MiniPage.Position = UDim2.new(0.361979187, 0, -0.7, 0)
MiniPage.Size = UDim2.new(0, 530, 0, 25)

Destroy.Name = "Destroy"
Destroy.Parent = MiniPage
Destroy.BackgroundColor3 = Color3.new(1, 1, 1)
Destroy.BackgroundTransparency = 1
Destroy.Position = UDim2.new(0.950854659, 0, 0, 0)
Destroy.Size = UDim2.new(0, 25, 0, 25)
Destroy.Font = Enum.Font.GothamBold
Destroy.Text = "X"
Destroy.TextColor3 = Color3.new(1, 1, 1)
Destroy.TextSize = 20

GameText.Name = "GameText"
GameText.Parent = MiniPage
GameText.BackgroundColor3 = Color3.new(1, 1, 1)
GameText.BackgroundTransparency = 1
GameText.Position = UDim2.new(0.337588102, 0, -0.0399999991, 0)
GameText.Size = UDim2.new(0.324587107, 0, 0.999999702, 0)
GameText.Font = Enum.Font.GothamBold
GameText.Text = "Bee Swarm Simulator"
GameText.TextColor3 = Color3.new(1, 1, 1)
GameText.TextSize = 16

MainPage.Name = "MainPage"
MainPage.Parent = MiniPage
MainPage.Active = true
MainPage.BackgroundColor3 = Color3.new(0.321569, 0.462745, 1)
MainPage.BorderSizePixel = 0
MainPage.Position = UDim2.new(0, 0, 1.0016675, 0)
MainPage.Selectable = true
MainPage.Size = UDim2.new(1, 0, 8.9163208, 0)

VersionText.Name = "VersionText"
VersionText.Parent = MainPage
VersionText.BackgroundColor3 = Color3.new(1, 1, 1)
VersionText.BackgroundTransparency = 1
VersionText.Position = UDim2.new(-0.00158959627, 0, 0.914668798, 0)
VersionText.Size = UDim2.new(0.213481352, 0, 0.08324752, 0)
VersionText.Font = Enum.Font.GothamBold
VersionText.Text = "Version: 1.0.0"
VersionText.TextColor3 = Color3.new(1, 1, 1)
VersionText.TextSize = 16

HomePage.Name = "HomePage"
HomePage.Parent = MainPage
HomePage.BackgroundColor3 = Color3.new(1, 1, 1)
HomePage.BackgroundTransparency = 1
HomePage.BorderSizePixel = 0
HomePage.Position = UDim2.new(0, 0, 0.132234111, 0)
HomePage.Size = UDim2.new(1, 0, 0.782434821, 0)

ImageGang.Name = "ImageGang"
ImageGang.Parent = HomePage
ImageGang.BackgroundColor3 = Color3.new(1, 1, 1)
ImageGang.Position = UDim2.new(0.0295857992, 0, 0.0601093024, 0)
ImageGang.Size = UDim2.new(0, 70, 0, 70)
ImageGang.Image = "http://www.roblox.com/asset/?id=3766691866"

CreditText.Name = "CreditText"
CreditText.Parent = HomePage
CreditText.BackgroundColor3 = Color3.new(1, 1, 1)
CreditText.BackgroundTransparency = 1
CreditText.Position = UDim2.new(0.188195452, 0, 0.0601093657, 0)
CreditText.Size = UDim2.new(0.809829473, 0, 0.382513672, 0)
CreditText.Font = Enum.Font.GothamBold
CreditText.Text = "Gui Create : DarkCyber (Edited by Kiet1308)"
CreditText.TextColor3 = Color3.new(1, 1, 1)
CreditText.TextSize = 20

JoinText.Name = "JoinText"
JoinText.Parent = HomePage
JoinText.BackgroundColor3 = Color3.new(1, 1, 1)
JoinText.BackgroundTransparency = 1
JoinText.Position = UDim2.new(0, 0, 0.453551859, 0)
JoinText.Size = UDim2.new(0.998024881, 0, 0.146612123, 0)
JoinText.Font = Enum.Font.GothamBold
JoinText.Text = "Join Discord for more Update"
JoinText.TextColor3 = Color3.new(1, 1, 1)
JoinText.TextSize = 17

DiscordlinkTest.Name = "DiscordlinkTest"
DiscordlinkTest.Parent = HomePage
DiscordlinkTest.BackgroundColor3 = Color3.new(1, 1, 1)
DiscordlinkTest.BackgroundTransparency = 1
DiscordlinkTest.Position = UDim2.new(0, 0, 0.601092875, 0)
DiscordlinkTest.Size = UDim2.new(0.998024881, 0, 0.146612123, 0)
DiscordlinkTest.Font = Enum.Font.GothamBold
DiscordlinkTest.Text = "Link: https://discord.gg/yXNjfMa"
DiscordlinkTest.TextColor3 = Color3.new(1, 1, 1)
DiscordlinkTest.TextSize = 17

Copylinkdiscord.Name = "Copylinkdiscord"
Copylinkdiscord.Parent = HomePage
Copylinkdiscord.BackgroundColor3 = Color3.new(0.454902, 0.137255, 1)
Copylinkdiscord.BorderSizePixel = 0
Copylinkdiscord.Position = UDim2.new(0.0295858085, 0, 0.79781419, 0)
Copylinkdiscord.Size = UDim2.new(0.476331353, 0, 0.131147563, 0)
Copylinkdiscord.Font = Enum.Font.GothamBold
Copylinkdiscord.Text = "COPY LINK DISCORD"
Copylinkdiscord.TextColor3 = Color3.new(1, 1, 1)
Copylinkdiscord.TextSize = 14

FarmingPage.Name = "FarmingPage"
FarmingPage.Parent = MainPage
FarmingPage.BackgroundColor3 = Color3.new(1, 1, 1)
FarmingPage.BackgroundTransparency = 1
FarmingPage.Position = UDim2.new(-5.75803369e-08, 0, 0.127000019, 0)
FarmingPage.Size = UDim2.new(0.999777615, 0, 0.787668824, 0)
FarmingPage.Visible = false

FieldSelectPage.Name = "FieldSelectPage"
FieldSelectPage.Parent = FarmingPage
FieldSelectPage.BackgroundColor3 = Color3.new(0.482353, 0.447059, 1)
FieldSelectPage.BorderSizePixel = 0
FieldSelectPage.Position = UDim2.new(0.0228317082, 0, 0.16433613, 0)
FieldSelectPage.Size = UDim2.new(0.400000006, 0, 0.835663855, 0)
FieldSelectPage.ScrollBarThickness = 5

SunflowerButton.Name = "SunflowerButton"
SunflowerButton.Parent = FieldSelectPage
SunflowerButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
SunflowerButton.BorderSizePixel = 0
SunflowerButton.Position = UDim2.new(0.108427808, 0, 0.0228219759, 0)
SunflowerButton.Size = UDim2.new(0, 160, 0, 20)
SunflowerButton.Font = Enum.Font.GothamBold
SunflowerButton.Text = "Sunflower Field"
SunflowerButton.TextColor3 = Color3.new(1, 1, 1)
SunflowerButton.TextSize = 14

MushroomButton.Name = "MushroomButton"
MushroomButton.Parent = FieldSelectPage
MushroomButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
MushroomButton.BorderSizePixel = 0
MushroomButton.Position = UDim2.new(0.108427808, 0, 0.0791205987, 0)
MushroomButton.Size = UDim2.new(0, 160, 0, 20)
MushroomButton.Font = Enum.Font.GothamBold
MushroomButton.Text = "Mushroom Field"
MushroomButton.TextColor3 = Color3.new(1, 1, 1)
MushroomButton.TextSize = 14

SpiderButton.Name = "SpiderButton"
SpiderButton.Parent = FieldSelectPage
SpiderButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
SpiderButton.BorderSizePixel = 0
SpiderButton.Position = UDim2.new(0.108427808, 0, 0.412541032, 0)
SpiderButton.Size = UDim2.new(0, 160, 0, 20)
SpiderButton.Font = Enum.Font.GothamBold
SpiderButton.Text = "Spider Field"
SpiderButton.TextColor3 = Color3.new(1, 1, 1)
SpiderButton.TextSize = 14

BambooButton.Name = "BambooButton"
BambooButton.Parent = FieldSelectPage
BambooButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
BambooButton.BorderSizePixel = 0
BambooButton.Position = UDim2.new(0.108427808, 0, 0.355216533, 0)
BambooButton.Size = UDim2.new(0, 160, 0, 20)
BambooButton.Font = Enum.Font.GothamBold
BambooButton.Text = "Bamboo Field"
BambooButton.TextColor3 = Color3.new(1, 1, 1)
BambooButton.TextSize = 14

RoseButton.Name = "RoseButton"
RoseButton.Parent = FieldSelectPage
RoseButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
RoseButton.BorderSizePixel = 0
RoseButton.Position = UDim2.new(0.108427808, 0, 0.524258256, 0)
RoseButton.Size = UDim2.new(0, 160, 0, 20)
RoseButton.Font = Enum.Font.GothamBold
RoseButton.Text = "Rose Field"
RoseButton.TextColor3 = Color3.new(1, 1, 1)
RoseButton.TextSize = 14

PineTreeButton.Name = "PineTreeButton"
PineTreeButton.Parent = FieldSelectPage
PineTreeButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
PineTreeButton.BorderSizePixel = 0
PineTreeButton.Position = UDim2.new(0.108427808, 0, 0.467443049, 0)
PineTreeButton.Size = UDim2.new(0, 160, 0, 20)
PineTreeButton.Font = Enum.Font.GothamBold
PineTreeButton.Text = "Pine Tree Field"
PineTreeButton.TextColor3 = Color3.new(1, 1, 1)
PineTreeButton.TextSize = 14

CactusButton.Name = "CactusButton"
CactusButton.Parent = FieldSelectPage
CactusButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
CactusButton.BorderSizePixel = 0
CactusButton.Position = UDim2.new(0.108427808, 0, 0.579347968, 0)
CactusButton.Size = UDim2.new(0, 160, 0, 20)
CactusButton.Font = Enum.Font.GothamBold
CactusButton.Text = "Cactus Field"
CactusButton.TextColor3 = Color3.new(1, 1, 1)
CactusButton.TextSize = 14

PumpkinButton.Name = "PumpkinButton"
PumpkinButton.Parent = FieldSelectPage
PumpkinButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
PumpkinButton.BorderSizePixel = 0
PumpkinButton.Position = UDim2.new(0.108427808, 0, 0.633908749, 0)
PumpkinButton.Size = UDim2.new(0, 160, 0, 20)
PumpkinButton.Font = Enum.Font.GothamBold
PumpkinButton.Text = "Pumpkin Field"
PumpkinButton.TextColor3 = Color3.new(1, 1, 1)
PumpkinButton.TextSize = 14

PineappleButton.Name = "PineappleButton"
PineappleButton.Parent = FieldSelectPage
PineappleButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
PineappleButton.BorderSizePixel = 0
PineappleButton.Position = UDim2.new(0.108427808, 0, 0.688469529, 0)
PineappleButton.Size = UDim2.new(0, 160, 0, 20)
PineappleButton.Font = Enum.Font.GothamBold
PineappleButton.Text = "Pineapple Field"
PineappleButton.TextColor3 = Color3.new(1, 1, 1)
PineappleButton.TextSize = 14

StumpButton.Name = "StumpButton"
StumpButton.Parent = FieldSelectPage
StumpButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
StumpButton.BorderSizePixel = 0
StumpButton.Position = UDim2.new(0.108427808, 0, 0.74303031, 0)
StumpButton.Size = UDim2.new(0, 160, 0, 20)
StumpButton.Font = Enum.Font.GothamBold
StumpButton.Text = "Stump Field"
StumpButton.TextColor3 = Color3.new(1, 1, 1)
StumpButton.TextSize = 14

MountainTopButton.Name = "MountainTopButton"
MountainTopButton.Parent = FieldSelectPage
MountainTopButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
MountainTopButton.BorderSizePixel = 0
MountainTopButton.Position = UDim2.new(0.108427808, 0, 0.797487676, 0)
MountainTopButton.Size = UDim2.new(0, 160, 0, 20)
MountainTopButton.Font = Enum.Font.GothamBold
MountainTopButton.Text = "Mountain Top Field"
MountainTopButton.TextColor3 = Color3.new(1, 1, 1)
MountainTopButton.TextSize = 14

CoconutButton.Name = "CoconutButton"
CoconutButton.Parent = FieldSelectPage
CoconutButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
CoconutButton.BorderSizePixel = 0
CoconutButton.Position = UDim2.new(0.108427808, 0, 0.852136731, 0)
CoconutButton.Size = UDim2.new(0, 160, 0, 20)
CoconutButton.Font = Enum.Font.GothamBold
CoconutButton.Text = "Coconut Field"
CoconutButton.TextColor3 = Color3.new(1, 1, 1)
CoconutButton.TextSize = 14

PepperButton.Name = "PepperButton"
PepperButton.Parent = FieldSelectPage
PepperButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
PepperButton.BorderSizePixel = 0
PepperButton.Position = UDim2.new(0.108427808, 0, 0.908951104, 0)
PepperButton.Size = UDim2.new(0, 160, 0, 20)
PepperButton.Font = Enum.Font.GothamBold
PepperButton.Text = "Pepper Field"
PepperButton.TextColor3 = Color3.new(1, 1, 1)
PepperButton.TextSize = 14

StawberryButton.Name = "StawberryButton"
StawberryButton.Parent = FieldSelectPage
StawberryButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
StawberryButton.BorderSizePixel = 0
StawberryButton.Position = UDim2.new(0.108427808, 0, 0.300172061, 0)
StawberryButton.Size = UDim2.new(0, 160, 0, 20)
StawberryButton.Font = Enum.Font.GothamBold
StawberryButton.Text = "Strawberry Field"
StawberryButton.TextColor3 = Color3.new(1, 1, 1)
StawberryButton.TextSize = 14

BlueflowerButton.Name = "BlueflowerButton"
BlueflowerButton.Parent = FieldSelectPage
BlueflowerButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
BlueflowerButton.BorderSizePixel = 0
BlueflowerButton.Position = UDim2.new(0.108427808, 0, 0.135357112, 0)
BlueflowerButton.Size = UDim2.new(0, 160, 0, 20)
BlueflowerButton.Font = Enum.Font.GothamBold
BlueflowerButton.Text = "Blue Folower Field"
BlueflowerButton.TextColor3 = Color3.new(1, 1, 1)
BlueflowerButton.TextSize = 14

DanrButton.Name = "DanrButton"
DanrButton.Parent = FieldSelectPage
DanrButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
DanrButton.BorderSizePixel = 0
DanrButton.Position = UDim2.new(0.108427808, 0, 0.189853355, 0)
DanrButton.Size = UDim2.new(0, 160, 0, 20)
DanrButton.Font = Enum.Font.GothamBold
DanrButton.Text = "Dandelion Field"
DanrButton.TextColor3 = Color3.new(1, 1, 1)
DanrButton.TextSize = 14

DanrButton_2.Name = "DanrButton"
DanrButton_2.Parent = FieldSelectPage
DanrButton_2.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
DanrButton_2.BorderSizePixel = 0
DanrButton_2.Position = UDim2.new(0.108427808, 0, 0.244349569, 0)
DanrButton_2.Size = UDim2.new(0, 160, 0, 20)
DanrButton_2.Font = Enum.Font.GothamBold
DanrButton_2.Text = "Clover Field"
DanrButton_2.TextColor3 = Color3.new(1, 1, 1)
DanrButton_2.TextSize = 14

FieldSelectText.Name = "FieldSelectText"
FieldSelectText.Parent = FarmingPage
FieldSelectText.BackgroundColor3 = Color3.new(1, 1, 1)
FieldSelectText.BackgroundTransparency = 1
FieldSelectText.Position = UDim2.new(0.0247862451, 0, 0.0436922573, 0)
FieldSelectText.Size = UDim2.new(0.398045629, 0, 0.114787988, 0)
FieldSelectText.Font = Enum.Font.GothamBlack
FieldSelectText.Text = "Field Select"
FieldSelectText.TextColor3 = Color3.new(1, 1, 1)
FieldSelectText.TextSize = 16

FieldText.Name = "FieldText"
FieldText.Parent = FarmingPage
FieldText.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
FieldText.BorderSizePixel = 0
FieldText.Position = UDim2.new(0.446999997, 0, 0.170000002, 0)
FieldText.Size = UDim2.new(0.530130506, 0, 0.100000001, 0)
FieldText.Font = Enum.Font.GothamBold
FieldText.Text = " Field Select: Loading..."
FieldText.TextColor3 = Color3.new(1, 1, 1)
FieldText.TextSize = 14
FieldText.TextXAlignment = Enum.TextXAlignment.Left

StartButton.Name = "StartButton"
StartButton.Parent = FarmingPage
StartButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
StartButton.BorderSizePixel = 0
StartButton.Position = UDim2.new(0.446999997, 0, 0.300000012, 0)
StartButton.Size = UDim2.new(0.530328393, 0, 0.100000001, 0)
StartButton.Font = Enum.Font.GothamBold
StartButton.Text = "Start Farming"
StartButton.TextColor3 = Color3.new(1, 1, 1)
StartButton.TextSize = 14

FieldSelectText_2.Name = "FieldSelectText"
FieldSelectText_2.Parent = FarmingPage
FieldSelectText_2.BackgroundColor3 = Color3.new(1, 1, 1)
FieldSelectText_2.BackgroundTransparency = 1
FieldSelectText_2.Position = UDim2.new(0.447186798, 0, 0.0436922573, 0)
FieldSelectText_2.Size = UDim2.new(0.530446231, 0, 0.114787988, 0)
FieldSelectText_2.Font = Enum.Font.GothamBlack
FieldSelectText_2.Text = "Farming Status"
FieldSelectText_2.TextColor3 = Color3.new(1, 1, 1)
FieldSelectText_2.TextSize = 14

WaypointPage.Name = "WaypointPage"
WaypointPage.Parent = MainPage
WaypointPage.BackgroundColor3 = Color3.new(1, 1, 1)
WaypointPage.BackgroundTransparency = 1
WaypointPage.Position = UDim2.new(0, 0, 0.127000034, 0)
WaypointPage.Size = UDim2.new(0, 530, 0, 174)
WaypointPage.Visible = false
WaypointPage.CanvasSize = UDim2.new(0, 0, 3, 0)
WaypointPage.ScrollBarThickness = 5

Suntp.Name = "Suntp"
Suntp.Parent = WaypointPage
Suntp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Suntp.BorderSizePixel = 0
Suntp.Position = UDim2.new(0.0160000008, 0, 0.0199999996, 0)
Suntp.Size = UDim2.new(0, 120, 0, 20)
Suntp.Font = Enum.Font.GothamBold
Suntp.Text = "Sunflower Field"
Suntp.TextColor3 = Color3.new(1, 1, 1)
Suntp.TextSize = 14

Mushtp.Name = "Mushtp"
Mushtp.Parent = WaypointPage
Mushtp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Mushtp.BorderSizePixel = 0
Mushtp.Position = UDim2.new(0.261000007, 0, 0.0199999996, 0)
Mushtp.Size = UDim2.new(0, 120, 0, 20)
Mushtp.Font = Enum.Font.GothamBold
Mushtp.Text = "Mushroom Field"
Mushtp.TextColor3 = Color3.new(1, 1, 1)
Mushtp.TextSize = 14

Dantp.Name = "Dantp"
Dantp.Parent = WaypointPage
Dantp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Dantp.BorderSizePixel = 0
Dantp.Position = UDim2.new(0.510999978, 0, 0.0199999996, 0)
Dantp.Size = UDim2.new(0, 120, 0, 20)
Dantp.Font = Enum.Font.GothamBold
Dantp.Text = "Dandelion Field"
Dantp.TextColor3 = Color3.new(1, 1, 1)
Dantp.TextSize = 14

Blueftp.Name = "Blueftp"
Blueftp.Parent = WaypointPage
Blueftp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Blueftp.BorderSizePixel = 0
Blueftp.Position = UDim2.new(0.755999982, 0, 0.0199999996, 0)
Blueftp.Size = UDim2.new(0, 120, 0, 20)
Blueftp.Font = Enum.Font.GothamBold
Blueftp.Text = "Blueflower Field"
Blueftp.TextColor3 = Color3.new(1, 1, 1)
Blueftp.TextSize = 14

Clovertp.Name = "Clovertp"
Clovertp.Parent = WaypointPage
Clovertp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Clovertp.BorderSizePixel = 0
Clovertp.Position = UDim2.new(0.0160000008, 0, 0.0599999987, 0)
Clovertp.Size = UDim2.new(0, 120, 0, 20)
Clovertp.Font = Enum.Font.GothamBold
Clovertp.Text = "Clover Field"
Clovertp.TextColor3 = Color3.new(1, 1, 1)
Clovertp.TextSize = 14

Bambootp.Name = "Bambootp"
Bambootp.Parent = WaypointPage
Bambootp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Bambootp.BorderSizePixel = 0
Bambootp.Position = UDim2.new(0.261000007, 0, 0.0599999987, 0)
Bambootp.Size = UDim2.new(0, 120, 0, 20)
Bambootp.Font = Enum.Font.GothamBold
Bambootp.Text = "Bamboo Field"
Bambootp.TextColor3 = Color3.new(1, 1, 1)
Bambootp.TextSize = 14

Spidertp.Name = "Spidertp"
Spidertp.Parent = WaypointPage
Spidertp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Spidertp.BorderSizePixel = 0
Spidertp.Position = UDim2.new(0.510999978, 0, 0.0599999987, 0)
Spidertp.Size = UDim2.new(0, 120, 0, 20)
Spidertp.Font = Enum.Font.GothamBold
Spidertp.Text = "Spider Field"
Spidertp.TextColor3 = Color3.new(1, 1, 1)
Spidertp.TextSize = 14

Strawtp.Name = "Strawtp"
Strawtp.Parent = WaypointPage
Strawtp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Strawtp.BorderSizePixel = 0
Strawtp.Position = UDim2.new(0.755999982, 0, 0.0599999987, 0)
Strawtp.Size = UDim2.new(0, 120, 0, 20)
Strawtp.Font = Enum.Font.GothamBold
Strawtp.Text = "Strawbery Field"
Strawtp.TextColor3 = Color3.new(1, 1, 1)
Strawtp.TextSize = 14

Castustp.Name = "Castustp"
Castustp.Parent = WaypointPage
Castustp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Castustp.BorderSizePixel = 0
Castustp.Position = UDim2.new(0.0160000008, 0, 0.100354269, 0)
Castustp.Size = UDim2.new(0, 120, 0, 20)
Castustp.Font = Enum.Font.GothamBold
Castustp.Text = "Cactus Field"
Castustp.TextColor3 = Color3.new(1, 1, 1)
Castustp.TextSize = 14

Pumtp.Name = "Pumtp"
Pumtp.Parent = WaypointPage
Pumtp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Pumtp.BorderSizePixel = 0
Pumtp.Position = UDim2.new(0.261000007, 0, 0.100354269, 0)
Pumtp.Size = UDim2.new(0, 120, 0, 20)
Pumtp.Font = Enum.Font.GothamBold
Pumtp.Text = "Pumpkin Field"
Pumtp.TextColor3 = Color3.new(1, 1, 1)
Pumtp.TextSize = 14

Pintreetp.Name = "Pintreetp"
Pintreetp.Parent = WaypointPage
Pintreetp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Pintreetp.BorderSizePixel = 0
Pintreetp.Position = UDim2.new(0.510999978, 0, 0.100354269, 0)
Pintreetp.Size = UDim2.new(0, 120, 0, 20)
Pintreetp.Font = Enum.Font.GothamBold
Pintreetp.Text = "Pine Tree Field"
Pintreetp.TextColor3 = Color3.new(1, 1, 1)
Pintreetp.TextSize = 14

Rosetp.Name = "Rosetp"
Rosetp.Parent = WaypointPage
Rosetp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Rosetp.BorderSizePixel = 0
Rosetp.Position = UDim2.new(0.755999982, 0, 0.100354269, 0)
Rosetp.Size = UDim2.new(0, 120, 0, 20)
Rosetp.Font = Enum.Font.GothamBold
Rosetp.Text = "Rose Field"
Rosetp.TextColor3 = Color3.new(1, 1, 1)
Rosetp.TextSize = 14

Toptp.Name = "Toptp"
Toptp.Parent = WaypointPage
Toptp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Toptp.BorderSizePixel = 0
Toptp.Position = UDim2.new(0.755999982, 0, 0.140000001, 0)
Toptp.Size = UDim2.new(0, 120, 0, 20)
Toptp.Font = Enum.Font.GothamBold
Toptp.Text = "Mountain Field"
Toptp.TextColor3 = Color3.new(1, 1, 1)
Toptp.TextSize = 14

Coconuttp.Name = "Coconuttp"
Coconuttp.Parent = WaypointPage
Coconuttp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Coconuttp.BorderSizePixel = 0
Coconuttp.Position = UDim2.new(0.510999978, 0, 0.140000001, 0)
Coconuttp.Size = UDim2.new(0, 120, 0, 20)
Coconuttp.Font = Enum.Font.GothamBold
Coconuttp.Text = "Coconut Field"
Coconuttp.TextColor3 = Color3.new(1, 1, 1)
Coconuttp.TextSize = 14

Stumptp.Name = "Stumptp"
Stumptp.Parent = WaypointPage
Stumptp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Stumptp.BorderSizePixel = 0
Stumptp.Position = UDim2.new(0.261000007, 0, 0.140000001, 0)
Stumptp.Size = UDim2.new(0, 120, 0, 20)
Stumptp.Font = Enum.Font.GothamBold
Stumptp.Text = "Stump Field"
Stumptp.TextColor3 = Color3.new(1, 1, 1)
Stumptp.TextSize = 14

Pineappletp.Name = "Pineappletp"
Pineappletp.Parent = WaypointPage
Pineappletp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Pineappletp.BorderSizePixel = 0
Pineappletp.Position = UDim2.new(0.0160000008, 0, 0.140000001, 0)
Pineappletp.Size = UDim2.new(0, 120, 0, 20)
Pineappletp.Font = Enum.Font.GothamBold
Pineappletp.Text = "Pineapple Field"
Pineappletp.TextColor3 = Color3.new(1, 1, 1)
Pineappletp.TextSize = 14

Peppertp.Name = "Peppertp"
Peppertp.Parent = WaypointPage
Peppertp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Peppertp.BorderSizePixel = 0
Peppertp.Position = UDim2.new(0.0160000008, 0, 0.180000007, 0)
Peppertp.Size = UDim2.new(0, 120, 0, 20)
Peppertp.Font = Enum.Font.GothamBold
Peppertp.Text = "Pepper Field"
Peppertp.TextColor3 = Color3.new(1, 1, 1)
Peppertp.TextSize = 14

SummonSprouttp.Name = "SummonSprouttp"
SummonSprouttp.Parent = WaypointPage
SummonSprouttp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
SummonSprouttp.BorderSizePixel = 0
SummonSprouttp.Position = UDim2.new(0.263000011, 0, 0.180000007, 0)
SummonSprouttp.Size = UDim2.new(0, 120, 0, 20)
SummonSprouttp.Font = Enum.Font.GothamBold
SummonSprouttp.Text = "Sprout"
SummonSprouttp.TextColor3 = Color3.new(1, 1, 1)
SummonSprouttp.TextSize = 14

Coconutshoptp.Name = "Coconutshoptp"
Coconutshoptp.Parent = WaypointPage
Coconutshoptp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Coconutshoptp.BorderSizePixel = 0
Coconutshoptp.Position = UDim2.new(0.513000011, 0, 0.180000007, 0)
Coconutshoptp.Size = UDim2.new(0, 120, 0, 20)
Coconutshoptp.Font = Enum.Font.GothamBold
Coconutshoptp.Text = "Coconut Shop"
Coconutshoptp.TextColor3 = Color3.new(1, 1, 1)
Coconutshoptp.TextSize = 14

Petaltp.Name = "Petaltp"
Petaltp.Parent = WaypointPage
Petaltp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Petaltp.BorderSizePixel = 0
Petaltp.Position = UDim2.new(0.755999982, 0, 0.180000007, 0)
Petaltp.Size = UDim2.new(0, 120, 0, 20)
Petaltp.Font = Enum.Font.GothamBold
Petaltp.Text = "Petal Shop"
Petaltp.TextColor3 = Color3.new(1, 1, 1)
Petaltp.TextSize = 14

Shopproctp.Name = "Shopproctp"
Shopproctp.Parent = WaypointPage
Shopproctp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Shopproctp.BorderSizePixel = 0
Shopproctp.Position = UDim2.new(0.263000011, 0, 0.219999999, 0)
Shopproctp.Size = UDim2.new(0, 120, 0, 20)
Shopproctp.Font = Enum.Font.GothamBold
Shopproctp.Text = "Pro Shop"
Shopproctp.TextColor3 = Color3.new(1, 1, 1)
Shopproctp.TextSize = 14

Shoptoptp.Name = "Shoptoptp"
Shoptoptp.Parent = WaypointPage
Shoptoptp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Shoptoptp.BorderSizePixel = 0
Shoptoptp.Position = UDim2.new(0.513000011, 0, 0.219999999, 0)
Shoptoptp.Size = UDim2.new(0, 120, 0, 20)
Shoptoptp.Font = Enum.Font.GothamBold
Shoptoptp.Text = "Master Shop"
Shoptoptp.TextColor3 = Color3.new(1, 1, 1)
Shoptoptp.TextSize = 14

Shopmoontp.Name = "Shopmoontp"
Shopmoontp.Parent = WaypointPage
Shopmoontp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Shopmoontp.BorderSizePixel = 0
Shopmoontp.Position = UDim2.new(0.755999982, 0, 0.219999999, 0)
Shopmoontp.Size = UDim2.new(0, 120, 0, 20)
Shopmoontp.Font = Enum.Font.GothamBold
Shopmoontp.Text = "Moon Charm"
Shopmoontp.TextColor3 = Color3.new(1, 1, 1)
Shopmoontp.TextSize = 14

Shopbasictp.Name = "Shopbasictp"
Shopbasictp.Parent = WaypointPage
Shopbasictp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Shopbasictp.BorderSizePixel = 0
Shopbasictp.Position = UDim2.new(0.0160000008, 0, 0.219999999, 0)
Shopbasictp.Size = UDim2.new(0, 120, 0, 20)
Shopbasictp.Font = Enum.Font.GothamBold
Shopbasictp.Text = "Noob Shop"
Shopbasictp.TextColor3 = Color3.new(1, 1, 1)
Shopbasictp.TextSize = 14

Shopsprinklertp.Name = "Shopsprinklertp"
Shopsprinklertp.Parent = WaypointPage
Shopsprinklertp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Shopsprinklertp.BorderSizePixel = 0
Shopsprinklertp.Position = UDim2.new(0.0160000008, 0, 0.25999999, 0)
Shopsprinklertp.Size = UDim2.new(0, 120, 0, 20)
Shopsprinklertp.Font = Enum.Font.GothamBold
Shopsprinklertp.Text = "Sprinkler Shop"
Shopsprinklertp.TextColor3 = Color3.new(1, 1, 1)
Shopsprinklertp.TextSize = 14

InstantConversiontp.Name = "InstantConversiontp"
InstantConversiontp.Parent = WaypointPage
InstantConversiontp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
InstantConversiontp.BorderSizePixel = 0
InstantConversiontp.Position = UDim2.new(0.264773577, 0, 0.259568214, 0)
InstantConversiontp.Size = UDim2.new(0, 120, 0, 20)
InstantConversiontp.Font = Enum.Font.GothamBold
InstantConversiontp.Text = "Instant Sell"
InstantConversiontp.TextColor3 = Color3.new(1, 1, 1)
InstantConversiontp.TextSize = 14

MegaMemorytp.Name = "MegaMemorytp"
MegaMemorytp.Parent = WaypointPage
MegaMemorytp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
MegaMemorytp.BorderSizePixel = 0
MegaMemorytp.Position = UDim2.new(0.514773548, 0, 0.259568214, 0)
MegaMemorytp.Size = UDim2.new(0, 120, 0, 20)
MegaMemorytp.Font = Enum.Font.GothamBold
MegaMemorytp.Text = "Mega Memory"
MegaMemorytp.TextColor3 = Color3.new(1, 1, 1)
MegaMemorytp.TextSize = 14

NightMemorytp.Name = "NightMemorytp"
NightMemorytp.Parent = WaypointPage
NightMemorytp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
NightMemorytp.BorderSizePixel = 0
NightMemorytp.Position = UDim2.new(0.755999982, 0, 0.259568214, 0)
NightMemorytp.Size = UDim2.new(0, 120, 0, 20)
NightMemorytp.Font = Enum.Font.GothamBold
NightMemorytp.Text = "Night Memory"
NightMemorytp.TextColor3 = Color3.new(1, 1, 1)
NightMemorytp.TextSize = 14

ExtremeMemorytp.Name = "ExtremeMemorytp"
ExtremeMemorytp.Parent = WaypointPage
ExtremeMemorytp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
ExtremeMemorytp.BorderSizePixel = 0
ExtremeMemorytp.Position = UDim2.new(0.0160000008, 0, 0.300000012, 0)
ExtremeMemorytp.Size = UDim2.new(0, 120, 0, 20)
ExtremeMemorytp.Font = Enum.Font.GothamBold
ExtremeMemorytp.Text = "Extreme Memory"
ExtremeMemorytp.TextColor3 = Color3.new(1, 1, 1)
ExtremeMemorytp.TextSize = 14

StartHalltp.Name = "StartHalltp"
StartHalltp.Parent = WaypointPage
StartHalltp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
StartHalltp.BorderSizePixel = 0
StartHalltp.Position = UDim2.new(0.264999986, 0, 0.300000012, 0)
StartHalltp.Size = UDim2.new(0, 120, 0, 20)
StartHalltp.Font = Enum.Font.GothamBold
StartHalltp.Text = "Star Hall"
StartHalltp.TextColor3 = Color3.new(1, 1, 1)
StartHalltp.TextSize = 14

Anttp.Name = "Anttp"
Anttp.Parent = WaypointPage
Anttp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Anttp.BorderSizePixel = 0
Anttp.Position = UDim2.new(0.514999986, 0, 0.300000012, 0)
Anttp.Size = UDim2.new(0, 120, 0, 20)
Anttp.Font = Enum.Font.GothamBold
Anttp.Text = "Ant"
Anttp.TextColor3 = Color3.new(1, 1, 1)
Anttp.TextSize = 14

Demonmasktp.Name = "Demonmasktp"
Demonmasktp.Parent = WaypointPage
Demonmasktp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Demonmasktp.BorderSizePixel = 0
Demonmasktp.Position = UDim2.new(0.0160000008, 0, 0.379999995, 0)
Demonmasktp.Size = UDim2.new(0, 120, 0, 20)
Demonmasktp.Font = Enum.Font.GothamBold
Demonmasktp.Text = "Demon Mask"
Demonmasktp.TextColor3 = Color3.new(1, 1, 1)
Demonmasktp.TextSize = 14

TunelBeartp.Name = "TunelBeartp"
TunelBeartp.Parent = WaypointPage
TunelBeartp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
TunelBeartp.BorderSizePixel = 0
TunelBeartp.Position = UDim2.new(0.0140000004, 0, 0.340000004, 0)
TunelBeartp.Size = UDim2.new(0, 120, 0, 20)
TunelBeartp.Font = Enum.Font.GothamBold
TunelBeartp.Text = "Tunel Bear"
TunelBeartp.TextColor3 = Color3.new(1, 1, 1)
TunelBeartp.TextSize = 14

WindyBeetp.Name = "WindyBeetp"
WindyBeetp.Parent = WaypointPage
WindyBeetp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
WindyBeetp.BorderSizePixel = 0
WindyBeetp.Position = UDim2.new(0.263000011, 0, 0.340000004, 0)
WindyBeetp.Size = UDim2.new(0, 120, 0, 20)
WindyBeetp.Font = Enum.Font.GothamBold
WindyBeetp.Text = "WindyBee"
WindyBeetp.TextColor3 = Color3.new(1, 1, 1)
WindyBeetp.TextSize = 14

Diamondmasktp.Name = "Diamondmasktp"
Diamondmasktp.Parent = WaypointPage
Diamondmasktp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Diamondmasktp.BorderSizePixel = 0
Diamondmasktp.Position = UDim2.new(0.513999999, 0, 0.340000004, 0)
Diamondmasktp.Size = UDim2.new(0, 120, 0, 20)
Diamondmasktp.Font = Enum.Font.GothamBold
Diamondmasktp.Text = "Diamond Mask"
Diamondmasktp.TextColor3 = Color3.new(1, 1, 1)
Diamondmasktp.TextSize = 14

Soon.Name = "Soon"
Soon.Parent = WaypointPage
Soon.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Soon.BorderSizePixel = 0
Soon.Position = UDim2.new(0.755999982, 0, 0.379999995, 0)
Soon.Size = UDim2.new(0, 120, 0, 20)
Soon.Font = Enum.Font.GothamBold
Soon.Text = "SOON"
Soon.TextColor3 = Color3.new(1, 1, 1)
Soon.TextSize = 14

GummyMask.Name = "GummyMask"
GummyMask.Parent = WaypointPage
GummyMask.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
GummyMask.BorderSizePixel = 0
GummyMask.Position = UDim2.new(0.755999982, 0, 0.340000004, 0)
GummyMask.Size = UDim2.new(0, 120, 0, 20)
GummyMask.Font = Enum.Font.GothamBold
GummyMask.Text = "Gummy Mask"
GummyMask.TextColor3 = Color3.new(1, 1, 1)
GummyMask.TextSize = 14

Afkstumptp.Name = "Afkstumptp"
Afkstumptp.Parent = WaypointPage
Afkstumptp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Afkstumptp.BorderSizePixel = 0
Afkstumptp.Position = UDim2.new(0.513999999, 0, 0.379999995, 0)
Afkstumptp.Size = UDim2.new(0, 120, 0, 20)
Afkstumptp.Font = Enum.Font.GothamBold
Afkstumptp.Text = "AFK Stumnail"
Afkstumptp.TextColor3 = Color3.new(1, 1, 1)
Afkstumptp.TextSize = 14

Stinger.Name = "Stinger"
Stinger.Parent = WaypointPage
Stinger.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Stinger.BorderSizePixel = 0
Stinger.Position = UDim2.new(0.263000011, 0, 0.379999995, 0)
Stinger.Size = UDim2.new(0, 120, 0, 20)
Stinger.Font = Enum.Font.GothamBold
Stinger.Text = "Stinger"
Stinger.TextColor3 = Color3.new(1, 1, 1)
Stinger.TextSize = 14

Kingamulettp.Name = "Kingamulettp"
Kingamulettp.Parent = WaypointPage
Kingamulettp.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Kingamulettp.BorderSizePixel = 0
Kingamulettp.Position = UDim2.new(0.754622638, 0, 0.300000012, 0)
Kingamulettp.Size = UDim2.new(0, 120, 0, 20)
Kingamulettp.Font = Enum.Font.GothamBold
Kingamulettp.Text = "King Amulet"
Kingamulettp.TextColor3 = Color3.new(1, 1, 1)
Kingamulettp.TextSize = 14

ExtraPage.Name = "ExtraPage"
ExtraPage.Parent = MainPage
ExtraPage.BackgroundColor3 = Color3.new(1, 1, 1)
ExtraPage.BackgroundTransparency = 1
ExtraPage.Position = UDim2.new(0, 0, 0.127000034, 0)
ExtraPage.Size = UDim2.new(0, 530, 0, 174)
ExtraPage.Visible = false
ExtraPage.CanvasSize = UDim2.new(0, 0, 3, 0)
ExtraPage.ScrollBarThickness = 5

Autodig.Name = "Autodig"
Autodig.Parent = ExtraPage
Autodig.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autodig.BorderSizePixel = 0
Autodig.Position = UDim2.new(0.0160000008, 0, 0.0199999996, 0)
Autodig.Size = UDim2.new(0, 120, 0, 20)
Autodig.Font = Enum.Font.GothamBold
Autodig.Text = "Auto Dig"
Autodig.TextColor3 = Color3.new(1, 1, 1)
Autodig.TextSize = 14

Autobuffitem.Name = "Autobuffitem"
Autobuffitem.Parent = ExtraPage
Autobuffitem.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autobuffitem.BorderSizePixel = 0
Autobuffitem.Position = UDim2.new(0.261000007, 0, 0.0199999996, 0)
Autobuffitem.Size = UDim2.new(0, 120, 0, 20)
Autobuffitem.Font = Enum.Font.GothamBold
Autobuffitem.Text = "Auto Item Buff"
Autobuffitem.TextColor3 = Color3.new(1, 1, 1)
Autobuffitem.TextSize = 14

Killcoconutcrab.Name = "Killcoconutcrab"
Killcoconutcrab.Parent = ExtraPage
Killcoconutcrab.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Killcoconutcrab.BorderSizePixel = 0
Killcoconutcrab.Position = UDim2.new(0.510999978, 0, 0.0199999996, 0)
Killcoconutcrab.Size = UDim2.new(0, 120, 0, 20)
Killcoconutcrab.Font = Enum.Font.GothamBold
Killcoconutcrab.Text = "Kill Coconut Crab"
Killcoconutcrab.TextColor3 = Color3.new(1, 1, 1)
Killcoconutcrab.TextScaled = true
Killcoconutcrab.TextSize = 14
Killcoconutcrab.TextWrapped = true

KillTunnel.Name = "KillTunnel"
KillTunnel.Parent = ExtraPage
KillTunnel.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
KillTunnel.BorderSizePixel = 0
KillTunnel.Position = UDim2.new(0.755999982, 0, 0.0199999996, 0)
KillTunnel.Size = UDim2.new(0, 120, 0, 20)
KillTunnel.Font = Enum.Font.GothamBold
KillTunnel.Text = "Kill Tunnel"
KillTunnel.TextColor3 = Color3.new(1, 1, 1)
KillTunnel.TextSize = 14

Usenightbell.Name = "Usenightbell"
Usenightbell.Parent = ExtraPage
Usenightbell.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Usenightbell.BorderSizePixel = 0
Usenightbell.Position = UDim2.new(0.0160000008, 0, 0.0599999987, 0)
Usenightbell.Size = UDim2.new(0, 120, 0, 20)
Usenightbell.Font = Enum.Font.GothamBold
Usenightbell.Text = "Use Night Bell"
Usenightbell.TextColor3 = Color3.new(1, 1, 1)
Usenightbell.TextSize = 14

Usefielddice.Name = "Usefielddice"
Usefielddice.Parent = ExtraPage
Usefielddice.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Usefielddice.BorderSizePixel = 0
Usefielddice.Position = UDim2.new(0.261000007, 0, 0.0599999987, 0)
Usefielddice.Size = UDim2.new(0, 120, 0, 20)
Usefielddice.Font = Enum.Font.GothamBold
Usefielddice.Text = "Use Field Dice"
Usefielddice.TextColor3 = Color3.new(1, 1, 1)
Usefielddice.TextSize = 14

Autokillvicious.Name = "Autokillvicious"
Autokillvicious.Parent = ExtraPage
Autokillvicious.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autokillvicious.BorderSizePixel = 0
Autokillvicious.Position = UDim2.new(0.510999978, 0, 0.0599999987, 0)
Autokillvicious.Size = UDim2.new(0, 120, 0, 20)
Autokillvicious.Font = Enum.Font.GothamBold
Autokillvicious.Text = "Auto Kill Vicious"
Autokillvicious.TextColor3 = Color3.new(1, 1, 1)
Autokillvicious.TextSize = 14

Autokillwindy.Name = "Autokillwindy"
Autokillwindy.Parent = ExtraPage
Autokillwindy.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autokillwindy.BorderSizePixel = 0
Autokillwindy.Position = UDim2.new(0.755999982, 0, 0.0599999987, 0)
Autokillwindy.Size = UDim2.new(0, 120, 0, 20)
Autokillwindy.Font = Enum.Font.GothamBold
Autokillwindy.Text = "Auto Kill Windy "
Autokillwindy.TextColor3 = Color3.new(1, 1, 1)
Autokillwindy.TextSize = 14

Autokillmonster.Name = "Autokillmonster"
Autokillmonster.Parent = ExtraPage
Autokillmonster.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autokillmonster.BorderSizePixel = 0
Autokillmonster.Position = UDim2.new(0.755999982, 0, 0.100000001, 0)
Autokillmonster.Size = UDim2.new(0, 120, 0, 20)
Autokillmonster.Font = Enum.Font.GothamBold
Autokillmonster.Text = "Auto Night Bell"
Autokillmonster.TextColor3 = Color3.new(1, 1, 1)
Autokillmonster.TextSize = 14

RemoteQuest.Name = "RemoteQuest"
RemoteQuest.Parent = ExtraPage
RemoteQuest.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
RemoteQuest.BorderSizePixel = 0
RemoteQuest.Position = UDim2.new(0.510999978, 0, 0.100000001, 0)
RemoteQuest.Size = UDim2.new(0, 120, 0, 20)
RemoteQuest.Font = Enum.Font.GothamBold
RemoteQuest.Text = "Auto Quest"
RemoteQuest.TextColor3 = Color3.new(1, 1, 1)
RemoteQuest.TextSize = 14

Autogumdrop.Name = "Autogumdrop"
Autogumdrop.Parent = ExtraPage
Autogumdrop.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autogumdrop.BorderSizePixel = 0
Autogumdrop.Position = UDim2.new(0.261000007, 0, 0.100000001, 0)
Autogumdrop.Size = UDim2.new(0, 120, 0, 20)
Autogumdrop.Font = Enum.Font.GothamBold
Autogumdrop.Text = "Auto Gumdrop"
Autogumdrop.TextColor3 = Color3.new(1, 1, 1)
Autogumdrop.TextSize = 14

FindWindBee.Name = "FindWindBee"
FindWindBee.Parent = ExtraPage
FindWindBee.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
FindWindBee.BorderSizePixel = 0
FindWindBee.Position = UDim2.new(0.0160000008, 0, 0.100000001, 0)
FindWindBee.Size = UDim2.new(0, 120, 0, 20)
FindWindBee.Font = Enum.Font.GothamBold
FindWindBee.Text = "Find Windy Bee"
FindWindBee.TextColor3 = Color3.new(1, 1, 1)
FindWindBee.TextSize = 14

Useglitter.Name = "Useglitter"
Useglitter.Parent = ExtraPage
Useglitter.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Useglitter.BorderSizePixel = 0
Useglitter.Position = UDim2.new(0.755999982, 0, 0.140375406, 0)
Useglitter.Size = UDim2.new(0, 120, 0, 20)
Useglitter.Font = Enum.Font.GothamBold
Useglitter.Text = "Auto Farm Sparkles"
Useglitter.TextColor3 = Color3.new(1, 1, 1)
Useglitter.TextSize = 14

Autogliter.Name = "Autogliter"
Autogliter.Parent = ExtraPage
Autogliter.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autogliter.BorderSizePixel = 0
Autogliter.Position = UDim2.new(0.510999978, 0, 0.140375406, 0)
Autogliter.Size = UDim2.new(0, 120, 0, 20)
Autogliter.Font = Enum.Font.GothamBold
Autogliter.Text = "Auto Glitter"
Autogliter.TextColor3 = Color3.new(1, 1, 1)
Autogliter.TextSize = 14

Autococonut.Name = "Autococonut"
Autococonut.Parent = ExtraPage
Autococonut.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autococonut.BorderSizePixel = 0
Autococonut.Position = UDim2.new(0.0160000008, 0, 0.140375406, 0)
Autococonut.Size = UDim2.new(0, 120, 0, 20)
Autococonut.Font = Enum.Font.GothamBold
Autococonut.Text = "Auto Coconut"
Autococonut.TextColor3 = Color3.new(1, 1, 1)
Autococonut.TextSize = 14

Autostinger.Name = "Autostinger"
Autostinger.Parent = ExtraPage
Autostinger.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autostinger.BorderSizePixel = 0
Autostinger.Position = UDim2.new(0.261000007, 0, 0.140375406, 0)
Autostinger.Size = UDim2.new(0, 120, 0, 20)
Autostinger.Font = Enum.Font.GothamBold
Autostinger.Text = "Auto Stinger"
Autostinger.TextColor3 = Color3.new(1, 1, 1)
Autostinger.TextSize = 14

Eqipdemonmask.Name = "Eqipdemonmask"
Eqipdemonmask.Parent = ExtraPage
Eqipdemonmask.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Eqipdemonmask.BorderSizePixel = 0
Eqipdemonmask.Position = UDim2.new(0.755999982, 0, 0.180000007, 0)
Eqipdemonmask.Size = UDim2.new(0, 120, 0, 20)
Eqipdemonmask.Font = Enum.Font.GothamBold
Eqipdemonmask.Text = "Equip Diamond Mask"
Eqipdemonmask.TextColor3 = Color3.new(1, 1, 1)
Eqipdemonmask.TextScaled = true
Eqipdemonmask.TextSize = 14
Eqipdemonmask.TextWrapped = true

Equipdemonmask.Name = "Equipdemonmask"
Equipdemonmask.Parent = ExtraPage
Equipdemonmask.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Equipdemonmask.BorderSizePixel = 0
Equipdemonmask.Position = UDim2.new(0.510999978, 0, 0.180000007, 0)
Equipdemonmask.Size = UDim2.new(0, 120, 0, 20)
Equipdemonmask.Font = Enum.Font.GothamBold
Equipdemonmask.Text = "Equip Demon Mask"
Equipdemonmask.TextColor3 = Color3.new(1, 1, 1)
Equipdemonmask.TextScaled = true
Equipdemonmask.TextSize = 14
Equipdemonmask.TextWrapped = true

Equipgummymask.Name = "Equipgummymask"
Equipgummymask.Parent = ExtraPage
Equipgummymask.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Equipgummymask.BorderSizePixel = 0
Equipgummymask.Position = UDim2.new(0.261000007, 0, 0.180000007, 0)
Equipgummymask.Size = UDim2.new(0, 120, 0, 20)
Equipgummymask.Font = Enum.Font.GothamBold
Equipgummymask.Text = "Equip Gummy Mask"
Equipgummymask.TextColor3 = Color3.new(1, 1, 1)
Equipgummymask.TextScaled = true
Equipgummymask.TextSize = 14
Equipgummymask.TextWrapped = true

Automagicbean.Name = "Automagicbean"
Automagicbean.Parent = ExtraPage
Automagicbean.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Automagicbean.BorderSizePixel = 0
Automagicbean.Position = UDim2.new(0.0160000008, 0, 0.180000007, 0)
Automagicbean.Size = UDim2.new(0, 120, 0, 20)
Automagicbean.Font = Enum.Font.GothamBold
Automagicbean.Text = "Auto Magic Bean"
Automagicbean.TextColor3 = Color3.new(1, 1, 1)
Automagicbean.TextSize = 14

Bringtornado.Name = "Bringtornado"
Bringtornado.Parent = ExtraPage
Bringtornado.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Bringtornado.BorderSizePixel = 0
Bringtornado.Position = UDim2.new(0.755999982, 0, 0.219999999, 0)
Bringtornado.Size = UDim2.new(0, 120, 0, 20)
Bringtornado.Font = Enum.Font.GothamBold
Bringtornado.Text = "Bring Tornado"
Bringtornado.TextColor3 = Color3.new(1, 1, 1)
Bringtornado.TextSize = 14

Killstumnail.Name = "Killstumnail"
Killstumnail.Parent = ExtraPage
Killstumnail.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Killstumnail.BorderSizePixel = 0
Killstumnail.Position = UDim2.new(0.510999978, 0, 0.219999999, 0)
Killstumnail.Size = UDim2.new(0, 120, 0, 20)
Killstumnail.Font = Enum.Font.GothamBold
Killstumnail.Text = "Auto Farm Leaves"
Killstumnail.TextColor3 = Color3.new(1, 1, 1)
Killstumnail.TextSize = 14

Dropweapon.Name = "Dropweapon"
Dropweapon.Parent = ExtraPage
Dropweapon.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Dropweapon.BorderSizePixel = 0
Dropweapon.Position = UDim2.new(0.261000007, 0, 0.219999999, 0)
Dropweapon.Size = UDim2.new(0, 120, 0, 20)
Dropweapon.Font = Enum.Font.GothamBold
Dropweapon.Text = "Auto snowflake"
Dropweapon.TextColor3 = Color3.new(1, 1, 1)
Dropweapon.TextSize = 14

Noclip.Name = "Noclip"
Noclip.Parent = ExtraPage
Noclip.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Noclip.BorderSizePixel = 0
Noclip.Position = UDim2.new(0.0160000008, 0, 0.219999999, 0)
Noclip.Size = UDim2.new(0, 120, 0, 20)
Noclip.Font = Enum.Font.GothamBold
Noclip.Text = "Noclip"
Noclip.TextColor3 = Color3.new(1, 1, 1)
Noclip.TextSize = 14

AutoDispenser.Name = "AutoDispenser"
AutoDispenser.Parent = ExtraPage
AutoDispenser.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
AutoDispenser.BorderSizePixel = 0
AutoDispenser.Position = UDim2.new(0.0144905448, 0, 0.261870772, 0)
AutoDispenser.Size = UDim2.new(0, 120, 0, 20)
AutoDispenser.Font = Enum.Font.GothamBold
AutoDispenser.Text = "Auto Dispenser"
AutoDispenser.TextColor3 = Color3.new(1, 1, 1)
AutoDispenser.TextSize = 14

Autotop.Name = "Autotop"
Autotop.Parent = ExtraPage
Autotop.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autotop.BorderSizePixel = 0
Autotop.Position = UDim2.new(0.259773552, 0, 0.261870772, 0)
Autotop.Size = UDim2.new(0, 120, 0, 20)
Autotop.Font = Enum.Font.GothamBold
Autotop.Text = "Auto Dispenser"
Autotop.TextColor3 = Color3.new(1, 1, 1)
Autotop.TextSize = 14

AutoDispenser_2.Name = "AutoDispenser"
AutoDispenser_2.Parent = ExtraPage
AutoDispenser_2.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
AutoDispenser_2.BorderSizePixel = 0
AutoDispenser_2.Position = UDim2.new(0.259773552, 0, 0.261870772, 0)
AutoDispenser_2.Size = UDim2.new(0, 120, 0, 20)
AutoDispenser_2.Font = Enum.Font.GothamBold
AutoDispenser_2.Text = "Auto Top Booster"
AutoDispenser_2.TextColor3 = Color3.new(1, 1, 1)
AutoDispenser_2.TextSize = 14

Autored.Name = "Autored"
Autored.Parent = ExtraPage
Autored.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autored.BorderSizePixel = 0
Autored.Position = UDim2.new(0.510716915, 0, 0.261870772, 0)
Autored.Size = UDim2.new(0, 120, 0, 20)
Autored.Font = Enum.Font.GothamBold
Autored.Text = "Auto Red Booster"
Autored.TextColor3 = Color3.new(1, 1, 1)
Autored.TextScaled = true
Autored.TextSize = 14
Autored.TextWrapped = true

Autoblue.Name = "Autoblue"
Autoblue.Parent = ExtraPage
Autoblue.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Autoblue.BorderSizePixel = 0
Autoblue.Position = UDim2.new(0.755999923, 0, 0.261870772, 0)
Autoblue.Size = UDim2.new(0, 120, 0, 20)
Autoblue.Font = Enum.Font.GothamBold
Autoblue.Text = "Auto Blue Booster"
Autoblue.TextColor3 = Color3.new(1, 1, 1)
Autoblue.TextScaled = true
Autoblue.TextSize = 14
Autoblue.TextWrapped = true

ExtrasButton.Name = "ExtrasButton"
ExtrasButton.Parent = MainPage
ExtrasButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
ExtrasButton.BorderSizePixel = 0
ExtrasButton.Position = UDim2.new(0.538195491, 0, 0.0399999991, 0)
ExtrasButton.Size = UDim2.new(0.159999996, 0, 0.0869999975, 0)
ExtrasButton.Font = Enum.Font.GothamBold
ExtrasButton.Text = "Extras"
ExtrasButton.TextColor3 = Color3.new(1, 1, 1)
ExtrasButton.TextSize = 14

FarmingButton.Name = "FarmingButton"
FarmingButton.Parent = MainPage
FarmingButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
FarmingButton.BorderSizePixel = 0
FarmingButton.Position = UDim2.new(0.198195487, 0, 0.0399999991, 0)
FarmingButton.Size = UDim2.new(0.159999996, 0, 0.0869999975, 0)
FarmingButton.Font = Enum.Font.GothamBold
FarmingButton.Text = "Farming"
FarmingButton.TextColor3 = Color3.new(1, 1, 1)
FarmingButton.TextSize = 14

HomeButton.Name = "HomeButton"
HomeButton.Parent = MainPage
HomeButton.BackgroundColor3 = Color3.new(0.345098, 0.14902, 1)
HomeButton.BorderSizePixel = 0
HomeButton.Position = UDim2.new(0.0281954892, 0, 0.0399999991, 0)
HomeButton.Size = UDim2.new(0.159999996, 0, 0.0869999975, 0)
HomeButton.Font = Enum.Font.GothamBold
HomeButton.Text = "Home"
HomeButton.TextColor3 = Color3.new(1, 1, 1)
HomeButton.TextSize = 14

SettingButton.Name = "SettingButton"
SettingButton.Parent = MainPage
SettingButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
SettingButton.BorderSizePixel = 0
SettingButton.Position = UDim2.new(0.708195508, 0, 0.0399999991, 0)
SettingButton.Size = UDim2.new(0.159999996, 0, 0.0869999975, 0)
SettingButton.Font = Enum.Font.GothamBold
SettingButton.Text = "Settings"
SettingButton.TextColor3 = Color3.new(1, 1, 1)
SettingButton.TextSize = 14

WaypointsButton.Name = "WaypointsButton"
WaypointsButton.Parent = MainPage
WaypointsButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
WaypointsButton.BorderSizePixel = 0
WaypointsButton.Position = UDim2.new(0.368195474, 0, 0.0399999991, 0)
WaypointsButton.Size = UDim2.new(0.159999996, 0, 0.0869999975, 0)
WaypointsButton.Font = Enum.Font.GothamBold
WaypointsButton.Text = "Waypoints"
WaypointsButton.TextColor3 = Color3.new(1, 1, 1)
WaypointsButton.TextSize = 14

SettingPage.Name = "SettingPage"
SettingPage.Parent = MainPage
SettingPage.BackgroundColor3 = Color3.new(1, 1, 1)
SettingPage.BackgroundTransparency = 1
SettingPage.Position = UDim2.new(-0, 0, 0.127000004, 0)
SettingPage.Size = UDim2.new(1, 0, 0.787999988, 0)
SettingPage.Visible = false

Antiafk.Name = "Antiafk"
Antiafk.Parent = SettingPage
Antiafk.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Antiafk.BorderSizePixel = 0
Antiafk.Position = UDim2.new(0.0264150947, 0, 0.0853963569, 0)
Antiafk.Size = UDim2.new(0, 98, 0, 20)
Antiafk.Font = Enum.Font.GothamBold
Antiafk.Text = "Anti AFK"
Antiafk.TextColor3 = Color3.new(1, 1, 1)
Antiafk.TextSize = 14

Antiafkbutton.Name = "Antiafkbutton"
Antiafkbutton.Parent = Antiafk
Antiafkbutton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
Antiafkbutton.BorderSizePixel = 0
Antiafkbutton.Position = UDim2.new(1.08163261, 0, 0, 0)
Antiafkbutton.Size = UDim2.new(0, 20, 0, 20)
Antiafkbutton.Font = Enum.Font.GothamBold
Antiafkbutton.Text = "X"
Antiafkbutton.TextColor3 = Color3.new(1, 1, 1)
Antiafkbutton.TextScaled = true
Antiafkbutton.TextSize = 14
Antiafkbutton.TextWrapped = true

Close.Name = "Close"
Close.Parent = MiniPage
Close.BackgroundColor3 = Color3.new(1, 1, 1)
Close.BackgroundTransparency = 1
Close.Position = UDim2.new(0.00760612637, 0, 0.0016666688, 0)
Close.Size = UDim2.new(0, 25, 0, 25)
Close.Font = Enum.Font.GothamBold
Close.Text = "-"
Close.TextColor3 = Color3.new(1, 1, 1)
Close.TextSize = 20

DarkCyberLoadingGUI.Name = "[DarkCyber]LoadingGUI"
DarkCyberLoadingGUI.Parent = game.CoreGui

LoadingFrame.Name = "Loading Frame"
LoadingFrame.Parent = DarkCyberLoadingGUI
LoadingFrame.BackgroundColor3 = Color3.new(0.321569, 0.462745, 1)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.Position = UDim2.new(0.410933673, 0, 0.416230351, 0)
LoadingFrame.Size = UDim2.new(0, 342, 0, 127)

Createtitle.Name = "Createtitle"
Createtitle.Parent = LoadingFrame
Createtitle.BackgroundColor3 = Color3.new(1, 1, 1)
Createtitle.BackgroundTransparency = 1
Createtitle.Size = UDim2.new(0, 108, 0, 25)
Createtitle.Font = Enum.Font.GothamBlack
Createtitle.Text = "Dark Cyber"
Createtitle.TextColor3 = Color3.new(1, 1, 1)
Createtitle.TextSize = 14

NameTitle.Name = "NameTitle"
NameTitle.Parent = Createtitle
NameTitle.BackgroundColor3 = Color3.new(1, 1, 1)
NameTitle.BackgroundTransparency = 1
NameTitle.Position = UDim2.new(1, 0, 0, 0)
NameTitle.Size = UDim2.new(0, 233, 0, 25)
NameTitle.Font = Enum.Font.GothamBold
NameTitle.Text = "Bee Swarm Simulator"
NameTitle.TextColor3 = Color3.new(1, 1, 1)
NameTitle.TextSize = 14

Loadingimage.Name = "Loadingimage"
Loadingimage.Parent = LoadingFrame
Loadingimage.BackgroundColor3 = Color3.new(1, 1, 1)
Loadingimage.BackgroundTransparency = 1
Loadingimage.BorderSizePixel = 0
Loadingimage.Position = UDim2.new(0.112938613, 0, 0.29838711, 0)
Loadingimage.Size = UDim2.new(0, 50, 0, 50)
Loadingimage.Image = "http://www.roblox.com/asset/?id=3953349579"

Loadingtext.Name = "Loadingtext"
Loadingtext.Parent = LoadingFrame
Loadingtext.BackgroundColor3 = Color3.new(1, 1, 1)
Loadingtext.BackgroundTransparency = 1
Loadingtext.Position = UDim2.new(0.3004677, 0, 0.307086617, 0)
Loadingtext.Size = UDim2.new(0, 200, 0, 50)
Loadingtext.Font = Enum.Font.GothamBold
Loadingtext.Text = "Loading Place"
Loadingtext.TextColor3 = Color3.new(0, 0, 0)
Loadingtext.TextSize = 17
Loadingtext.TextXAlignment = Enum.TextXAlignment.Left

DarkCyberSynapshitGUI.Name = "[DarkCyber]SynapshitGUI"
DarkCyberSynapshitGUI.Parent = game.CoreGui

SynapShitPage.Name = "SynapShitPage"
SynapShitPage.Parent = DarkCyberSynapshitGUI
SynapShitPage.BackgroundColor3 = Color3.new(0.321569, 0.462745, 1)
SynapShitPage.BorderSizePixel = 0
SynapShitPage.Position = UDim2.new(0.416354954, 0, 0.417690426, 0)
SynapShitPage.Size = UDim2.new(0, 267, 0, 134)
SynapShitPage.Visible = false

local Createtitle2 = Instance.new("TextLabel")

Createtitle2.Name = "Createtitle"
Createtitle2.Parent = SynapShitPage
Createtitle2.BackgroundColor3 = Color3.new(1, 1, 1)
Createtitle2.BackgroundTransparency = 1
Createtitle2.Size = UDim2.new(0, 108, 0, 25)
Createtitle2.Font = Enum.Font.GothamBlack
Createtitle2.Text = "Dark Cyber"
Createtitle2.TextColor3 = Color3.new(1, 1, 1)
Createtitle2.TextSize = 14

NameTitle2 = Instance.new("TextLabel")

NameTitle2.Name = "NameTitle"
NameTitle2.Parent = Createtitle2
NameTitle2.BackgroundColor3 = Color3.new(1, 1, 1)
NameTitle2.BackgroundTransparency = 1
NameTitle2.Position = UDim2.new(0.997087002, 0, 0, 0)
NameTitle2.Size = UDim2.new(0, 159, 0, 25)
NameTitle2.Font = Enum.Font.GothamBold
NameTitle2.Text = "Bee Swarm Simulator"
NameTitle2.TextColor3 = Color3.new(1, 1, 1)
NameTitle2.TextSize = 14

Welcome.Name = "Welcome"
Welcome.Parent = SynapShitPage
Welcome.BackgroundColor3 = Color3.new(1, 1, 1)
Welcome.BackgroundTransparency = 1
Welcome.Position = UDim2.new(0, 0, 0.313432842, 0)
Welcome.Size = UDim2.new(0, 266, 0, 50)
Welcome.Font = Enum.Font.GothamBold
Welcome.Text = "WELCOME TO MY GUI SYNAPSHIT USER"
Welcome.TextColor3 = Color3.new(1, 1, 1)
Welcome.TextSize = 25
Welcome.TextWrapped = true

-- Scripts:
local red = Color3.fromRGB(255, 80, 80)
local blue = Color3.new(0.34902, 0.32549, 1)

Ingnore.MouseButton1Down:Connect(function()
if nothoney then 
Ingnore.BackgroundColor3 = blue
nothoney = false
else
Ingnore.BackgroundColor3 = red
nothoney = true
end



end)

FarmBublle.MouseButton1Down:Connect(function()
      if farmbubble then 
      FarmBublle.BackgroundColor3 = blue
      farmbubble = false
      else
      FarmBublle.BackgroundColor3 = red
      farmbubble = true
      end
      
      
      
      end)

OnlyHoney.MouseButton1Down:Connect(function()
      if onlyhoney then 
      OnlyHoney.BackgroundColor3 = blue
      onlyhoney = false
      else
      OnlyHoney.BackgroundColor3 = red
      onlyhoney = true
      end
      
      
      
      end)
Mobbtn.MouseButton1Down:Connect(function()
       if automob then 
            Mobbtn.BackgroundColor3 = blue
      automob = false
      else
            Mobbtn.BackgroundColor3 = red
      automob = true
      end
            
            
            
      end)
      AutoPolar.MouseButton1Down:Connect(function()
            if autopolar then 
                 AutoPolar.BackgroundColor3 = blue
           autopolar = false
           else
                 AutoPolar.BackgroundColor3 = red
           autopolar = true
           end
                 
                 
                 
           end)
TweenBtn.MouseButton1Down:Connect(function() 
      TypeFarming = "Tween"
      TypeF.Text = "Type farming: Tween"
end)

TpBtn.MouseButton1Down:Connect(function()
      TypeFarming = "Tp"
      TypeF.Text = "Type farming: Tp"

end)

WalkBtn.MouseButton1Down:Connect(function()
      TypeFarming = "Walking"
      TypeF.Text = "Type farming: Walking"

end)
WalkBtn2.MouseButton1Down:Connect(function()
      TypeFarming = "Walking2"
      TypeF.Text = "Type farming: Walking2"

end)

MiniPage.Selectable = true
MiniPage.Draggable = true 
MiniPage.Active = true

local repss = 0
local xoay = 0 

spawn(function()
for i=1,50 do wait(.005)
      xoay = xoay - 10
      Loadingimage.Rotation = xoay
end
end)

for c=1,5 do wait(.01)
      Loadingtext.Text = "Loading Place"..string.rep('.',repss%3+1)
      repss = repss + 1
end

Loadingtext.Text = "Loading Place: Success"
wait(0.2)

local repss = 0

for d=1,5 do wait(.01)
      Loadingtext.Text = "Loading UI"..string.rep('.',repss%3+1)
      repss = repss + 1
end

if game.PlaceId == 1537690962 or game.PlaceId == 4079902982 then
Loadingtext.Text = "Loading UI: Success"
if syn then 
LoadingFrame:TweenPosition(UDim2.new(0.410933673, 0, -0.7, 0)) 
wait(0.2)
DarkCyberLoadingGUI:Destroy()
SynapShitPage.Visible = true
wait(.2)
SynapShitPage:TweenPosition(UDim2.new(0.416354954, 0, -0.717690426, 0))
wait(.2)
DarkCyberSynapshitGUI:Destroy()
wait(.2)
MiniPage:TweenPosition(UDim2.new(0.361979187, 0, 0.34183538, 0))  --0.361979187, 0, 0.34183538, 0
else
LoadingFrame:TweenPosition(UDim2.new(0.410933673, 0, -0.7, 0)) 
wait(.2)
DarkCyberLoadingGUI:Destroy()
MiniPage:TweenPosition(UDim2.new(0.361979187, 0, 0.34183538, 0))  --0.361979187, 0, 0.34183538, 0 
end
end

Copylinkdiscord.MouseButton1Down:Connect(function()
setclipboard("discord.gg/GT6uXF2")
end)

HomeButton.MouseButton1Down:Connect(function()
HomeButton.BackgroundColor3 = Color3.new(0.345098, 0.14902, 1)
FarmingButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
WaypointsButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
ExtrasButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
SettingButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
HomePage.Visible = true
FarmingPage.Visible = false
WaypointPage.Visible = false
ExtraPage.Visible = false
SettingPage.Visible = false
end)

FarmingButton.MouseButton1Down:Connect(function()
HomeButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
FarmingButton.BackgroundColor3 = Color3.new(0.345098, 0.14902, 1)
WaypointsButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
ExtrasButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
SettingButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
HomePage.Visible = false
FarmingPage.Visible = true
WaypointPage.Visible = false
ExtraPage.Visible = false
SettingPage.Visible = false
end)

WaypointsButton.MouseButton1Down:Connect(function()
HomeButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
FarmingButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
WaypointsButton.BackgroundColor3 = Color3.new(0.345098, 0.14902, 1)
ExtrasButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
SettingButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)  
HomePage.Visible = false
FarmingPage.Visible = false
WaypointPage.Visible = true
ExtraPage.Visible = false
SettingPage.Visible = false
end)


local UserInputService = game:GetService("UserInputService")
 
local function onInputEnded(inputObject, gameProcessedEvent)
    -- First check if the 'gameProcessedEvent' is true
    -- This indicates that another script had already processed the input, so this one can be ignored
    if gameProcessedEvent then return end
    -- Next, check that the input was a keyboard event
    if inputObject.UserInputType == Enum.UserInputType.Keyboard then
        if inputObject.KeyCode == Enum.KeyCode.Home then --Nút home đóng m? ui
            if MiniPage.Visible == true then
            MiniPage.Visible =  false
        elseif MiniPage.Visible == false then
            MiniPage.Visible = true
        end
    end
end
end
UserInputService.InputEnded:Connect(onInputEnded)


ExtrasButton.MouseButton1Down:Connect(function()
HomeButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
FarmingButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
WaypointsButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
ExtrasButton.BackgroundColor3 = Color3.new(0.345098, 0.14902, 1)
SettingButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
HomePage.Visible = false
FarmingPage.Visible = false
WaypointPage.Visible = false
ExtraPage.Visible = true
SettingPage.Visible = false
end)

SettingButton.MouseButton1Down:Connect(function()
HomeButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
FarmingButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
WaypointsButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
ExtrasButton.BackgroundColor3 = Color3.new(0.34902, 0.32549, 1)
SettingButton.BackgroundColor3 = Color3.new(0.345098, 0.14902, 1)
HomePage.Visible = false
FarmingPage.Visible = false
WaypointPage.Visible = false
ExtraPage.Visible = false
SettingPage.Visible = true
end)

Destroy.MouseButton1Down:Connect(function()
MiniPage:TweenPosition(UDim2.new(0.361979187, 0, -0.7, 0))
wait(1)
DarkCyberMainGUI:Destroy()
end)

Destroy.MouseEnter:Connect(function()
Destroy.TextColor3 = Color3.new(255,0,0)
end)

Destroy.MouseLeave:Connect(function()
Destroy.TextColor3 = Color3.new(255,255,255)
end)

Close.MouseButton1Down:Connect(function()
if Close.Text == "-" then
      MainPage.Visible = false 
      Close.Text ="+"
else
      MainPage.Visible = true
      Close.Text = "-"
end
end)

local Waypoints = {

["Tunnel Bear"] = CFrame.new(507.3, 5.7, -45.7),
["Redfield Boost"] = CFrame.new(-332, 20, 244),
["Bluefield Boost"] = CFrame.new(319, 58, 103),
["MountainTop Boost"] = CFrame.new(-40, 176, -191.7),
["Bee Shop"] = CFrame.new(-136.8, 4.6, 243.4),
["Tool Shop"] = CFrame.new(86, 4.6, 294),
["Tool Shop 2"] = CFrame.new(165, 69, -161),
["MountainTop Shop"] = CFrame.new(-18, 176, -137),
["Red Clubhouse"] = CFrame.new(-334, 21, 216),
["Blue Clubhouse"] = CFrame.new(292, 4, 98),
["Ticket Shop"] = CFrame.new(-12.8, 184, -222.2),
["Club Honey"] = CFrame.new(44.8, 5, 319.6),
["RoyalJelly Shop"] = CFrame.new(-297, 53, 68),
["Ticket RoyalJelly Shop"] = CFrame.new(81, 18, 240),
["Honeystorm Dispensor"] = CFrame.new(238.4, 33.3, 165.6),
["Blueberry Dispenser"] = CFrame.new(313.3, 58, 86.9),
["Strawberry Dispenser"] = CFrame.new(-320.5, 46, 272.5),
["Sprout Dispenser"] = CFrame.new(-269.26, 26.56, 267.31),
["Instant Honey Convertor"] = CFrame.new(282, 68, -62),
["King Beetles Lair"] = CFrame.new(218, 3, 140),
["Clover Field"] = CFrame.new(174, 34, 189),
["Mushroom Field"] = CFrame.new(-258.1, 5, 299.7),
["Spider Field"] = CFrame.new(-57.2, 20, -5.3),
["Blue Field"] = CFrame.new(113.7, 4, 101.5),
["Sunflower Field"] = CFrame.new(-208, 4, 185),
["StrawBerry Field"] = CFrame.new(-169.3, 20, -3.2),
["Red Field"] = CFrame.new(-258.1, 5, 299.7),
["Dandelion Field"] = CFrame.new(-30, 4, 225),
["BamBoo Field"] = CFrame.new(93, 20, -25),
["Rose Field"] = CFrame.new(-322, 20, 124),
["Mushroom Field"] = CFrame.new(-94, 5, 116),
["Cactus Field"] = CFrame.new(-194, 68, -107),
["Pumpkin Field"] = CFrame.new(-194, 68, -182),
["MountainTop Field"] = CFrame.new(76, 176, -181),
["PineTree Field"] = CFrame.new(-318, 68, -150),
["Pineapple Field"] = CFrame.new(262, 68, -201),
["Onett"] = CFrame.new(-8.4, 234, -517.9),
["Gumdrop Dispenser"] = CFrame.new(63, 20.7, 38.7),
["Treat Dispenser"] = CFrame.new(193.9, 68, -123),
["Treat Shop"] = CFrame.new(-228.2, 5, 89.4),
["Star Hut"] = CFrame.new(135.9, 64.6, 322.1),
["Wealth Clock"] = CFrame.new(310.5, 47.6, 190),
["Coconut Field"] = CFrame.new(-255,72,459),
["Pepper Patch"] = CFrame.new(-486,124,517),
["CCN"] = CFrame.new(-176,71,534),
["Nuoc"] = CFrame.new(-426,70,38),
["Moon"] = CFrame.new(21,88,-54),
["Kill Snail"] = CFrame.new(420,117,-178),
["CC"] = CFrame.new(270,25260,-718),
["CC1"] = CFrame.new(-147,5,195),
["CC2"] = CFrame.new(-431,70,-53),
["CC3"] = CFrame.new(-23,318,-270),
["CC4"] = CFrame.new(-405,110,545),
["CC5"] = CFrame.new(136,66,322),
["CC6"] = CFrame.new(-270,28,267),
["CC7"] = CFrame.new(312,49,189),
["CC8"] = CFrame.new(218,5,140),
["Ant"] = CFrame.new(112,32,477),
["CC9"] = CFrame.new(592,7,-46),
["CC12"] = CFrame.new(-500,52,458),
["CC13"] = CFrame.new(291,28,271),
["CC14"] = CFrame.new(272,25268,-773),
["CC15"] = CFrame.new(-336,133,-387),
["CC16"] = CFrame.new(218,5,140),
["CC17"] = CFrame.new(218,5,140),
["CC19"] = CFrame.new(-486,142,410),
["CC18"] = CFrame.new(218,5,140)
}

local nightbell = false
Autokillmonster.MouseButton1Down:connect(function()
if nightbell == false then
      Autokillmonster.BackgroundColor3 = red 
      MainPage.Visible = false 
      Close.Text ="+"
      nightbell = true
      while nightbell do
            wait(5)
             local A = {

            ["Name"] = "Night Bell"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      end
else 
      nightbell = false 
       Autokillmonster.BackgroundColor3 = blue
end
      
end)
WindyBeetp.MouseButton1Down:connect(function()
      local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC19"]
      MainPage.Visible = false 
      Close.Text ="+"
end)
Diamondmasktp.MouseButton1Down:connect(function()
      local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC15"]
       
      
end)
Demonmasktp.MouseButton1Down:connect(function()
      local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC13"]
       
      
end)
Stinger.MouseButton1Down:connect(function()
      local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Ant"]
       
      
end)

TunelBeartp.MouseButton1Down:connect(function()
      local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Tunnel Bear"]
       
      
end)
GummyMask.MouseButton1Down:connect(function()
      local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC14"]
       
      
end)
Coconutshoptp.MouseButton1Down:connect(function()
      local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CCN"]
       
      
end)
Petaltp.MouseButton1Down:connect(function()
      local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC12"]
       
      
end)
Stumptp.MouseButton1Down:connect(function()
      local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Kill Snail"]
       
      
end)
Suntp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Sunflower Field"]
       
      
end)
Dantp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Dandelion Field"]
       
      
end)
Clovertp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Clover Field"]
       
      
end)
Bambootp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["BamBoo Field"]
       
      
end)
Blueftp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Blue Field"]
       
      
end)
Mushtp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Mushroom Field"]
       
      
end)
Spidertp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Spider Field"]
       
      
end)
Strawtp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["StrawBerry Field"]
       
      
end)
Pineappletp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Pineapple Field"]
       
      
end)
Rosetp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Rose Field"]
       
      
end)
Castustp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Cactus Field"]
       
      
end)
Pumtp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Pumpkin Field"]
       
      
end)
Pintreetp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["PineTree Field"]
       
      
end)
Toptp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["MountainTop Field"]
       
      
end)
Coconuttp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Coconut Field"]
       
      
end)
Peppertp.MouseButton1Down:connect(function()
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Pepper Patch"]
       
      
end)


Autored.MouseButton1Down:connect(function()
       
      
      local a = "Red Field Booster"
local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
Event:FireServer(a)
      while wait(10) do
local a = "Red Field Booster"
local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
Event:FireServer(a)
end
end)
Autoblue.MouseButton1Down:connect(function()
       
      
      local a = "Blue Field Booster"
local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
Event:FireServer(a)
      while wait(10) do
local a = "Blue Field Booster"
local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
Event:FireServer(a)
      end
end)

AutoDispenser_2.MouseButton1Down:connect(function()
       
      
      
local a = "Field Booster"
local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
Event:FireServer(a)
      while wait(10) do 
local a = "Field Booster"
local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
Event:FireServer(a)
      end
      
end)

local afksnail = false
Afkstumptp.MouseButton1Down:connect(function(l)
if afksnail == false then 
      afksnail = true 
      Afkstumptp.BackgroundColor3 = red 
       
      
      noclip = true
      while afksnail do
            
            
            local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
            uTorso.CFrame = CFrame.new(405,72.7,-176)
            wait()
      end
else 
      afksnail = false
      noclip = false
      --wait()
      local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Kill Snail"]
      Afkstumptp.BackgroundColor3 = blue 
end
end)

      
      

Shopbasictp.MouseButton1Down:connect(function()
      
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Tool Shop"]
       
      
end)
Shopproctp.MouseButton1Down:connect(function()
      
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Tool Shop 2"]
       
      
end)
Shoptoptp.MouseButton1Down:connect(function()
      
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["MountainTop Shop"]
       
      
end)
Shopsprinklertp.MouseButton1Down:connect(function()
      
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Nuoc"]
       
      
end)
Shopmoontp.MouseButton1Down:connect(function()
      
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Moon"]
       
      
end)


InstantConversiontp.MouseButton1Down:connect(function()
      
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC1"]
       
      
end)
MegaMemorytp.MouseButton1Down:connect(function()
      
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC2"]
       
      
end)
NightMemorytp.MouseButton1Down:connect(function()
      
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC3"]
       
      
end)
ExtremeMemorytp.MouseButton1Down:connect(function()
      
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC4"]
       
      
end)
StartHalltp.MouseButton1Down:connect(function()
      
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC5"]
       
      
end)
SummonSprouttp.MouseButton1Down:connect(function()
      
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC6"]
       
      
end)
Anttp.MouseButton1Down:connect(function()
      
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Ant"]
       
      
end)
Kingamulettp.MouseButton1Down:connect(function()
      
local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["CC8"]
       
      
end)

--auto


local dispenser = false
AutoDispenser.MouseButton1Down:connect(function()
if dispenser == false then 
      dispenser = true 
      AutoDispenser.BackgroundColor3 = red 
       
      
      while dispenser do
            wait(5)
      
      local A_1 = "Glue Dispenser"
                  local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
                  Event:FireServer(A_1)
                  local A_1 = "Wealth Clock"
                  local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
                  Event:FireServer(A_1)
                  local A_1 = "Coconut Dispenser"
                  local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
                  Event:FireServer(A_1)
                  local A_1 = "Strawberry Dispenser"
                  local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
                  Event:FireServer(A_1)
                  local A_1 = "Treat Dispenser"
                  local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
                  Event:FireServer(A_1)
                  local A_1 = "Free Ant Pass Dispenser"
                  local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
                  Event:FireServer(A_1)
                  local A_1 = "Blueberry Dispenser"
                  local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
                  Event:FireServer(A_1)
                  local A_1 = "Honey Dispenser"
                  local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
                  Event:FireServer(A_1)
                  local A_1 = "Free Royal Jelly Dispenser"
                  local Event = game:GetService("ReplicatedStorage").Events.ToyEvent
                  Event:FireServer(A_1)
                  end
else 
      dispenser = false 
      AutoDispenser.BackgroundColor3 = blue 
end
end)





local t = coroutine.wrap(function()
local snowflakes = TokenId["Snowflake"]
while wait() do 
      if snowflake then
      for k,v in pairs(game.Workspace.Collectibles:GetChildren()) do 
            if v:FindFirstChild("FrontDecal") then 
            if v.FrontDecal.Texture == snowflakes then
            if snowflake==true then
           -- game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position.X,v.Position.Y,v.Position.Z)
            --wait(1)
            tpT(CFrame.new(v.Position.X,v.Position.Y,v.Position.Z),0.2)
            wait(.3)
            end
            end
            
            end
            
            end

      end


end


end)
t()
Dropweapon.MouseButton1Down:connect(function()
      if snowflake then
      Dropweapon.BackgroundColor3 = blue
      snowflake = false
      else
      snowflake = true 
      Dropweapon.BackgroundColor3 = red
      


      end

end)




local killtunell = false
KillTunnel.MouseButton1Down:connect(function(j)
      if killtunell == false then
       
       
      local uTorso = workspace:WaitForChild(game.Players.LocalPlayer.Name).HumanoidRootPart
      uTorso.CFrame = Waypoints["Tunnel Bear"]
      killtunell = true 
      KillTunnel.BackgroundColor3 = red 
      noclip = true
      for _,v in pairs(game.workspace.Decorations.TrapTunnel:GetChildren()) do 
      if string.find(v.Name,"") then 
            v:Destroy()

      end
      end
      wait(6)
      while killtunell do
            wait()
      for _,v in pairs(game.Workspace.Monsters:GetChildren()) do
      if string.find(v.Name,"Tunnel") then
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,20.5,0)

      end
      end
      end
      else 
      noclip = false    
      killtunell = false 
      KillTunnel.BackgroundColor3 = blue 
end
end)





noclip = false
game:GetService('RunService').Stepped:connect(function()
if noclip then
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
end
end)






local killcoconut = false
Killcoconutcrab.MouseButton1Down:connect(function()
      if killcoconut == false then 
             
      
      Killcoconutcrab.BackgroundColor3 = red
      killcoconut = true 
      noclip = true
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-256.375092, 112.547897, 500.457794, 0.998952866, -0.0450557806, 0.00794458669, -8.64538929e-09, 0.173648775, 0.98480767, -0.0457508452, -0.98377645, 0.173466951)
else 
      killcoconut = false 
      noclip = false
      Killcoconutcrab.BackgroundColor3 = blue
end
end)


local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
  vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
  wait(1)
  vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
print ("Afk 15m")
end)




local stinger = false
Autostinger.MouseButton1Down:connect(function(b)
if stinger == false then
       
      
      stinger = true 
      Autostinger.BackgroundColor3 = red
      local A = {

            ["Name"] = "Stinger"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      while stinger do
            wait(30)
      
            local A = {

            ["Name"] = "Stinger"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      end 
else 
      stinger = false 
      Autostinger.BackgroundColor3 = blue
end

end)



local item = false
Autobuffitem.MouseButton1Down:connect(function(c)
if item == false then 
       
      
      item = true 
      Autobuffitem.BackgroundColor3 = red
      local A = {

            ["Name"] = "Blue Extract"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {

            ["Name"] = "Red Extract"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {

            ["Name"] = "Oil"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {

            ["Name"] = "Enzymes"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {

            ["Name"] = "Glue"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {

            ["Name"] = "Glitter"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {

            ["Name"] = "Tropical Drink"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      while item do
            wait(600)
      
            local A = {

            ["Name"] = "Blue Extract"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {

            ["Name"] = "Red Extract"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {

            ["Name"] = "Oil"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {

            ["Name"] = "Enzymes"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {

            ["Name"] = "Glue"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {

            ["Name"] = "Glitter"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      local A = {

            ["Name"] = "Tropical Drink"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      
      end
      
else 
      item = false 
      Autobuffitem.BackgroundColor3 = blue
end
end)



local gliter = false
Autogliter.MouseButton1Down:connect(function(d)
if gliter == false then
       
       
      gliter = true 
      Autogliter.BackgroundColor3 = red
      local A = {

            ["Name"] = "Glitter"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      while gliter do
            wait(920)
      
            local A = {

            ["Name"] = "Glitter"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      
      
            end
else 
      gliter = false 
      Autogliter.BackgroundColor3 = blue
end
end)



local coconut = false
Autococonut.MouseButton1Down:connect(function(e)
if coconut == false then 
       
      
      coconut = true 
      Autococonut.BackgroundColor3 = red
      local A = {

            ["Name"] = "Coconut"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      while coconut do
            wait(11)
      
            local A = {

            ["Name"] = "Coconut"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      
      end
else 
      coconut = false
      Autococonut.BackgroundColor3 = blue
end
end)

      



      
local AutoDig = false
Autodig.MouseButton1Down:connect(function()
      if AutoDig == false then
             
       
      AutoDig = true 
      Autodig.BackgroundColor3 = red
      while AutoDig do
            wait(0.5)
            
 for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do 
      if v:IsA("Tool") then 
            v.ClickEvent:FireServer()
      
      end
            end
            end
else 
      AutoDig = false
      Autodig.BackgroundColor3 = blue
end
end)



local Sparkles = false
Useglitter.MouseButton1Down:connect(function()

if Sparkles == false then
        
       
      Sparkles = true 
      Useglitter.BackgroundColor3 = red
local test = "C"
local tweenservice = game:GetService("TweenService")
local plr = game.Players.LocalPlayer
local info = TweenInfo.new(0.1) -- change to how long it takes to get to the item (in seconds)
local item = {}
while Sparkles do
wait(0.5)
for _,v in pairs(game.workspace.Flowers:GetDescendants()) do
if string.find(v.Name,"Sparkles") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Parent.CFrame
end
end
for k,v in pairs(workspace.Collectibles:GetChildren()) do
 if tostring(v) == tostring(game.Players.LocalPlayer.Name) or tostring(v) == test then
						if (v.Position-plr.Character.HumanoidRootPart.Position).magnitude <= 60 then
item.CFrame = CFrame.new(v.Position.x,plr.Character.HumanoidRootPart.Position.y,v.Position.z)
local Tween = tweenservice:Create(plr.Character.HumanoidRootPart, info, item)
Tween:Play()
end
end
end
end

else 
      Sparkles = false
      Useglitter.BackgroundColor3 = blue
end
end)







local gumdrop = false
Autogumdrop.MouseButton1Down:connect(function(h)
      if gumdrop == false then 
             
      
      gumdrop = true 
      Autogumdrop.BackgroundColor3 = red
      while gumdrop do
            wait(2)
            
            local A = {

            ["Name"] = "Gumdrops"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
      
            end
else 
      gumdrop = false
      Autogumdrop.BackgroundColor3 = blue
end
end)

Equipgummymask.MouseButton1Down:connect(function()
       
      
      local A_1 = "Equip"
local A_2 = 
{
      ["Mute"] = true, 
      ["Type"] = "Gummy Mask", 
      ["Category"] = "Accessory"
}
local Event = game:GetService("ReplicatedStorage").Events.ItemPackageEvent
Event:InvokeServer(A_1, A_2)
end)

local tpwindy = false
Autokillwindy.MouseButton1Down:connect(function(o)
      
      if tpwindy == false then 
      tpwindy = true 
       
      
      Autokillwindy.BackgroundColor3 =red
      noclip = true
	local player = game.Players.LocalPlayer
	local sanghuman = player.Character.HumanoidRootPart

      while tpwindy do
            wait()
            
     for _,v in pairs(game.workspace.Monsters:GetChildren()) do 
      if string.find(v.Name,"Windy") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Torso.CFrame * CFrame.new(0,25,0)
end
end
 for k,r in pairs(workspace.Collectibles:GetChildren()) do
            if tostring(r) == tostring(game.Players.LocalPlayer.Name) or tostring(r) == "C" then
						if (r.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 25 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = r.CFrame
                local intvalue = Instance.new("IntValue",r)
                intvalue.Name = "Void"
end
end
end
      end
else 
      tpwindy = false
      noclip = false
      Autokillwindy.BackgroundColor3 =blue
end
end)

      
      
      




local tornado = false
Bringtornado.MouseButton1Down:connect(function()
if tornado == false then 
       
      
      tornado = true 
      Bringtornado.BackgroundColor3 = red
while tornado do
wait(0.3)
local test = "Root"
local test2 = "Plane"
local tweenservice = game:GetService("TweenService")
local plr = game.Players.LocalPlayer
local info = TweenInfo.new(0.3) -- change to how long it takes to get to the item (in seconds)
local item = {}

for i,v in pairs(game.workspace.Particles:GetDescendants()) do
if v.Name == test or v.Name == test2 then
for _,i in pairs(game.workspace.Collectibles:GetChildren()) do
if tostring(i) == tostring(game.Players.LocalPlayer.Name) or tostring(i) == "C" then
if (i.Position-plr.Character.HumanoidRootPart.Position).magnitude <= 60 then

item.CFrame = CFrame.new(i.Position.x,plr.Character.HumanoidRootPart.Position.y,i.Position.z)

local Tween = tweenservice:Create(v, info, item)
Tween:Play()
end
end
end
end
end
end
else
      tornado = false 
      Bringtornado.BackgroundColor3 = blue
end
end)



Equipdemonmask.MouseButton1Down:connect(function()
       
      
      local A_1 = "Equip"
local A_2 = 
{
      ["Mute"] = true, 
      ["Type"] = "Demon Mask", 
      ["Category"] = "Accessory"
}
local Event = game:GetService("ReplicatedStorage").Events.ItemPackageEvent
Event:InvokeServer(A_1, A_2)
end)
Eqipdemonmask.MouseButton1Down:connect(function()
       
      
      local A_1 = "Equip"
local A_2 = 
{
      ["Mute"] = true, 
      ["Type"] = "Diamond Mask", 
      ["Category"] = "Accessory"
}
local Event = game:GetService("ReplicatedStorage").Events.ItemPackageEvent
Event:InvokeServer(A_1, A_2)
end)



local Drop = false
Automagicbean.MouseButton1Down:connect(function(a)
if Drop == false then 
       
      
      Drop = true 
      Automagicbean.BackgroundColor3 =red
      while Drop do
            wait(0.3)
      
            local A = {

            ["Name"] = "Magic Bean"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
            end
else 
      Drop = false
      Automagicbean.BackgroundColor3 =blue
end
end)

      
            





Noclip.MouseButton1Down:Connect(function()
if noclip == false then 
      noclip = true
       
       
      Noclip.BackgroundColor3 = red
else 
      noclip = false
      Noclip.BackgroundColor3 = blue
end
end)





local Windy = false
FindWindBee.MouseButton1Down:connect(function(w)
      if Windy == false then
             
       
      Windy = true 
      FindWindBee.BackgroundColor3 =red
      noclip = true
while Windy do
wait()
for _,v in pairs(game.workspace.NPCBees:GetChildren()) do
      if v.Name == "Windy" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
end
end
end
else 
      Windy = false
      noclip = false
      FindWindBee.BackgroundColor3 =blue
      end
end)







Usenightbell.MouseButton1Down:connect(function()
       
      
      local A = {

            ["Name"] = "Night Bell"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
end)





Usefielddice.MouseButton1Down:connect(function()
       
      
      local A = {

            ["Name"] = "Field Dice"
      }
      local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
      Event:FireServer(A)
end)






local killvici = false
Autokillvicious.MouseButton1Down:connect(function(q)
      local old2 = farming
      if killvici == false then
      
       
      killvici = true 
      Autokillvicious.BackgroundColor3 =red
      
      while killvici do
            wait()
      local old = farming  
      
      for _,i in pairs(game.workspace.Particles:GetChildren()) do 
      if string.find(i.Name,"Waiti") and not selling then
            farming = false
            noclip = true
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = i.CFrame
      else
            farming = old
      end
      end
for _,v in pairs(game.workspace.Monsters:GetChildren()) do 
      if string.find(v.Name,"Vici") and not selling then
            farming = false
            noclip = true
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Torso.CFrame * CFrame.new(0,13,0)
      else farming = old
      end
end
for _,r in pairs(game.workspace.Monsters:GetChildren()) do 
      if string.find(r.Name,"Gifted") and not selling then
            farming = false
            noclip = true
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = r.Torso.CFrame * CFrame.new(0,13,0)
      else
            farming = old
            end
            
      end
      end
local fi = false
for k,v in pairs(game.Workspace.Monsters:GetChildren()) do
      if string.find(v.Name,"Gifted") or string.find(v.Name,"Vici") then
            fi = true
      end
end
if fi == false then noclip = false end
else 
      killvici = false
      noclip = false
      farming = old2
      Autokillvicious.BackgroundColor3 =blue
      end
end)

SunflowerButton.MouseButton1Down:connect(function()
      tuoidz = "Sunflower Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
MushroomButton.MouseButton1Down:connect(function()
      tuoidz = "Mushroom Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
DanrButton.MouseButton1Down:connect(function()
      tuoidz = "Dandelion Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
DanrButton_2.MouseButton1Down:connect(function()
      tuoidz = "Clover Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
BlueflowerButton.MouseButton1Down:connect(function()
      tuoidz = "Blue Flower Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
BambooButton.MouseButton1Down:connect(function()
      tuoidz = "Bamboo Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
BambooButton.MouseButton1Down:connect(function()
      tuoidz = "Bamboo Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
SpiderButton.MouseButton1Down:connect(function()
      tuoidz = "Spider Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
StawberryButton.MouseButton1Down:connect(function()
      tuoidz = "Strawberry Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
StawberryButton.MouseButton1Down:connect(function()
      tuoidz = "Strawberry Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
PineappleButton.MouseButton1Down:connect(function()
      tuoidz = "Pineapple Patch"
      FieldText.Text = "Field Select: "..tuoidz
end)
StumpButton.MouseButton1Down:connect(function()
      tuoidz = "Stump Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
RoseButton.MouseButton1Down:connect(function()
      tuoidz = "Rose Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
CactusButton.MouseButton1Down:connect(function()
      tuoidz = "Cactus Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
PumpkinButton.MouseButton1Down:connect(function()
      tuoidz = "Pumpkin Patch"
      FieldText.Text = "Field Select: "..tuoidz
end)
PineTreeButton.MouseButton1Down:connect(function()
      tuoidz = "Pine Tree Forest"
      FieldText.Text = "Field Select: "..tuoidz
end)
MountainTopButton.MouseButton1Down:connect(function()
      tuoidz = "Mountain Top Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
CoconutButton.MouseButton1Down:connect(function()
      tuoidz = "Coconut Field"
      FieldText.Text = "Field Select: "..tuoidz
end)
PepperButton.MouseButton1Down:connect(function()
      tuoidz = "Pepper Patch"
      FieldText.Text = "Field Select: "..tuoidz
end)


            
local player = game.Players.LocalPlayer

local mouse = player:GetMouse()
local gui = Instance.new("ScreenGui",player.PlayerGui)
local frame = Instance.new("Frame",gui)
local act6 = false
local act6temp = false
local act5 = false









function Voiddz(sanghuman,sangzboi)
local jimmy = coroutine.wrap(function()
        repeat
            local sanghuman = player.Character.HumanoidRootPart
            local hotboi = sanghuman.CFrame
            local sangzboi = workspace.FlowerZones[tuoidz].CFrame
      
      if farmbubble then 
            for k,v in pairs(game.Workspace.Collectibles:GetChildren()) do
                  if v.ClassName=="Part" then
                  if (((v.Position-sangzboi.p).magnitude <= 60) and (sanghuman.Position-v.Position).magnitude<=60) then
                        if IsPopStar() then break end
                        if v:FindFirstChild("FrontDecal") then 
                              if (v.FrontDecal.Texture == TokenId["BlueBomb"] and v.FrontDecal.Color3 == Color3.fromRGB(70, 126, 251)) or (v.FrontDecal.Texture == TokenId["BlueBomb+"] and v.FrontDecal.Color3 == Color3.fromRGB(70, 126, 251)) or v.FrontDecal.Texture == TokenId["TokenLink"] and farming then   
                                    sanghuman.CFrame = CFrame.new(v.Position.x, sanghuman.Position.y, v.Position.z)
                                    wait(.2)
                        
                              end
                        end
                  end
            end
      end
                  while IsPopStar() do
                         
                        for k,v in pairs(game.Workspace.Collectibles:GetChildren()) do 
                              if ((v.Position-sangzboi.p).magnitude <= 60) and (sanghuman.Position-v.Position).magnitude<=60 then 
                                    if v:FindFirstChild("FrontDecal") then 
                                          if v.FrontDecal.Texture == TokenId["Frog"] and farming then
                                                sanghuman.CFrame = CFrame.new(v.Position.x, sanghuman.Position.y, v.Position.z)
                                                wait(.3)
                                          
                                          end
                                    
                                    end
                              end
                        
                        
                        end

                        for k,v in pairs(game.Workspace.Particles:GetChildren()) do
                              if v.ClassName == "Part" then
                              if ((v.Position-sangzboi.p).magnitude <= 60) and (sanghuman.Position-v.Position).magnitude<=60 and farming then
                                    if v.Name == "Bubble" then 
                                    sanghuman.CFrame = CFrame.new(v.Position.x, sanghuman.Position.y, v.Position.z)
                                    wait(.1)
                                    end
                              
                              end
                        end
                  end
                  wait()
            end
            
      wait(.1)
      else 
            Dig()
            for k,v in pairs(GetTokenLink()) do
            if act6temp then break; end
            if onlyhoney then break; end
            if ((v.Position-sangzboi.p).magnitude <= 60) and (sanghuman.Position-v.Position).magnitude<=60 and farming then
			tp(CFrame.new(v.Position.x, sanghuman.Position.y, v.Position.z),0.2)
                  Dig()
		end
		end

            for k,v in pairs(GetToken("Star")) do
                  if act6temp then break; end
                  if onlyhoney then break; end
                  if ((v.Position-sangzboi.p).magnitude <= 60) and (sanghuman.Position-v.Position).magnitude<=60 and farming then
                        tp(CFrame.new(v.Position.x, sanghuman.Position.y, v.Position.z),0.2)
                        Dig()
                  end
                  end
        for k,v in pairs(workspace.Collectibles:GetChildren()) do
            if act6temp then break; end
            if tostring(v) == tostring(game.Players.LocalPlayer.Name) or tostring(v) == "C" then
						if ((v.Position-sangzboi.p).magnitude <= 60) and (sanghuman.Position-v.Position).magnitude<=60 then
						
						if v:FindFirstChild("FrontDecal") then
				--if v.FrontDecal.Texture == HoneyBeeDecal then
                --sanghuman.CFrame = CFrame.new(v.Position.x, sanghuman.Position.y, v.Position.z)
                        local times = 0.2
				if nothoney then
				if v.FrontDecal.Texture ~= HoneyBeeDecal and farming then 
				tp(CFrame.new(v.Position.x, sanghuman.Position.y, v.Position.z),times)
                        Dig()
				end
				else
                        if onlyhoney then 
                              if v.FrontDecal.Texture == HoneyBeeDecal and farming then
                                    tp(CFrame.new(v.Position.x, sanghuman.Position.y, v.Position.z),times)
                              end
                        else
                              if farming then
                              tp(CFrame.new(v.Position.x, sanghuman.Position.y, v.Position.z),times)
                              Dig()
                              end
                        end
				

				end
                        wait(.05)
                local intvalue = Instance.new("IntValue",v)
                intvalue.Name = "Void"
 --wait(.1)
 
 end
end
--end
end
end
end
--wait(.1)
if (game.Workspace.FlowerZones[tuoidz].Position - player.Character.HumanoidRootPart.Position).magnitude >= 50 then 
--tp(sangzboi * CFrame.new(0,0,0))

sanghuman.CFrame = sangzboi * CFrame.new(0,0,0)
wait(1)
game.ReplicatedStorage.Events.PlayerActivesCommand:FireServer(
{
["Name"] = "Sprinkler Builder"
}
)
--sanghuman.CFrame = sangzboi * CFrame.new(0,0,0)
end
wait(.1)
until not act6 or act6temp
end)
local jimmy2 = coroutine.wrap(function()
for k,v in pairs(workspace[player.Name]:GetChildren()) do
if v.ClassName == "Tool" then
repeat
v.ClickEvent:FireServer()
wait(.1)
until not act6 or act6temp
end
end
end)
jimmy()
jimmy2()
end
StartButton.MouseButton1Down:connect(function()
if act6 == true then
act6 = false
farming = false
StartButton.BackgroundColor3 = blue
StartButton.Text = "START FARMING"
else
act6 = true
StartButton.BackgroundColor3 = red
StartButton.Text = "STOP FARMING"
farming = true
 

local jimmy3 = coroutine.wrap(function()
repeat
wait()
for k,v in pairs(workspace[player.Name]:GetChildren()) do
if v:FindFirstChild("Display") then
if player.CoreStats.Pollen.Value>= player.CoreStats.Capacity.Value then
act6temp = true
selling = true
wait(4)
local sanghuman = player.Character.HumanoidRootPart
local hotboi = sanghuman.CFrame
local sangzboi = workspace.FlowerZones[tuoidz].CFrame
--game:GetService("Players").LocalPlayer.Character:MoveTo(game:GetService("Players").LocalPlayer.SpawnPos.Value.p)
sanghuman.CFrame = game:GetService("Players").LocalPlayer.SpawnPos.Value
wait(3)
game:GetService("ReplicatedStorage").Events.PlayerHiveCommand:FireServer("ToggleHoneyMaking")
local ticks = tick()
repeat wait(.1) until player.CoreStats.Pollen.Value <= 1 and ticks-tick()<30
wait(1)                       
selling = false
--sanghuman.CFrame = sangzboi * CFrame.new(0,0,0)
wait(1)
local A = {
["Name"] = "Sprinkler Builder"
}
local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
Event:FireServer(A)
wait(1)
Voiddz(sanghuman,sangzboi)
act6temp = false
end
end
wait()
end
wait(1)
until not act6
end)
Voiddz(sanghuman,sangzboi)
jimmy3()	
end
end)
RemoteQuest.MouseButton1Down:connect(function()
if act5 == true then
act5 = false
RemoteQuest.BackgroundColor3 = blue
RemoteQuest.Text = "Auto Quest"
else
act5 = true
RemoteQuest.BackgroundColor3 = red
RemoteQuest.Text = "Auto Quest"
repeat
wait(5)
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Pepper")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Coconut")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Playtime")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Honey")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Quest")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Battle")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Ability")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Goo")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Sunflower")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Dandelion")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Mushroom")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Blue Flower")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Clover")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Spider")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Bamboo")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Strawberry")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Pineapple")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Pumpkin")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Cactus")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Rose")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Pine Tree")
game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", "Stump")
game.ReplicatedStorage.Events.ToyEvent:FireServer("Glue Dispenser")
game.ReplicatedStorage.Events.ToyEvent:FireServer("Free Royal Jelly Dispenser")
game.ReplicatedStorage.Events.ToyEvent:FireServer("Blueberry Dispenser")
game.ReplicatedStorage.Events.ToyEvent:FireServer("Strawberry Dispenser")
game.ReplicatedStorage.Events.ToyEvent:FireServer("Treat Dispenser")
game.ReplicatedStorage.Events.ToyEvent:FireServer("Wealth Clock")
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Brown Bear")
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Polar Bear")
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Honey Bee")
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Black Bear")
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Bucko Bee")
game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Riley Bee")
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Brown Bear")
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Polar Bear")
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Honey Bee")
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Black Bear")
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Bucko Bee")
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Riley Bee")

game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer("Black Bear 2")
game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer("Brown Bear 2")




until not act5
end
end)

Killstumnail.MouseButton1Down:connect(function()
if afksnail == false then 
afksnail = true 
Killstumnail.BackgroundColor3 = red 
 

local test = "C"
local tweenservice = game:GetService("TweenService")
local plr = game.Players.LocalPlayer
local info = TweenInfo.new(0.1) -- change to how long it takes to get to the item (in seconds)
local item = {}
while afksnail do
wait(1)    
for _,v in pairs(game.workspace:GetDescendants()) do
if string.find(v.Name,"LeafBurst") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Parent.CFrame * CFrame.new(0,0,0)
end
end
for k,v in pairs(workspace.Collectibles:GetChildren()) do
 if tostring(v) == tostring(game.Players.LocalPlayer.Name) or tostring(v) == test then
						if (v.Position-plr.Character.HumanoidRootPart.Position).magnitude <= 60 then
item.CFrame = CFrame.new(v.Position.x,plr.Character.HumanoidRootPart.Position.y,v.Position.z)
local Tween = tweenservice:Create(plr.Character.HumanoidRootPart, info, item)
Tween:Play()
end
end
end
end
else 
afksnail = false 
Killstumnail.BackgroundColor3 = blue 
end
end)
