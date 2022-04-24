game.Players.PlayerAdded:Connect(function(player)
	local char = player.CharacterAdded:Wait()
	local head = char:WaitForChild("Head")
	if not workspace:FindFirstChild(player.Name.."-PartFolder") then
		fold = Instance.new("Folder")
		fold.Name = player.Name.."_PartFolder"
		fold.Parent = workspace
		print(fold:GetFullName())
	end
	if not fold:FindFirstChild("using") then
		local b = Instance.new("BoolValue")
		b.Name = "using"
		b.Parent = fold	
		print(b:GetFullName())
	end
	char.Humanoid.Died:Connect(function()
		wait(4)
			fold = Instance.new("Folder")
			fold.Name = "PartFolder"
			fold.Parent = player.Character
			print(fold:GetFullName())
			local b = Instance.new("BoolValue")
			b.Name = "using"
			b.Parent = fold	
			print(b:GetFullName())
		
	end)
	
end)
game.ReplicatedStorage:WaitForChild("x").OnServerEvent:Connect(function(a,x,goal,tool)
	if 	workspace[a.Name.."_PartFolder"].using.Value == false then
		workspace[a.Name.."_PartFolder"].using.Value = true
		local missile = game.ReplicatedStorage:WaitForChild("EnhancedCone"):Clone()
		missile.Size = Vector3.new(5.597, 0.163, 0.163)
		missile.Name = "Missile"
		missile.Parent = fold
		missile.Position = x.Parent.Part.Position
		missile.Transparency = 0
		local rocket = Instance.new("RocketPropulsion")
		rocket.Parent = missile
		rocket.Target = goal
		rocket.CartoonFactor = 1
		rocket.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
		local part2 = Instance.new("Part")
		part2.Position = missile.Position + Vector3.new(0,35,3)
		part2.Parent = workspace
		part2.Transparency = 1
		--rocket.Target = part2
		part2.Anchored = true
		local p = game:GetService("ReplicatedStorage").missile:Clone()
		p.Enabled = false
		p.Parent = missile
		
		rocket.Target = goal
		rocket.MaxSpeed = 30
		wait(0.2)
		rocket:Fire()
		wait(0.6)
		p.Enabled = true
		p:Emit(50)
		rocket.MaxSpeed = 185
		rocket:Fire()
		
		local hmrpz = a.Character:WaitForChild("HumanoidRootPart")
		if not hmrpz:FindFirstChild("fire") then 
			local sound = tool:FindFirstChild("fire"):Clone()
			sound.Parent = a.Character:WaitForChild("HumanoidRootPart")
			sound:Play()
		else 
			hmrpz:FindFirstChild("fire"):Play()
		end
		
		wait(1)
		p:Emit(100)
		p.Parent = missile
		p.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
		missile.Touched:Connect(function(hit)
			if hit == goal or (missile.Position - goal.Position).Magnitude < 10 then
				if hit == goal or (missile.Position - goal.Position).Magnitude < 10 then
					rocket:Destroy()
					if not goal:FindFirstChild("Explosion") then

						local sss = script.Explosion:Clone()
						sss.Parent = goal
						sss:Play()
					else 
						goal:FindFirstChild("Explosion"):Play()
					end
					local explosion = Instance.new("Explosion")
					explosion.BlastRadius = 70
					explosion.ExplosionType = Enum.ExplosionType.Craters -- damages terrain
					explosion.Position = hit.Position
					explosion.Parent = game.Workspace
					missile:Destroy()
					print("hit")

				
			end
			end
			end)
	else
		print("ammo ded")
	end
end)
