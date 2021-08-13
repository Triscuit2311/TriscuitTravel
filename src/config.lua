--[[ TriscuitTravel by Triscuit2311 ]]--

Config = {
    TeleportBasePos     = vector3(-1037.48, -2737.67, 20.16),   -- Location of the travel Hub
    TeleportBaseHeading = 330.0,                                -- Heading for the travel hub (For the pedestrian, and players returning to the hub)
    TeleportRadius      = 3.0,                                  -- How far the player can be from the hub or the location pedestrians to open the travel menu.
    ShowNotifications   = true,                                 -- Show Notifications when traveling to or from the Hub. Requires pNotify.

    HubPedModel         =   's_m_y_airworker',  -- Model for the pedestrian spawned at the Hub
    LocationPedModel    =   's_m_y_airworker',  -- Model for the pedestrians Spawned at each travel location

    -- List of locations availiable from the travel hub
    Locations = {
        -- Name         = {     X Coord,    Y Coord,    Z Coord,    Heading,    "Display Name"      , "UniqueIdentifier"    },
        nurburgring     = {     3670.66,    -6528.32,   2191,     154.03,     "Nürburgring Full"  , "NurburgringFull"     },
        dragstrip       = {     1742.46,    3288.27,    41.19,      139.22,     "The Drag Strip"    , "DragStrip"           },
        driftMountain   = {     2784.58,    4587.81,    549.1,     6.86,        "Touge Peak"        , "TougePeak"           },
    },

    -- Custom text options, for localization or general customization to fit the theme of your server.
    CustomText = {
        TravelFromHubOptionPreface          =   "Fly to "                   ,   -- Shown before each location name in the menu like "Fly to The Drag Strip"
        TravelFromHubNotificationPreface    =   "You've Arrived at "        ,   -- Shown before each location name on the notification.
        ReturnToHubOptionText               =   "Return To Hub"             ,   -- Display text to return to the Travel Hub
        ReturnToHubNotification             =   "Welcome back to the hub."  ,   -- Notification upon returning to the hub
        NotificationHeader                  =   "Triscuit's Teleport Service"   -- Title of the notification pop-up
    }
}