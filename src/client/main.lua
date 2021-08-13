--[[ TriscuitTravel by Triscuit2311 ]]--
ESX              = nil

--Setup ESX Main Object
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

function MakePed(locX,locY,locZ, heading, model)
    -- Get model for ped
    ESX.Streaming.RequestModel(model)

    -- Create Ped globally
    ped = CreatePed(0, model, locX, locY, locZ, 10.0, false, true)

    --Ensure Ped is visible
    SetEntityAlpha(ped, 255, false)

    -- Make sure ped does not interact or interfere with anything
    SetPedFleeAttributes(ped, 2)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCanRagdollFromPlayerImpact(ped, false)
    SetPedDiesWhenInjured(ped, false)

    -- Freeze ped position and make them invincible
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)

    -- No animations
    SetPedCanPlayAmbientAnims(ped, false)

    -- Setup ped heading
    SetEntityHeading(ped, heading)
end

Citizen.CreateThread(function()

    --  Create Ped at the hub
    MakePed(Config.TeleportBasePos.x, Config.TeleportBasePos.y, Config.TeleportBasePos.z-1.0,Config.TeleportBaseHeading, Config.HubPedModel)

    --Setup teleport option table
    teleportLocationOptions = {}

    --for every location in Config.Locations
    for _,v in pairs(Config.Locations) do

        -- create QTarget option at hub for every location
        table.insert(teleportLocationOptions, {
            event   = "TriscuitTravelTeleport",
            icon    = "fas fa-sign-in-alt",
            label   = Config.CustomText.TravelFromHubOptionPreface..v[5],
            text    = Config.CustomText.TravelFromHubNotificationPreface..v[5],
            locX    = v[1]-1.0,
            locY    = v[2]-1.0,
            locZ    = v[3]+0.5,
            heading = v[4],
        })

        -- create Ped for every location
        MakePed(v[1],v[2],v[3]-1.0, v[4],Config.LocationPedModel)

        -- create QTarget for every location
        exports['qtarget']:AddBoxZone("TeleportFromLoc"..v[5], vec3(v[1],v[2],v[3]), 0.75, 0.75, {
            name        =   "TeleportBaseTarget",
            heading     =   11.0,
            debugPoly   =   false,
            minZ        =   v[3]-1.0,
            maxZ        =   v[3]+1.0,
        }, {
            options = {
                {
                    event   = "TriscuitTravelTeleport",
                    icon    = "fas fa-sign-in-alt",
                    label   = Config.CustomText.ReturnToHubOptionText,
                    text    = Config.CustomText.ReturnToHubNotification,
                    locX    = Config.TeleportBasePos.x-1.0,
                    locY    = Config.TeleportBasePos.y-1.0,
                    locZ    = Config.TeleportBasePos.z+1.0,
                    heading = Config.TeleportBaseHeading,
                },
            },
            distance = Config.TeleportRadius
        })

    end

    -- create QTarget for hub ped
    exports['qtarget']:AddBoxZone("TeleportBaseTarget", Config.TeleportBasePos, 0.75, 0.75, {
        name="TeleportBaseTarget",
        heading=11.0,
        debugPoly=false,
        minZ=Config.TeleportBasePos.z-1.0,
        maxZ=Config.TeleportBasePos.z+1.0,
    }, {
        options = teleportLocationOptions,
        distance = Config.TeleportRadius
    })
end)

AddEventHandler("TriscuitTravelTeleport", function(data)
    Citizen.CreateThread(function()
        -- Show notifications, if enabled
        if Config.ShowNotifications then
            SendNotification(data.text)
        end
        -- Set Player Position and heading
        SetEntityCoords(GetPlayerPed(-1), data.locX,data.locY,data.locZ)
        SetEntityHeading(GetPlayerPed(-1), data.heading)
    end)
end)

-- Requires pNotify
function SendNotification(text)
  TriggerEvent("pNotify:SetQueueMax", "left", 10)
  TriggerEvent("pNotify:SendNotification", 
    {
      text = "<b style='color:white'>"..Config.CustomText.NotificationHeader.."</b><br />   <br /> "..text,
      type = "success",
      timeout = 3000,
      layout = "centerLeft",
      queue = "left",
      sounds = {
      sources = {"notificationSFX.wav"}, 
      volume = 0.2,
      conditions = {"docVisible"} 
    }
  })
end