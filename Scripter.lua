local L, P, R, V = game:GetService("Players").LocalPlayer, game:GetService("Players"), game:GetService("RunService"), game:GetService("VirtualInputManager")
_G.H, _G.A, _G.S = false, false, 10

-- FUNÇÃO PARA CRIAR A GUI (ORGANIZADO PARA NÃO SUMIR AO MORRER)
local s = Instance.new("ScreenGui")
s.Name = "IVANLvB_Final"
s.Parent = L.PlayerGui
s.ResetOnSpawn = false -- ISSO FAZ O SCRIPT NÃO PARAR AO MORRER
s.IgnoreGuiInset = true

-- INTRO IVANLvB (5 SEGUNDOS)
local b = Instance.new("Frame", s)
b.Size, b.BackgroundColor3 = UDim2.new(1,0,1,0), Color3.new(0,0,0)
local t = Instance.new("TextLabel", b)
t.Size, t.BackgroundTransparency, t.Text, t.TextColor3, t.TextSize, t.Font = UDim2.new(1,0,1,0), 1, "IVANLvB", Color3.new(1,0,0), 80, "SourceSansBold"
t.Position = UDim2.new(-1, 0, 0, 0)

t:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 1)
task.delay(5, function() b:Destroy() end)

-- PAINEL PRINCIPAL
local m = Instance.new("Frame", s)
m.Size, m.Position, m.BackgroundColor3, m.Visible, m.Active, m.Draggable = UDim2.new(0,180,0,240), UDim2.new(0.5,-90,0.5,-120), Color3.new(0.05,0.05,0.05), false, true, true
Instance.new("UICorner", m)

-- BOTÃO ABRIR/FECHAR
local o = Instance.new("TextButton", s)
o.Size, o.Position, o.Text, o.BackgroundColor3, o.Draggable = UDim2.new(0,60,0,60), UDim2.new(0.5,-30,0.1,0), "IVAN", Color3.new(0,1,0), true
o.TextColor3 = Color3.new(0,0,0)
Instance.new("UICorner", o)
o.MouseButton1Click:Connect(function() m.Visible = not m.Visible end)

-- CAIXA DE TEXTO (TAMANHO)
local inp = Instance.new("TextBox", m)
inp.Size, inp.Position, inp.Text, inp.PlaceholderText = UDim2.new(0,140,0,30), UDim2.new(0,20,0,20), "10", "Tamanho..."
inp.BackgroundColor3, inp.TextColor3, inp.Font = Color3.new(0.1,0.1,0.1), Color3.new(1,1,1), 2
Instance.new("UICorner", inp)

local function btn(txt, y, cb)
    local nb = Instance.new("TextButton", m)
    nb.Size, nb.Position, nb.Text, nb.BackgroundColor3 = UDim2.new(0,140,0,40), UDim2.new(0,20,0,y), txt, Color3.new(0.15,0.15,0.15)
    nb.TextColor3, nb.Font, nb.TextSize = Color3.new(1,1,1), 2, 14
    Instance.new("UICorner", nb)
    nb.MouseButton1Click:Connect(function() cb(nb) end)
end

btn("Aumenta Hitbox", 60, function(v) 
    _G.H = not _G.H 
    _G.S = tonumber(inp.Text) or 10
    v.Text = _G.H and "HITBOX: ON" or "HITBOX: OFF" 
    v.TextColor3 = _G.H and Color3.new(0,1,0) or Color3.new(1,1,1) 
end)

btn("RELOAD 10000x", 120, function(v) 
    _G.A = not _G.A 
    v.Text = _G.A and "RELOAD: ON" or "RELOAD: OFF" 
    v.TextColor3 = _G.A and Color3.new(0,1,0) or Color3.new(1,1,1) 
end)

-- SISTEMA HITBOX (SÓ APLICA SE NÃO BUGAR CAVALO)
R.RenderStepped:Connect(function()
    if _G.H then
        for _, p in pairs(P:GetPlayers()) do
            if p ~= L and p.Character and p.Character:FindFirstChild("Head") then
                local h = p.Character.Head
                h.Size = Vector3.new(_G.S, _G.S, _G.S)
                h.Transparency = 0.8
                h.CanCollide = false
                h.Massless = true
                h.BrickColor = BrickColor.new("Bright green")
            end
        end
    end
end)

-- SISTEMA RELOAD TURBO (ADAPTADO PARA RENASCIMENTO)
R.Heartbeat:Connect(function()
    if _G.A then
        -- Tenta pegar a arma do personagem atual (mesmo após renascer)
        local char = L.Character
        local tool = char and char:FindFirstChildOfClass("Tool")
        if tool and tool:FindFirstChild("Ammo") and tool.Ammo.Value == 0 then
            V:SendKeyEvent(true, Enum.KeyCode.R, false, game)
            V:SendKeyEvent(false, Enum.KeyCode.R, false, game)
        end
    end
end)
