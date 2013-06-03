local _, addon = ...

local tremove = table.remove

local container, active, inactive = addon.container, {}, {}

function addon:Splat(customContainer)
    local splatter = tremove(inactive) or self:newSplatter(active, inactive)
    splatter:Show(customContainer or container)
    return splatter
end

addon.active = active
addon.inactive = inactive

--addon:Splat()
_G[addon.name] = addon
