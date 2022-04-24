local equipped = false
local holding = false
local c = game.Players.LocalPlayer.CharacterAdded:Wait()
local head = c:WaitForChild("Head")
local camera = workspace.CurrentCamera
local player = game.Players.LocalPlayer
local distance = 2500 -- studs
local function IsFirstPerson()
	if (head.CFrame.p - camera.CFrame.p).Magnitude < 3 then
		return true
	else
		return false
	end
end
local f = false
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
raycastParams.FilterDescendantsInstances = {player.Character}
raycastParams.IgnoreWater = true
local prev = nil
script.Parent.Equipped:Connect(
	function(Mouse)
		equipped = true
		Mouse.Button2Down:Connect(
			function()
				if IsFirstPerson() then
					
					holding = true
					print(holding)
					local Properties = {FieldOfView = 30}
					local Info = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut) -- edit as you want
					local info = TweenInfo.new(1)
					local tweens = game:GetService("TweenService"):Create(player.PlayerGui:WaitForChild("black").Frame,info,{BackgroundTransparency = 0})
					tweens:Play()
					tweens.Completed:Wait()
					player.PlayerGui:WaitForChild("aim").Enabled = true
					local twee2n = game:GetService("TweenService"):Create(player.PlayerGui:WaitForChild("black").Frame,info,{BackgroundTransparency = 1})
					twee2n:Play()
					twee2n.Completed:Wait()
					spawn(function()
						repeat 
							game:GetService("ReplicatedStorage"):WaitForChild("sound"):FireServer(script.Parent.lockon)
							task.wait(1.071)
						until f == true or not holding
					end)
					spawn(function()
						repeat
							local result = workspace:Raycast(head.Position,(Mouse.Hit.Position - head.Position).Unit * distance,raycastParams)
							local hitPart, hitPosition = unpack({result.Instance, result.Position})
							if prev == nil then
								prev = hitPart
							else 
								if hitPart ~= prev then
									for i,v in pairs (hitPart.Parent:GetDescendants()) do 
										
									end
								else 
									
								end
							end
							wait(0.1)
							
						until not holding or f == true	
						
					end)
					if not workspace:FindFirstChild(player.Name.."_PartFolder").using.Value then
						
						
						game:GetService("UserInputService").InputBegan:Connect(function(inp,ist)
							if ist then return end
							if inp.UserInputType == Enum.UserInputType.MouseButton1 and holding then
								repeat 
									result = workspace:Raycast(head.Position,(Mouse.Hit.Position - head.Position).Unit * distance,raycastParams)
									wait(0.1)
								until result ~= nil 
								if result then
									player.PlayerGui:WaitForChild("aim").Enabled = false

									game:GetService("ReplicatedStorage"):WaitForChild("sound2"):FireServer(script.Parent.locked,goal)
									spawn(function()
										player.PlayerGui:WaitForChild("ScreenGui").Enabled = true
										wait(0.1)
										player.PlayerGui:WaitForChild("ScreenGui").Enabled = false
										wait(0.1)
										player.PlayerGui:WaitForChild("ScreenGui").Enabled = true
										wait(0.1)
										player.PlayerGui:WaitForChild("ScreenGui").Enabled = false
										wait(0.1)
										player.PlayerGui:WaitForChild("ScreenGui").Enabled = true
										wait(0.1)
										player.PlayerGui:WaitForChild("ScreenGui").Enabled = false
										wait(0.1)

									end)
									wait(0.6)
									f = true
									print "FIRE!!!"
									print("FIRE")
									local hitPart, hitPosition = unpack({result.Instance, result.Position})
									if (hitPart.Parent:FindFirstChild("Humanoid")) then
										player.PlayerGui:WaitForChild("aim").Enabled = false
										local hitPartz, hitPositionz = unpack({result.Instance, result.Position})
										if(hitPartz.Parent:FindFirstChild("Humanoid") == hitPart.Parent:FindFirstChild("Humanoid")) then
											local hum = hitPart.Parent:FindFirstChild("Humanoid")
											local goal = hitPart.Parent.HumanoidRootPart
											local fold = workspace:FindFirstChild(player.Name.."_PartFolder")
											if not fold:FindFirstChild("Missile") then
												--heartbeatConnection:Disconnect()
												game.ReplicatedStorage:WaitForChild("x"):FireServer(script.Parent.Handle, goal,script.Parent)
												return
											else
												--heartbeatConnection:Disconnect()
												game.ReplicatedStorage:WaitForChild("a"):FireServer(fold:FindFirstChild("Missile"),goal,script.Parent)
												
												return
											end
										else 
											print"aim better nigga"
										end
										
									else 
										print("no humanoid")
										wait(0.5)
									end
								
								end
							end
						end)
						

						--if not holding then heartbeatConnection:Disconnect() end
					else 
						print("no ammo")
					end
				else
					print("not first person")
				end
			end)
		Mouse.Button2Up:Connect(
			function()
				local Properties = {FieldOfView = 70} -- change the number as you wish
				local Info = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut) -- edit as you want
				local T = game:GetService("TweenService"):Create(game.Workspace.CurrentCamera, Info, Properties)
				T:Play()
				holding = false
				player.PlayerGui:WaitForChild("aim").Enabled = false
				print(holding)
			end)
		print(equipped)
	end)

script.Parent.Unequipped:Connect(
	function()
		player.PlayerGui:WaitForChild("aim").Enabled = false

		equipped = false
		print(equipped)
	end)
