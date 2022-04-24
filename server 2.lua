game:GetService("ReplicatedStorage"):WaitForChild("sound").OnServerEvent:Connect(function(plr, sound)
	if not plr.Character:WaitForChild("HumanoidRootPart"):FindFirstChild("lockon") then
		local x = sound:Clone()
		x.Parent = plr.Character:WaitForChild("HumanoidRootPart")
		x:Play()
	else 
		plr.Character:WaitForChild("HumanoidRootPart"):FindFirstChild("lockon"):Play()
	end
end)
game:GetService("ReplicatedStorage"):WaitForChild("sound2").OnServerEvent:Connect(function(plr, sound,x)
	if not plr.Character:WaitForChild("HumanoidRootPart"):FindFirstChild("locked") then
		local x = sound:Clone()
		x.Parent = plr.Character:WaitForChild("HumanoidRootPart")

		x:Play()
		
	else 
		plr.Character:WaitForChild("HumanoidRootPart"):FindFirstChild("locked"):Play()
		

	end
	
end)
