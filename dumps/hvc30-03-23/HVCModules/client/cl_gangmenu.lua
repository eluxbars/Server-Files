local GangMenuOpen = false;
local OffestY = 0.033;
local OffestX = 0;
local IsInGang = false;
local SelectedGang = nil;
local CurrentPage = "Main";
local GangIdentifier = "N/A";
local GangFunds = 0;
HVCGangs = Tunnel.getInterface("HVCGangs","HVCGangs")
local OffestY = 0.033
local OffestX = 0
local SelectedPlayer = {}

local InviteList = {

};

local GangInfo = {
    
};

Citizen.CreateThread(function()
    while true do
        if IsControlJustPressed(0, 166) then
            if GangMenuOpen == false then
                HVCModule.RequestGangInfo()
                HVCModule.RequestInviteInfo()
            end
            GangMenuOpen = not GangMenuOpen
            SetCursorLocation(0.5, 0.5)
        end
        if GangMenuOpen then
            ShowCursorThisFrame()
            SetCursorSprite(0)



            if not IsInGang then

                DrawAdvancedText(0.595, 0.373, 0.005, 0.0028, 0.5, "Gang Menu", 255, 255, 255, 255, 7, 0)
                DrawRect(0.50, 0.375, 0.300, 0.050, 0, 0, 0, 150)
                DrawRect(0.50, 0.390, 0.300, 0.005, 247, 47, 47, 150)
                DrawRect(0.50, 0.5, 0.300, 0.200, 0, 0, 0, 150) -- Main Body

                DrawAdvancedText(0.6585, 0.448, 0.005, 0.0028, 0.19, "Invite List", 255, 255, 255, 255, 0, 0)
                DrawRect(0.5614, 0.448, 0.100, 0.005, 247, 47, 47, 175)
                DrawRect(0.5614, 0.5, 0.100, 0.110, 0, 0, 0, 150) -- Invite Body

                for k,v in pairs(InviteList) do
                    DrawAdvancedText(0.6559, 0.47 + OffestX * OffestY, 0.005, 0.0028, 0.20, v[1], 255, 255, 255, 255, 0, 0)

                    if isCursorInPosition(0.5614, 0.46 + OffestY * OffestX, 0.100, 0.020) then
                        DrawRect(0.5614, 0.46 + OffestY * OffestX, 0.100, 0.020, 255, 255, 255, 120)
                        if IsDisabledControlJustPressed(0, 92) then
                            SelectedGang = v[1]
                        end
                    else
                        DrawRect(0.5614, 0.46 + OffestY * OffestX, 0.100, 0.020, 0, 0, 0, 120)
                    end
                    OffestX = OffestX + 0.7
                end
                OffestX = 0

                DrawAdvancedText(0.525, 0.470, 0.005, 0.0028, 0.26, "Create A Gang", 255, 255, 255, 255, 7 , 0)
                if isCursorInPosition(0.43, 0.460, 0.100, 0.047) then  --- Create Gang
                    DrawRect(0.43, 0.460, 0.100, 0.047, 255, 255, 255, 150)
                    if IsDisabledControlJustPressed(0, 92) then
                        local GangName = KeyboardInput("Enter gang name", "", 10)
                        if GangName == "" or GangName == " " or GangName == nil then 
                            Notify("~r~Invalid gang name!")
                        else
                            HVCModule.CreateGang({GangName})
                        end
                    end
                else
                    DrawRect(0.43, 0.460, 0.100, 0.047, 0, 0, 0, 150)
                end



                DrawAdvancedText(0.525, 0.540, 0.005, 0.0028, 0.26, "Join Gang", 255, 255, 255, 255, 7 , 0)
                if isCursorInPosition(0.43, 0.530, 0.100, 0.047) then   --- Join Gang
                    DrawRect(0.43, 0.530, 0.100, 0.047, 255, 255, 255, 150)
                    if IsDisabledControlJustPressed(0, 92) then
                        if SelectedGang ~= nil then
                            HVCModule.JoinGang({SelectedGang})
                            Wait(100)
                            HVCModule.RequestGangInfo()
                            HVCModule.RequestInviteInfo()
                            IsInGang = true
                        else
                            Notify("~r~You need to select a gang to join!")
                        end
                    end
                else
                    DrawRect(0.43, 0.530, 0.100, 0.047, 0, 0, 0, 150)
                end





            elseif IsInGang then

                DrawAdvancedText(0.595, 0.266, 0.005, 0.0028, 0.46, "Gang Menu", 255, 255, 255, 255, 7 , 0)
                DrawRect(0.50, 0.266, 0.403, 0.050, 0, 0, 0, 150)
                DrawRect(0.50, 0.516, 0.403, 0.550, 0, 0, 0, 150)
                DrawRect(0.50, 0.293, 0.403, 0.005, 247, 47, 47, 150)
                DrawRect(0.4067, 0.543, 0.0020, 0.494, 247, 47, 47, 150)







                DrawAdvancedText(0.447, 0.380, 0.005, 0.0028, 0.26, "Funds", 255, 255, 255, 255, 7 , 0)
                if isCursorInPosition(0.3525, 0.370, 0.100, 0.047) then   --- Join Gang
                    DrawRect(0.3525, 0.370, 0.100, 0.047, 255, 255, 255, 150)
                    if IsDisabledControlJustPressed(0, 92) then
                        CurrentPage = "Funds"
                    end
                else
                    if CurrentPage == "Funds" then
                        DrawRect(0.3525, 0.370, 0.100, 0.047, 255, 255, 255, 150)
                    else
                        DrawRect(0.3525, 0.370, 0.100, 0.047, 0, 0, 0, 150)
                    end
                end

                DrawAdvancedText(0.447, 0.460, 0.005, 0.0028, 0.26, "Members", 255, 255, 255, 255, 7 , 0)
                if isCursorInPosition(0.3525, 0.450, 0.100, 0.047) then   --- Join Gang
                    DrawRect(0.3525, 0.450, 0.100, 0.047, 255, 255, 255, 150)
                    if IsDisabledControlJustPressed(0, 92) then
                        CurrentPage = "Members"
                    end
                else
                    if CurrentPage == "Members" then
                        DrawRect(0.3525, 0.450, 0.100, 0.047, 255, 255, 255, 150)
                    else
                        DrawRect(0.3525, 0.450, 0.100, 0.047, 0, 0, 0, 150)
                    end
                end

                DrawAdvancedText(0.447, 0.540, 0.005, 0.0028, 0.26, "Turfs", 255, 255, 255, 255, 7 , 0)
                if isCursorInPosition(0.3525, 0.530, 0.100, 0.047) then   --- Join Gang
                    DrawRect(0.3525, 0.530, 0.100, 0.047, 255, 255, 255, 150)
                    if IsDisabledControlJustPressed(0, 92) then
                        CurrentPage = "Turfs"
                    end
                else
                    if CurrentPage == "Turfs" then
                        DrawRect(0.3525, 0.530, 0.100, 0.047, 255, 255, 255, 150)
                    else
                        DrawRect(0.3525, 0.530, 0.100, 0.047, 0, 0, 0, 150)
                    end
                end

                DrawAdvancedText(0.447, 0.620, 0.005, 0.0028, 0.26, "Settings", 255, 255, 255, 255, 7 , 0)
                if isCursorInPosition(0.3525, 0.610, 0.100, 0.047) then   --- Join Gang
                    DrawRect(0.3525, 0.610, 0.100, 0.047, 255, 255, 255, 150)
                    if IsDisabledControlJustPressed(0, 92) then
                        CurrentPage = "Settings"
                    end
                else
                    if CurrentPage == "Settings" then
                        DrawRect(0.3525, 0.610, 0.100, 0.047, 255, 255, 255, 150)
                    else
                        DrawRect(0.3525, 0.610, 0.100, 0.047, 0, 0, 0, 150)
                    end
                end

                DrawAdvancedText(0.447, 0.700, 0.005, 0.0028, 0.26, "Gang Logs", 255, 255, 255, 255, 7 , 0)
                if isCursorInPosition(0.3525, 0.690, 0.100, 0.047) then   --- Join Gang
                    DrawRect(0.3525, 0.690, 0.100, 0.047, 255, 255, 255, 150)
                    if IsDisabledControlJustPressed(0, 92) then
                        CurrentPage = "GangLogs"
                    end
                else
                    if CurrentPage == "GangLogs" then
                        DrawRect(0.3525, 0.690, 0.100, 0.047, 255, 255, 255, 150)
                    else
                        DrawRect(0.3525, 0.690, 0.100, 0.047, 0, 0, 0, 150)
                    end
                end




                if CurrentPage == "Funds" then

                    DrawAdvancedText(0.6425, 0.4215, 0.005, 0.0028, 0.26, "£" ..Comma(GangFunds), 0, 255, 0, 255, 0 , 0) -- Acctual Funds

                    DrawAdvancedText(0.5975, 0.540, 0.005, 0.0028, 0.26, "Withdraw", 255, 255, 255, 255, 7, 0)
                    if isCursorInPosition(0.5025, 0.530, 0.075, 0.047) then
                        DrawRect(0.5025, 0.530, 0.075, 0.047, 255, 255, 255, 150)
                        if IsDisabledControlJustPressed(0, 92) then
                            if #(vector3(146.9802, -1035.125, 29.33044) - GetEntityCoords(PlayerPedId())) < 10 then
                                local Amount = KeyboardInput("Enter amount to withdraw", "", 10)
                                if Amount == "" or Amount == " " or Amount == nil or tonumber(Amount) < 0 then 
                                    Notify("~r~Invalid amount, please try again!")
                                else
                                    HVCModule.ModifyGangFunds({"Withdraw", GangIdentifier, Amount})
                                end
                            else
                                Notify("~r~You need to be near legion.")
                            end
                        end
                    else
                        DrawRect(0.5025, 0.530, 0.075, 0.047, 0, 0, 0, 150)
                    end

                    DrawAdvancedText(0.6975, 0.540, 0.005, 0.0028, 0.26, "Deposit", 255, 255, 255, 255, 7 , 0)
                    if isCursorInPosition(0.6025, 0.530, 0.075, 0.047) then
                        DrawRect(0.6025, 0.530, 0.075, 0.047, 255, 255, 255, 150)
                        if IsDisabledControlJustPressed(0, 92) then
                            if #(vector3(146.9802, -1035.125, 29.33044) - GetEntityCoords(PlayerPedId())) < 10 then
                                local Amount = KeyboardInput("Enter amount to deposit", "", 10)
                                if Amount == "" or Amount == " " or Amount == nil or tonumber(Amount) < 0 then 
                                    Notify("~r~Invalid amount, please try again!")
                                else
                                    HVCModule.ModifyGangFunds({"Deposit", GangIdentifier, Amount})
                                end
                            else
                                Notify("~r~You need to be near legion.")
                            end
                        end
                    else
                        DrawRect(0.6025, 0.530, 0.075, 0.047, 0, 0, 0, 150)
                    end
                
                elseif CurrentPage == "Members" then
                    DrawRect(0.5530, 0.5, 0.255, 0.250, 0, 0, 0, 150)
                    DrawAdvancedText(0.5458, 0.3920, 0.005, 0.0028, 0.20, "Name", 255, 255, 255, 255, 0, 0)
                    DrawAdvancedText(0.6458, 0.3920, 0.005, 0.0028, 0.20, "PermID", 255, 255, 255, 255, 0, 0)
                    DrawAdvancedText(0.7458, 0.3920, 0.005, 0.0028, 0.20, "Rank", 255, 255, 255, 255, 0, 0)
                    DrawRect(0.5534, 0.392, 0.255, 0.0025, 247, 47, 47, 150)
                    
                    for k,v in pairs(GangInfo) do
                        DrawAdvancedText(0.5458, 0.4130 + OffestX * OffestY, 0.005, 0.0028, 0.20, v[1], 255, 255, 255, 255, 0, 0)
                        DrawAdvancedText(0.6458, 0.4130 + OffestX * OffestY, 0.005, 0.0028, 0.20, v[3], 255, 255, 255, 255, 0, 0)
                        DrawAdvancedText(0.7458, 0.4130 + OffestX * OffestY, 0.005, 0.0028, 0.20, v[2], 255, 255, 255, 255, 0, 0)

                        if isCursorInPosition(0.5530, 0.4040 + OffestY * OffestX, 0.255, 0.020) then
                            DrawRect(0.5530, 0.4040 + OffestY * OffestX, 0.255, 0.020, 255, 255, 255, 120)
                            if IsDisabledControlJustPressed(0, 92) then
                                SelectedPlayer = GangInfo[k]
                            end
                        else
                            -- DrawRect(0.5530, 0.4040 + OffestY * OffestX, 0.255, 0.020, 0, 0, 0, 120)
                        end
                        OffestX = OffestX + 0.7
                    end
                    OffestX = 0
                    
                    DrawAdvancedText(0.5975, 0.690, 0.005, 0.0028, 0.26, "Promote", 255, 255, 255, 255, 7 , 0)
                    if isCursorInPosition(0.5025, 0.680, 0.075, 0.047) then
                        DrawRect(0.5025, 0.680, 0.075, 0.047, 255, 255, 255, 150)
                        if IsDisabledControlJustPressed(0, 92) then
                            local GangName = KeyboardInput("Are you sure", "Yes | No", 10)
                            if GangName == "" or GangName == " " or GangName == nil then 
                                Notify("~r~Invalid string")
                            elseif GangName == "Yes" then
                                HVCModule.ModifyGangRanks({"Promote", GangIdentifier, SelectedPlayer[3]})
                            elseif GangName == "No" then
                                Notify("~r~" ..SelectedPlayer[1].. " was not Promoted.")
                            else
                                Notify("~r~Invalid string")
                            end
                        end
                    else
                        DrawRect(0.5025, 0.680, 0.075, 0.047, 0, 0, 0, 150)
                    end

                    DrawAdvancedText(0.6975, 0.690, 0.005, 0.0028, 0.26, "Demote", 255, 255, 255, 255, 7 , 0)
                    if isCursorInPosition(0.6025, 0.680, 0.075, 0.047) then
                        DrawRect(0.6025, 0.680, 0.075, 0.047, 255, 255, 255, 150)
                        if IsDisabledControlJustPressed(0, 92) then
                            local GangName = KeyboardInput("Are you sure", "Yes | No", 10)
                            if GangName == "" or GangName == " " or GangName == nil then 
                                Notify("~r~Invalid String")
                            elseif GangName == "Yes" then
                                HVCModule.ModifyGangRanks({"Demote", GangIdentifier, SelectedPlayer[3]})
                            elseif GangName == "No" then
                                Notify("~r~" ..SelectedPlayer[1].. " was not Demoted.")
                            else
                                Notify("~r~Invalid string")
                            end
                        end
                    else
                        DrawRect(0.6025, 0.680, 0.075, 0.047, 0, 0, 0, 150)
                    end

                    DrawAdvancedText(0.5975, 0.740, 0.005, 0.0028, 0.26, "Kick", 255, 255, 255, 255, 7 , 0)
                    if isCursorInPosition(0.5025, 0.730, 0.075, 0.047) then
                        DrawRect(0.5025, 0.730, 0.075, 0.047, 255, 255, 255, 150)
                        if IsDisabledControlJustPressed(0, 92) then
                            local GangName = KeyboardInput("Are you sure", "Yes | No", 10)
                            if GangName == "" or GangName == " " or GangName == nil then 
                                Notify("~r~Invalid string")
                            elseif GangName == "Yes" then
                                HVCModule.ModifyGangRanks({"Kick", GangIdentifier, SelectedPlayer[3]})
                            elseif GangName == "No" then
                                Notify("~r~" ..SelectedPlayer[1].. " was not kicked.")
                            else
                                Notify("~r~Invalid string")
                            end
                        end
                    else
                        DrawRect(0.5025, 0.730, 0.075, 0.047, 0, 0, 0, 150)
                    end

                    DrawAdvancedText(0.6975, 0.740, 0.005, 0.0028, 0.26, "Invite", 255, 255, 255, 255, 7 , 0)
                    if isCursorInPosition(0.6025, 0.730, 0.075, 0.047) then
                        DrawRect(0.6025, 0.730, 0.075, 0.047, 255, 255, 255, 150)
                        if IsDisabledControlJustPressed(0, 92) then
                            local PlayerID = KeyboardInput("Enter Player ID to invite", "", 10)
                            if PlayerID == "" or PlayerID == " " or PlayerID == nil then 
                                Notify("~r~Invalid string")
                            else
                                HVCModule.InvitePlayerWithPermID({GangIdentifier, PlayerID})
                            end
                        end
                    else
                        DrawRect(0.6025, 0.730, 0.075, 0.047, 0, 0, 0, 150)
                    end

                elseif CurrentPage == "Turfs" then
                    DrawAdvancedText(0.6425, 0.4215, 0.005, 0.0028, 0.26, "COMING SOON...", 255, 0, 0, 255, 7, 0)
                elseif CurrentPage == "Settings" then

                    DrawAdvancedText(0.5975, 0.690, 0.005, 0.0028, 0.26, "Disband", 255, 255, 255, 255, 7 , 0)
                    if isCursorInPosition(0.5025, 0.680, 0.075, 0.047) then
                        DrawRect(0.5025, 0.680, 0.075, 0.047, 255, 255, 255, 150)
                        if IsDisabledControlJustPressed(0, 92) then
                            local Check = KeyboardInput("Are you sure", "Yes | No", 10)
                            if Check == "" or Check == " " or Check == nil then 
                                Notify("~r~Invalid string")
                            elseif Check == "Yes" then
                                HVCModule.DisbandGang({GangIdentifier})
                            elseif Check == "No" then
                                Notify("~r~" ..GangIdentifier.. " was not disbanded.")
                            else
                                Notify("~r~Invalid string")
                            end
                        end
                    else
                        DrawRect(0.5025, 0.680, 0.075, 0.047, 0, 0, 0, 150)
                    end

                    DrawAdvancedText(0.6975, 0.690, 0.005, 0.0028, 0.26, "Leave", 255, 255, 255, 255, 7 , 0)
                    if isCursorInPosition(0.6025, 0.680, 0.075, 0.047) then
                        DrawRect(0.6025, 0.680, 0.075, 0.047, 255, 255, 255, 150)
                        if IsDisabledControlJustPressed(0, 92) then
                            local Check = KeyboardInput("Are you sure", "Yes | No", 10)
                            if Check == "" or Check == " " or Check == nil then 
                                Notify("~r~Invalid string")
                            elseif Check == "Yes" then
                                HVCModule.LeaveGang({GangIdentifier})
                            elseif Check == "No" then
                                Notify("~r~You did not leave" ..GangIdentifier)
                            else
                                Notify("~r~Invalid String")
                            end
                        end
                    else
                        DrawRect(0.6025, 0.680, 0.075, 0.047, 0, 0, 0, 150)
                    end

                    DrawAdvancedText(0.5975, 0.740, 0.005, 0.0028, 0.16, "Transfer Ownership", 255, 255, 255, 255, 7 , 0)
                    if isCursorInPosition(0.5025, 0.730, 0.075, 0.047) then
                        DrawRect(0.5025, 0.730, 0.075, 0.047, 255, 255, 255, 150)
                        if IsDisabledControlJustPressed(0, 92) then
                            local PermID = KeyboardInput("Enter PermID to transfer ownership (Player must be online!)", "", 10)
                            if PermID == "" or PermID == " " or PermID == nil or tonumber(PermID) < 0 then 
                                Notify("~r~Invalid PermID!")
                            else
                                local Check = KeyboardInput("Are you sure", "Yes | No", 10)
                                if Check == "" or Check == " " or Check == nil then 
                                    Notify("~r~Invalid string")
                                elseif Check == "Yes" then
                                    HVCModule.TransferGangOwnership({GangIdentifier, PermID})
                                elseif Check == "No" then
                                    Notify("~r~" ..SelectedPlayer[1].. " was not kicked.")
                                else
                                    Notify("~r~Invalid string")
                                end
                            end
                        end
                    else
                        DrawRect(0.5025, 0.730, 0.075, 0.047, 0, 0, 0, 150)
                    end

                    DrawAdvancedText(0.6975, 0.740, 0.005, 0.0028, 0.26, "Clear Gang", 255, 255, 255, 255, 7, 0)
                    if isCursorInPosition(0.6025, 0.730, 0.075, 0.047) then
                        DrawRect(0.6025, 0.730, 0.075, 0.047, 255, 255, 255, 150)
                        if IsDisabledControlJustPressed(0, 92) then
                            local Check = KeyboardInput("Are you sure, this will kick all members out except you.", "Yes | No", 10)
                            if Check == "" or Check == " " or Check == nil then 
                                Notify("~r~Invalid string")
                            elseif Check == "Yes" then
                                HVCModule.ClearGang({GangIdentifier})
                            elseif Check == "No" then
                                Notify("~r~" ..GangIdentifier.. " was not cleared.")
                            else
                                Notify("~r~Invalid string")
                            end
                        end
                    else
                        DrawRect(0.6025, 0.730, 0.075, 0.047, 0, 0, 0, 150)
                    end


                elseif CurrentPage == "GangLogs" then
                    DrawAdvancedText(0.6425, 0.4215, 0.005, 0.0028, 0.26, "COMING SOON...", 255, 0, 0, 255, 7, 0)
                end
            end
        end
        Wait(0)
    end
end)








function ReturnGang(Gang, Name, Funds, Members)
    IsInGang = Gang
    if Gang then
        GangIdentifier = Name
        GangFunds = Funds
        GangInfo = json.decode(Members)
    end
end

function ReturnInvites(Invites)
    InviteList = Invites
end

function UpdateGangInfoByType(Type, Updated)
    --print(Type)
    if Type == "Funds" then
        GangFunds = tonumber(Updated)
    elseif Type == "Members" then
        GangInfo = Updated
    end
end

function LeftGang()
    IsInGang = false;
    SelectedGang = nil;
    CurrentPage = "Main";
    GangIdentifier = "N/A";
    GangFunds = 0;
    SelectedPlayer = {}
    InviteList = {}
    GangInfo = {}
end

function DrawAdvancedText(i, j, k, l, m, n, o, p, q, r, s, t)
    SetTextFont(s)
    SetTextProportional(0)
    SetTextScale(m, m)
    N_0x4e096588b13ffeca(t)
    SetTextColour(o, p, q, r)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(n)
    DrawText(i - 0.1 + k, j - 0.02 + l)
end

function GetCursor() 
    local sx, sy = GetActiveScreenResolution()
    local cx, cy = GetNuiCursorPosition ( )
    local cx, cy = (cx / sx), (cy / sy)
    return cx, cy
end

function isCursorInPosition(x,y,width,height)
    local sx, sy = GetActiveScreenResolution()
    local cx, cy = GetNuiCursorPosition ( )
    local cx, cy = (cx / sx), (cy / sy)
 
        local width = width / 2
        local height = height / 2
 
    if (cx >= (x - width) and cx <= (x + width)) and (cy >= (y - height) and cy <= (y + height)) then
        return true
    else
        return false
    end
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_MPM_NA', TextEntry) 
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true 
    
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() 
		Citizen.Wait(500) 
		blockinput = false 
		return result 
	else
		Citizen.Wait(500)
		blockinput = false 
		return nil 
	end
end