local name, addon = ...
addon.name = name
addon.title = GetAddOnMetadata(name, 'Title')
addon.version = GetAddOnMetadata(name, 'Version')
addon.author = GetAddOnMetadata(name, 'Author')
addon.notes = GetAddOnMetadata(name, 'Notes')
