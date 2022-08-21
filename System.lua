--TeamChoosingSystem

--Services
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")

--ServiceVariables
local Team1 = Teams.Team1 -- Change For Your Teams Here
local Team2 = Teams.Team2 -- Change For Your Teams Here

--SystemTables
local PlayerTable = {}
local LastChosenTable = {}

--SystemVariables
local SystemCounter = 0

--LocalFunctions
local function ChooseTeams()
    --ChooseRandomly
    local ChoicePicker = math.random(1, #PlayerTable)

    --FunctionVariables
    local ConfirmedPlayer = false

    for _, Player in LastChosenTable do
        if Player == PlayerTable[ChoicePicker] then
            ConfirmedPlayer = true
        end
    end

    if ConfirmedPlayer == true then
        ChooseTeams()
    else
        SystemCounter = SystemCounter + 1
        table.insert(LastChosenTable, PlayerTable[ChoicePicker])
        
        for _, ServicePlayer in Players:GetChildren() do
            if ServicePlayer.UserId == PlayerTable[ChoicePicker] then
                ServicePlayer.Team = Team2
            end
        end

        if SystemCounter == #PlayerTable then
            SystemCounter = 0
            
            for _, Position in LastChosenTable do
                table.remove(LastChosenTable, Position)
            end
        end
    end
end

--SystemEvents
Players.PlayerAdded:Connect(function(Player)
    table.insert(PlayerTable, Player.UserId) -- Add Player To Table
end)

Players.PlayerRemoving:Connect(function(RemovedPlayer)
    for _, Player in PlayerTable do
        if Player == RemovedPlayer.UserId then
            table.remove(PlayerTable, Player) -- Remove Player From System
        end
    end
end)