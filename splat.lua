local _, addon = ...

local tremove = table.remove

local container, active, inactive = addon.container, {}, {}

function addon:Splat()
    local splatter = tremove(inactive) or self:newSplatter(container, active, inactive)
    splatter:Show()
end

addon.active = active
addon.inactive = inactive

--addon:Splat()
_G[addon.name] = addon
