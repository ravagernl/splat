local _, addon = ...

local container = CreateFrame('Frame', nil, WorldFrame)
container:SetPoint'CENTER'
container:SetSize(WorldFrame:GetWidth()/2, WorldFrame:GetHeight()/2)

addon.container = container
