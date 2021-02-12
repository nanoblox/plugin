-- We don't want the plugin running in studio play-test
local serverScriptService = game:GetService("ServerScriptService")
local runService = game:GetService("RunService")
local isEdit = runService:IsEdit()
if not isEdit then return end

-- This is a very simplified plugin to assist the team with developing the core and commands
-- The actual Nanoblox plugin will be an interface (like that from ingame) that enables you to setup
-- sections such as Roles in studio entirely through an easy-to-use interface
local LOADER_NAME = "Nanoblox"
local COMMANDS_MAINMODULE_ID = 6335531490
local EXTENSIONS = {
    ["Commands"] = true,
    ["Core"] = {
        Client = true,
        Server = true,
        Shared = true,
    },
    ["Morphs"] = true,
    ["Themes"] = true,
    ["Tools"] = true,
}

local toolbar = plugin:CreateToolbar("Nanoblox")
local pluginButton = toolbar:CreateButton("Nanoblox", "Click to install (this will be an actual interface later on not just a single button)", "rbxassetid://6379134806")
local newCommandsMainModule = require(COMMANDS_MAINMODULE_ID)
local newCommandsContainer = newCommandsMainModule and newCommandsMainModule.Commands
local newLoader = script.Parent

local function findLoader()
    for _, instance in pairs(serverScriptService:GetDescendants()) do
        if instance.Name == LOADER_NAME and instance:FindFirstChild("Loader") and instance:FindFirstChild("Config") then
            return instance
        end
    end
    return false
end

local function isACommandModule(module)
    return module:IsA("ModuleScript") and (not module.Parent:IsA("ModuleScript") or module.Parent.Name == "MainModule")
end

local function getOnlyNewCommandsArray()
    local prevLoader = findLoader()
    local existingCommands = {}
    local newCommandsArray = {}
    local extensionsContainer = prevLoader and prevLoader:FindFirstChild("Extensions")
    local commandsExtensionContainer = extensionsContainer and extensionsContainer:FindFirstChild("Commands")
    if commandsExtensionContainer then
        for _, commandModule in pairs(commandsExtensionContainer:GetDescendants()) do
            if isACommandModule(commandModule) then
                existingCommands[commandModule.Name] = true
            end
        end
    end
    for _, commandModule in pairs(newCommandsContainer:GetDescendants()) do
        if isACommandModule(commandModule) and not existingCommands[commandModule.Name] then
            table.insert(newCommandsArray, commandModule)
        end
    end
    return newCommandsArray
end

local function installLoader()
    local clonedLoader = newLoader.Loader:Clone()
    clonedLoader.Name = LOADER_NAME
    clonedLoader.Parent = serverScriptService
    clonedLoader.Loader.Disabled = false
    local function buildDirectory(container, table)
        for name, value in pairs(table) do
            local subContainer = Instance.new("Folder")
            subContainer.Name = name
            subContainer.Parent = container
            if type(value) == "table" then
                buildDirectory(subContainer, value)
            end
        end
    end
    buildDirectory(clonedLoader.Extensions, EXTENSIONS)
    return clonedLoader
end

local function moveItems(sourceContainer, targetContainer)
    for _, sourceChild in pairs(sourceContainer:GetChildren()) do
        local targetChild = targetContainer:FindFirstChild(sourceChild.Name)
        local movedItems = false
        if targetChild then
            local sourceClass = sourceChild.ClassName
            local targetClass = targetChild.ClassName
            if sourceClass == targetClass and (sourceClass == "Folder" or sourceClass == "Configuration") then
                moveItems(sourceChild, targetChild)
                movedItems = true
            else
                targetChild:Destroy()
            end
        end
        if not movedItems then
            sourceChild.Parent = targetContainer
        end
    end
    sourceContainer:Destroy()
end

-- On Button Click
pluginButton.Click:Connect(function()
    local prevLoader = findLoader()
    local newCommandsArray = getOnlyNewCommandsArray()
    local clonedLoader = prevLoader or installLoader()
    local extensions = clonedLoader:FindFirstChild("Extensions")
    local commandExtensions = extensions and extensions:FindFirstChild("Commands")
    if commandExtensions then
        local clonedCommandsContainer = newCommandsContainer:Clone()
        local totalNewCommands = #newCommandsArray
        local startMessage = (prevLoader and "Updating Nanoblox...") or "Installing Nanoblox..."
        print(startMessage)
        if totalNewCommands > 0 then
            moveItems(clonedCommandsContainer, commandExtensions)
            print("Added new commands:")
            for _, commandModule in pairs(newCommandsArray) do
                print("  -", commandModule.Name)
            end
        end
        local endMessage = (prevLoader and "Successfully updated Nanoblox!") or "Successfully installed Nanoblox into ServerScriptService!"
        print(endMessage)
    elseif not extensions then
        print("Missing Nanoblox Extensions container")
    else
        print("Missing Nanoblox Commands extension container")
    end
    pluginButton:SetActive(false)
end)

-- Notify of any new commands
local prevLoader = findLoader()
local newCommandsArray = getOnlyNewCommandsArray()
local totalNewCommands = #newCommandsArray
if prevLoader and totalNewCommands > 0 then
    local messageStart = (totalNewCommands == 1 and "There is 1 new Nanoblox command!") or ("There are %s new Nanoblox commands!"):format(totalNewCommands)
    print(("%s Click the N icon to install."):format(messageStart))
end