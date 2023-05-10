local RateLimit = 0
local ProhibbitedWords = {
    "nigger",
	"nigga",
	"n1993r",
	"bldm",
	"paki",
	"coon",
	"paki",
	"wogchamp",
	"woggers",
	"wog",
	"nigger",
    "faggot",
    "c00n",
    "w0g",
}

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/ooc', 'Speak Out of character in chat')
    TriggerEvent('chat:addSuggestion', '//', 'Speak Out of character in chat')
    TriggerEvent('chat:addSuggestion', '/anon', 'Speak anonymously in twitter')
    TriggerEvent('chat:addSuggestion', '/announce', 'Announce a server wide message')
end)

RegisterCommand('/', function(src, args, raw)
    if #args <= 0 then 
		return 
	end

    local message = table.concat(args, " ")
    for k,msg in pairs(ProhibbitedWords) do
        if (string.find(string.lower(message) or "", string.lower(msg)) or -1) > -1 then
            RateLimit = 3
            ScaleformPost()
            return
        end
    end

    if RateLimit == 0 then
        HVCModule.OOC({args})
        RateLimit = 3
    else
        TriggerEvent('chatMessage', "^1^*HVC", {255, 0, 0}, "^r^3 You are being rate limited.", "twt")
    end
end)

RegisterCommand('ooc', function(src, args, raw)
    if #args <= 0 then 
		return 
	end

    local message = table.concat(args, " ")
    for k,msg in pairs(ProhibbitedWords) do
        if (string.find(string.lower(message) or "", string.lower(msg)) or -1) > -1 then
            RateLimit = 3
            ScaleformPost()
            return
        end
    end

    if RateLimit == 0 then
        HVCModule.OOC({args})
        RateLimit = 3
    else
        TriggerEvent('chatMessage', "^1^*HVC", {255, 0, 0}, "^r^3 You are being rate limited.", "twt")
    end
end)


RegisterCommand('anon', function(src, args, raw)
    if #args <= 0 then 
		return 
	end

    local message = table.concat(args, " ")
    for k,msg in pairs(ProhibbitedWords) do
        if (string.find(string.lower(message) or "", string.lower(msg)) or -1) > -1 then
            RateLimit = 3
            ScaleformPost()
            return
        end
    end

    if RateLimit == 0 then
        HVCModule.twt({"anon", args})
        RateLimit = 3
    else
        TriggerEvent('chatMessage', "^1^*HVC", {255, 0, 0}, "^r^3 You are being rate limited.", "twt")
    end
end)

RegisterCommand('announce', function(src, args, raw)
    if #args <= 0 then 
		return 
	end

    local message = table.concat(args, " ")
    for k,msg in pairs(ProhibbitedWords) do
        if (string.find(string.lower(message) or "", string.lower(msg)) or -1) > -1 then
            RateLimit = 3
            ScaleformPost()
            return
        end
    end

    if RateLimit == 0 then
        HVCModule.Announce({args})
        RateLimit = 3
    else
        TriggerEvent('chatMessage', "^1^*HVC", {255, 0, 0}, "^r^3 You are being rate limited.", "twt")
    end
end)

AddEventHandler('_chat:messageEnteredtwt', function(author, color, message)
    if not message or not author then
        return
    end

    for k,msg in pairs(ProhibbitedWords) do
        if (string.find(string.lower(message) or "", string.lower(msg)) or -1) > -1 then
            RateLimit = 3
            ScaleformPost()
            return
        end
    end

    if not WasEventCanceled() then
        if RateLimit == 0 then
            HVCModule.twt({"twt", message})
            RateLimit = 3
        else
            TriggerEvent('chatMessage', "^1^*HVC", {255, 0, 0}, "^r^3 You are being rate limited.", "twt")
        end
    end
end)


function ScaleformPost()
    Citizen.CreateThread(function()
        local ScaleForm = RequestScaleformMovie("mp_big_message_freemode")
        while not HasScaleformMovieLoaded(ScaleForm) do
            Citizen.Wait(0)
        end
        while HasScaleformMovieLoaded(ScaleForm) do
            Citizen.Wait(0)
            if RateLimit > 0 then
                BeginScaleformMovieMethod(ScaleForm, "SHOW_SHARD_WASTED_MP_MESSAGE")
                PushScaleformMovieFunctionParameterString("~y~Warning")
                PushScaleformMovieFunctionParameterString("~r~Discriminatory language is not prohibited.")
                PushScaleformMovieMethodParameterInt(5)
                EndScaleformMovieMethod()
                DrawScaleformMovieFullscreen(ScaleForm, 255, 255, 255, 255)
            else
                break;
            end
        end
    end)
end


Citizen.CreateThread(function()
    while true do 
        Wait(1000)
        if RateLimit > 0 then 
            RateLimit = RateLimit - 1
        end 
    end
end)
 