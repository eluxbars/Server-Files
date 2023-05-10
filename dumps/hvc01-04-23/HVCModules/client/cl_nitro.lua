local vehicle_model = "bmx"; -- { YOUR SPAWN CODE OF VEHICLE HERE}
local nitro_cooldown = 0;

RegisterCommand("nitro", function()
    local pid = PlayerPedId()
    local modelHash = GetHashKey(vehicle_model)
    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Wait(0)
        end
    end
    TriggerServerEvent("CheckNitro")
end)

RegisterNetEvent("HVC:DisplayImageNotify")
AddEventHandler("HVC:DisplayImageNotify", function(title, text)
    ImageNotify(title, text)
end)

function ImageNotify(title, text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetNotificationBackgroundColor(140)
    SetNotificationMessage("CHAR_WE", "hvcstaff", false, 1, title, "")
    DrawNotification(false, true)
end