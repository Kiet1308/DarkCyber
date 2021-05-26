local noclip=false

game:GetService("RunService").Stepped:connect(
    function()
        if noclip then
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(11)
        end
    end
)

function tpT(t, k)
    if k == nil then
        k = 1
    end
    local plr = game:service "Players".LocalPlayer
    local tween_s = game:service "TweenService"
    local info =
        TweenInfo.new(
        (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - t.p).magnitude / k,
        Enum.EasingStyle.Quad
    )
    local tic_k = tick()
    --local params = {...};
    --local cframe = CFrame.new(params[1],params[2],params[3]);
    local cframe = t
    local tween, err =
        pcall(
        function()
            local tween = tween_s:Create(plr.Character:WaitForChild("HumanoidRootPart"), info, {CFrame = cframe})
            local done = false
            --print(done)
            tween.Completed:Connect(
                function()
                    done = true
                end
            )
            noclip = true
            tween:Play()
            while (done == false) do
                wait()

                --print(tostring(done.."k"))
            end
            noclip = false
            -- print(done)
        end
    )
    --syn.write_clipboard(err)
    --print(err)
    if not tween then
        return err
    end
end
for k,v in pairs(game.Workspace:GetChildren()) do 
        if string.match(v.Name,"Chest") then 
                tpT(v.CFrame,50)
                wait(5)
            end
    end
