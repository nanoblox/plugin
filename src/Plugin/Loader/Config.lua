--[[

Information here

--]]

local main = require(game.Nanoblox)
return {

	
	
	Roles = {
		---------------------------
		["FmELlZ2YaD"] = {
			_order = 1,
			name = "Owner",
			color = Color3.fromRGB(255, 0, 0),
			giveToCreator = true,
			inheritCommandsWithTags = {"level5"},
			limitCommandsPerInterval = false,
			limitGlobalExecutionsPerInterval = false,
			limitScale = false,
			limitGear = false,
			canBlockAll = true,
			canUseAll = true,
			canViewAll = true,
			canEditAll = true,
		},
		
		---------------------------
		["ueRXqVqe3t"] = {
			_order = 2,
			name = "Manager",
			color = Color3.fromRGB(255, 85, 0),
			inheritCommandsWithTags = {"level4"},
			limitCommandsPerInterval = false,
			limitScale = false,
			limitGear = false,
			canBlockAll = true,
			canUseAll = true,
			canViewAll = true,
			canEditLongtermUsers = true,
			canEditBans = true,
			canEditWarnings = true,
			
		},
		
		---------------------------
		["CPVAjVKg4U"] = {
			_order = 3,
			name = "Head Admin",
			color = Color3.fromRGB(255, 0, 255),
			inheritCommandsWithTags = {"level3"},
			commandsLimit = 200,
			scaleLimit = 100,
			canUseCmdbar1 = true,
			canUseCmdbar2 = true,
			canUseGlobalModifier = true,
			globalRefreshInterval = 60,
			globalsLimit = 1,
			canUseLoopModifier = true,
		},
		
		---------------------------
		["rc9idowbgu"] = {
			_order = 4,
			name = "Admin",
			color = Color3.fromRGB(255, 0, 255),
			inheritCommandsWithTags = {"level3"},
			commandsLimit = 200,
			scaleLimit = 100,
			canUseCmdbar1 = true,
			canUseCmdbar2 = true,
			canUseGlobalModifier = false,
			canUseLoopModifier = true,
		},
		
		---------------------------
		["U0jS1tKiBf"] = {
			_order = 5,
			name = "Mod",
			color = Color3.fromRGB(0, 170, 255),
			inheritCommandsWithTags = {"level2"},
			scaleLimit = 20,
			canUseCmdbar1 = true,
		},
		
		---------------------------
		["lazD41IMUu"] = {
			_order = 6,
			name = "Basic",
			color = Color3.fromRGB(0, 170, 85),
			inheritCommandsWithTags = {"level1"},
			canUseCommandsOnOthers = false,
		},
		---------------------------
		["IF9jL5UoJZ"] = {
			_order = 7,
			name = "Player",
			color = Color3.fromRGB(175, 175, 175),
			nonadmin = true,
			inheritCommandsWithTags = {"level0"},
			canUseCommandsOnOthers = false,
			canUseCommandsOnFriends = false,
			promptWelcomeRankNotice = false,
		},
		
		---------------------------
	},
	
	
	Bans = {
		---------------------------
		["0001"] = {
			reason = "Putting pineapple on pizza test",
		},
		
		---------------------------
		["0002"] = {
			reason = "Used facebook as a verb",
		},
		
		---------------------------
		["0003"] = {
			reason = "Test",
		},
		
		---------------------------
	},--]]
	
	
	
	Commands = {
		---------------------------
		["fly"] = {
			aliases = {},
			desc = "",
		},
		
		---------------------------
	},
	
	
	
	Settings = {
		---------------------------
		["Player"] = {
			prefixes = {","},
			argCapsule = "(%s)",
			collective = ",",
			descriptorSeparator = "",
			spaceSeparator = " ",
			batchSeparator = " ",
			playerIdentifier = "@",

			previewIncompleteCommands = false,
			
			theme = "",
			backgroundTransparency 	= 0.1,
		},
		
		
		---------------------------
		["System"] = {
			libraryIDs = { -- Gear, Sounds, Images, etc
				denylist = {},
				allowlist = {},
			},
			catalogIDs = { -- Accessories, Faces, etc
				denylist = {},
				allowlist = {},
			},
			bundleIDs = { -- Bundles
				denylist = {},
				allowlist = {},
			},

			-- Commands
			preventRepeatCommands = true,
			playerUndefinedSearch = main.enum.PlayerSearch.UserName, -- 'Undefined' means *without* the 'playerIdentifier' (e.g. ";kill Ben)
			playerDefinedSearch = main.enum.PlayerSearch.DisplayName, -- 'Defined' means *with* the 'playerIdentifier' (e.g. ";kill @ForeverHD)
			
			-- Warning System
			warnExpiryTime = 604800, -- 1 week
			kickUsers = true,
			warnsToKick = 3,
			serverBanUsers = true,
			warnsToServerBan = 4,
			serverBanTime = 7200, -- 2 hours
			globalBanUsers = true,
			warnsToGlobalBan = 5,
			globalBanTime = 172800, -- 2 days
		}
		
		
		
	},
	
	
	
}