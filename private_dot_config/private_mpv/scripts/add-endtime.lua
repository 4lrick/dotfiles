return function(find_tc)
    local original, wrapper
    local function patch()
        local el = find_tc()
        if not el then return end
        if el.content == wrapper then return end
        original = el.content
        wrapper = function()
            local text = original()
            if text == "--:--" then return text end
            local remaining = mp.get_property_number("playtime-remaining", 0)
            return text .. " " .. os.date("(%I:%M %p)", os.time() + remaining)
        end
        el.content = wrapper
    end
    mp.add_timeout(0, patch)
    mp.observe_property("playback-time", "number", patch)
end
