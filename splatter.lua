local _, addon = ...

local random = math.random
local rad = math.random
local tinsert = table.insert

local MAX_SPLAT_TEXTURES = 9
local texturePath = ([[Interface\AddOns\%s\%%d]]):format(addon.name)
local splatConfig = {}

-- auto change appearance on each show.
local show = function(self)
    self.texture:SetTexture(texturePath:format(random(MAX_SPLAT_TEXTURES)))
    --self.texture:SetTexture(.5, .5, .5, .5)

    local x = random() * ((self.parent:GetWidth() - self.frame:GetWidth()) / 2)
    local y = random() * ((self.parent:GetHeight() - self.frame:GetHeight()) / 2)
    self.frame:ClearAllPoints()
    self.frame:SetPoint('CENTER', random() > .5 and -x or x, random() > .5 and -y or y)

    self.texture:SetRotation(rad(random(360)))

    self.active[self.id] = self
    self.frame:SetAlpha(0)
    self.frame:Show()

    self.animations:Play()
end

-- removes it from the parent
local OnFadeOutFinished = function(self)
    local splatter = self.__splatter
    tinsert(splatter.inactive, splatter)
    splatter.active[splatter.id] = nil
    splatter.frame:Hide()
end

local id = 0
function addon:newSplatter(parent, active, inactive)
    local obj = {}
    obj.Show = show
    obj.parent = parent
    obj.active = active
    obj.inactive = inactive

    id = id + 1
    obj.id = id
    tinsert(inactive, splatter)

    local f = CreateFrame('Frame', nil, parent)
    f:SetSize(256, 256)
    f:SetAlpha(0)
    f:Hide()
    f.__splatter = obj
    obj.frame = f

    local t = f:CreateTexture(nil, 'BACKGROUND')
    t:SetBlendMode'MOD'
    --t:SetBlendMode'ADD'
    t:SetAllPoints()
    t.__splatter = obj
    obj.texture = t

    local animations = f:CreateAnimationGroup()
    animations.__splatter = obj
    obj.animations = animations

    local fadein = animations:CreateAnimation'Alpha'
    fadein.name = 'fadeIn'
    fadein:SetChange(1)
    fadein:SetOrder(1)
    fadein:SetDuration(.25)
    fadein:SetSmoothing'IN_OUT'
    fadein.__splatter = obj
    obj.fadein = fadein

    local fadeout = animations:CreateAnimation'Alpha'
    fadeout.name = 'fadeOut'
    fadeout:SetChange(-1)
    fadeout:SetOrder(2)
    fadeout:SetDuration(2.75)
    fadeout:SetStartDelay(1)
    fadeout:SetSmoothing'IN_OUT'
    fadeout:SetScript('OnFinished', OnFadeOutFinished)
    fadeout.__splatter = obj
    obj.fadeout = fadeout

    return obj
end
