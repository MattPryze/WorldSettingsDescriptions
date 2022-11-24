WorldSettingsDescriptions = {
    styler = {
        type = EXTENSION_TYPE.NBT_EDITOR_STYLE
    }
}

function WorldSettingsDescriptions.styler:main(root, context)
    if((context.type & FILE_TYPE.LEVEL) ~= 0) then

        if(context.edition == EDITION.JAVA) then
            WorldSettingsDescriptions.styler:Java(root)
        elseif(context.edition == EDITION.BEDROCK) then
            WorldSettingsDescriptions.styler:Bedrock(root)
        elseif(context.edition == EDITION.CONSOLE) then
            WorldSettingsDescriptions.styler:Console(root)
        end
    end
end

function WorldSettingsDescriptions.styler:Java(root)

    if(root:contains("Data", TYPE.COMPOUND)) then
        local dataTag = root.lastFound

        if(dataTag:contains("GameType", TYPE.INT)) then
            local gameType = dataTag.lastFound

            if(gameType.value == 0) then
                Style:setLabel(gameType, "Survival")
                Style:setLabelColor(gameType, "lime")
            elseif(gameType.value == 1) then
                Style:setLabel(gameType, "Creative")
                Style:setLabelColor(gameType, "gold")
            elseif(gameType.value == 2) then
                Style:setLabel(gameType, "Adventure")
                Style:setLabelColor(gameType, "cyan")
            elseif(gameType.value == 3) then
                Style:setLabel(gameType, "Spectator")
                Style:setLabelColor(gameType, "white")
            end
        end

        if(dataTag:contains("Difficulty", TYPE.BYTE)) then
            local difficulty = dataTag.lastFound

            if(difficulty.value == 0) then
                Style:setLabel(difficulty, "Peaceful")
                Style:setLabelColor(difficulty, "cyan")
            elseif(difficulty.value == 1) then
                Style:setLabel(difficulty, "Easy")
                Style:setLabelColor(difficulty, "lime")
            elseif(difficulty.value == 2) then
                Style:setLabel(difficulty, "Normal")
                Style:setLabelColor(difficulty, "gold")
            elseif(difficulty.value == 3) then
                Style:setLabel(difficulty, "Hard")
                Style:setLabelColor(difficulty, "red")
            end
        end

        if(dataTag:contains("LastPlayed", TYPE.LONG)) then
            local lastPlayed = dataTag.lastFound

            Style:setLabel(lastPlayed, os.date("!%B %d, %Y, %I:%M%p",lastPlayed.value//1000))
            Style:setLabelColor(lastPlayed, "#56616f")
        end

        if(dataTag:contains("Time", TYPE.LONG)) then
            local time = dataTag.lastFound

            if(time.value >= 0) then
                local timeString = ""

                local secs = time.value//20
                local mins = secs//60
                local hours = mins//60
                local days = hours//24
    
                if(days > 0) then timeString = timeString .. tostring(days) .. " days, " end
                if(hours > 0) then timeString = timeString .. tostring(hours%24) .. " hours, " end
                if(mins > 0) then timeString = timeString .. tostring(mins%60) .. " minutes, " end
                if(secs > 0) then timeString = timeString .. tostring(secs%60) .. " seconds" end
    
                Style:setLabel(time, timeString)
                Style:setLabelColor(time, "#56616f")
            end
        end

        if(dataTag:contains("DayTime", TYPE.LONG)) then
            local dayTime = dataTag.lastFound

            if(dayTime.value >= 0) then
                local actualDayTime = dayTime.value%24000
                local realHour = (actualDayTime//1000)+6
                local ampm = "AM"

                if(realHour >= 24) then
                    realHour = realHour -24
                end

                if(realHour >= 12) then
                    ampm = "PM"
                    realHour = realHour -12
                end

                if(realHour == 0) then
                    realHour = 12
                end

                if(actualDayTime > 3000 and actualDayTime <=9000) then
                    Style:setLabel(dayTime, "Noon " .. tostring(realHour) .. ampm)
                elseif(actualDayTime > 9000 and actualDayTime <=15000) then
                    Style:setLabel(dayTime, "Sunset " .. tostring(realHour) .. ampm)
                elseif(actualDayTime > 15000 and actualDayTime <=21000) then
                    Style:setLabel(dayTime, "Midnight " .. tostring(realHour) .. ampm)
                elseif(actualDayTime > 21000 or actualDayTime <=3000) then
                    Style:setLabel(dayTime, "Sunrise " .. tostring(realHour) .. ampm) 
                end
                Style:setLabelColor(dayTime, "#56616f")
            end
        end

        if(dataTag:contains("rainTime", TYPE.INT)) then
            local rainTime = dataTag.lastFound

            if(rainTime.value >= 20) then
                local rainTimeString = "Rain stops in "

                if(dataTag:contains("raining", TYPE.BYTE)) then
                    if(dataTag.lastFound.value == 0) then
                        rainTimeString = "Rain starts in "
                    end
                end
    
                local secs = rainTime.value//20
                local mins = secs//60
                local hours = mins//60
                local days = hours//24

                if(days > 0) then rainTimeString = rainTimeString .. tostring(days) .. " days, " end
                if(hours > 0) then rainTimeString = rainTimeString .. tostring(hours%24) .. " hours, " end
                if(mins > 0) then rainTimeString = rainTimeString .. tostring(mins%60) .. " minutes, " end
                if(secs > 0) then rainTimeString = rainTimeString .. tostring(secs%60) .. " seconds" end
    
                Style:setLabel(rainTime, rainTimeString)
                Style:setLabelColor(rainTime, "#56616f")
            end
        end

        if(dataTag:contains("thunderTime", TYPE.INT)) then
            local thunderTime = dataTag.lastFound

            if(thunderTime.value >= 20) then
                local thunderTimeString = "Thunder stops in "

                if(dataTag:contains("thundering", TYPE.BYTE)) then
                    if(dataTag.lastFound.value == 0) then
                        thunderTimeString = "Thunder starts in "
                    end
                end

                local secs = thunderTime.value//20
                local mins = secs//60
                local hours = mins//60
                local days = hours//24

                if(days > 0) then thunderTimeString = thunderTimeString .. tostring(days) .. " days, " end
                if(hours > 0) then thunderTimeString = thunderTimeString .. tostring(hours%24) .. " hours, " end
                if(mins > 0) then thunderTimeString = thunderTimeString .. tostring(mins%60) .. " minutes, " end
                if(secs > 0) then thunderTimeString = thunderTimeString .. tostring(secs%60) .. " seconds" end

                Style:setLabel(thunderTime, thunderTimeString)
                Style:setLabelColor(thunderTime, "#56616f")
            end
        end
    end
end

function WorldSettingsDescriptions.styler:Bedrock(root)
    
    if(root:contains("GameType", TYPE.INT)) then
        local gameType = root.lastFound

        if(gameType.value == 0) then
            Style:setLabel(gameType, "Survival")
            Style:setLabelColor(gameType, "lime")
        elseif(gameType.value == 1) then
            Style:setLabel(gameType, "Creative")
            Style:setLabelColor(gameType, "gold")
        elseif(gameType.value == 2) then
            Style:setLabel(gameType, "Adventure")
            Style:setLabelColor(gameType, "cyan")
        end
    end

    if(root:contains("Difficulty", TYPE.INT)) then
        local difficulty = root.lastFound

        if(difficulty.value == 0) then
            Style:setLabel(difficulty, "Peaceful")
            Style:setLabelColor(difficulty, "cyan")
        elseif(difficulty.value == 1) then
            Style:setLabel(difficulty, "Easy")
            Style:setLabelColor(difficulty, "lime")
        elseif(difficulty.value == 2) then
            Style:setLabel(difficulty, "Normal")
            Style:setLabelColor(difficulty, "gold")
        elseif(difficulty.value == 3) then
            Style:setLabel(difficulty, "Hard")
            Style:setLabelColor(difficulty, "red")
        end
    end

    if(root:contains("LastPlayed", TYPE.LONG)) then
        local lastPlayed = root.lastFound

        Style:setLabel(lastPlayed, os.date("!%B %d, %Y, %I:%M%p",lastPlayed.value))
        Style:setLabelColor(lastPlayed, "#56616f")
    end

    if(root:contains("currentTick", TYPE.LONG)) then
        local currentTick = root.lastFound

        local currentTickString = ""

        local secs = currentTick.value//20
        local mins = secs//60
        local hours = mins//60
        local days = hours//24

        if(days > 0) then currentTickString = currentTickString .. tostring(days) .. " days, " end
        if(hours > 0) then currentTickString = currentTickString .. tostring(hours%24) .. " hours, " end
        if(mins > 0) then currentTickString = currentTickString .. tostring(mins%60) .. " minutes, " end
        if(secs > 0) then currentTickString = currentTickString .. tostring(secs%60) .. " seconds" end

        Style:setLabel(currentTick, currentTickString)
        Style:setLabelColor(currentTick, "#56616f")
    end

    if(root:contains("rainTime", TYPE.INT)) then
        local rainTime = root.lastFound

        local rainTimeString = "Rain toggles in "

        local secs = rainTime.value//20
        local mins = secs//60
        local hours = mins//60
        local days = hours//24

        if(days > 0) then rainTimeString = rainTimeString .. tostring(days) .. " days, " end
        if(hours > 0) then rainTimeString = rainTimeString .. tostring(hours%24) .. " hours, " end
        if(mins > 0) then rainTimeString = rainTimeString .. tostring(mins%60) .. " minutes, " end
        if(secs > 0) then rainTimeString = rainTimeString .. tostring(secs%60) .. " seconds" end

        Style:setLabel(rainTime, rainTimeString)
        Style:setLabelColor(rainTime, "#56616f")
    end
    
    if(root:contains("Generator", TYPE.INT)) then
        local generator = root.lastFound

        if(generator.value == 0) then Style:setLabel(generator, "Old") end
        if(generator.value == 1) then Style:setLabel(generator, "Infinite") end
        if(generator.value == 2) then Style:setLabel(generator, "Flat") end
    end

    -- INCOMPLETE / INCORRECT
    if(root:contains("Time", TYPE.LONG)) then 
        local time = root.lastFound

        local actualTime = time.value%14400
        local realHour = (actualTime//600)+12 -- +12? idk
        local ampm = "AM"

        if(realHour >= 24) then
            realHour = realHour -24
        end

        if(realHour >= 12) then
            ampm = "PM"
            realHour = realHour -12
        end

        if(realHour == 0) then
            realHour = 12
        end

        if(actualTime > 3000 and actualTime <=9000) then
            Style:setLabel(time, "Noon " .. tostring(realHour) .. ampm)
        elseif(actualTime > 9000 and actualTime <=15000) then
            Style:setLabel(time, "Sunset " .. tostring(realHour) .. ampm)
        elseif(actualTime > 15000 and actualTime <=21000) then
            Style:setLabel(time, "Midnight " .. tostring(realHour) .. ampm)
        elseif(actualTime > 21000 or actualTime <=3000) then
            Style:setLabel(time, "Sunrise " .. tostring(realHour) .. ampm) 
        end
        Style:setLabelColor(time, "#56616f")
    end
end

function WorldSettingsDescriptions.styler:Console(root)
    
    if(root:contains("Data", TYPE.COMPOUND)) then
        local dataTag = root.lastFound

        if(dataTag:contains("GameType", TYPE.INT)) then
            local gameType = dataTag.lastFound

            if(gameType.value == 0) then
                Style:setLabel(gameType, "Survival")
                Style:setLabelColor(gameType, "lime")
            elseif(gameType.value == 1) then
                Style:setLabel(gameType, "Creative")
                Style:setLabelColor(gameType, "gold")
            elseif(gameType.value == 2) then
                Style:setLabel(gameType, "Adventure")
                Style:setLabelColor(gameType, "cyan")
            end
        end

        if(dataTag:contains("Difficulty", TYPE.BYTE)) then
            local difficulty = dataTag.lastFound

            if(difficulty.value == 0) then
                Style:setLabel(difficulty, "Peaceful")
                Style:setLabelColor(difficulty, "cyan")
            elseif(difficulty.value == 1) then
                Style:setLabel(difficulty, "Easy")
                Style:setLabelColor(difficulty, "lime")
            elseif(difficulty.value == 2) then
                Style:setLabel(difficulty, "Normal")
                Style:setLabelColor(difficulty, "gold")
            elseif(difficulty.value == 3) then
                Style:setLabel(difficulty, "Hard")
                Style:setLabelColor(difficulty, "red")
            end
        end

        if(dataTag:contains("Time", TYPE.LONG)) then
            local time = dataTag.lastFound

            if(time.value >= 0) then
                local timeString = ""

                local secs = time.value//20
                local mins = secs//60
                local hours = mins//60
                local days = hours//24
    
                if(days > 0) then timeString = timeString .. tostring(days) .. " days, " end
                if(hours > 0) then timeString = timeString .. tostring(hours%24) .. " hours, " end
                if(mins > 0) then timeString = timeString .. tostring(mins%60) .. " minutes, " end
                if(secs > 0) then timeString = timeString .. tostring(secs%60) .. " seconds" end
    
                Style:setLabel(time, timeString)
                Style:setLabelColor(time, "#56616f")
            end
        end

        if(dataTag:contains("DayTime", TYPE.LONG)) then
            local dayTime = dataTag.lastFound

            if(dayTime.value >= 0) then
                local actualDayTime = dayTime.value%24000
                local realHour = (actualDayTime//1000)+6
                local ampm = "AM"

                if(realHour >= 24) then
                    realHour = realHour -24
                end

                if(realHour >= 12) then
                    ampm = "PM"
                    realHour = realHour -12
                end

                if(realHour == 0) then
                    realHour = 12
                end

                if(actualDayTime > 3000 and actualDayTime <=9000) then
                    Style:setLabel(dayTime, "Noon " .. tostring(realHour) .. ampm)
                elseif(actualDayTime > 9000 and actualDayTime <=15000) then
                    Style:setLabel(dayTime, "Sunset " .. tostring(realHour) .. ampm)
                elseif(actualDayTime > 15000 and actualDayTime <=21000) then
                    Style:setLabel(dayTime, "Midnight " .. tostring(realHour) .. ampm)
                elseif(actualDayTime > 21000 or actualDayTime <=3000) then
                    Style:setLabel(dayTime, "Sunrise " .. tostring(realHour) .. ampm) 
                end
                Style:setLabelColor(dayTime, "#56616f")
            end
        end

        if(dataTag:contains("rainTime", TYPE.INT)) then
            local rainTime = dataTag.lastFound

            if(rainTime.value >= 20) then
                local rainTimeString = "Rain stops in "

                if(dataTag:contains("raining", TYPE.BYTE)) then
                    if(dataTag.lastFound.value == 0) then
                        rainTimeString = "Rain starts in "
                    end
                end
    
                local secs = rainTime.value//20
                local mins = secs//60
                local hours = mins//60
                local days = hours//24

                if(days > 0) then rainTimeString = rainTimeString .. tostring(days) .. " days, " end
                if(hours > 0) then rainTimeString = rainTimeString .. tostring(hours%24) .. " hours, " end
                if(mins > 0) then rainTimeString = rainTimeString .. tostring(mins%60) .. " minutes, " end
                if(secs > 0) then rainTimeString = rainTimeString .. tostring(secs%60) .. " seconds" end
    
                Style:setLabel(rainTime, rainTimeString)
                Style:setLabelColor(rainTime, "#56616f")
            end
        end

        if(dataTag:contains("thunderTime", TYPE.INT)) then
            local thunderTime = dataTag.lastFound

            if(thunderTime.value >= 20) then
                local thunderTimeString = "Thunder stops in "

                if(dataTag:contains("thundering", TYPE.BYTE)) then
                    if(dataTag.lastFound.value == 0) then
                        thunderTimeString = "Thunder starts in "
                    end
                end

                local secs = thunderTime.value//20
                local mins = secs//60
                local hours = mins//60
                local days = hours//24

                if(days > 0) then thunderTimeString = thunderTimeString .. tostring(days) .. " days, " end
                if(hours > 0) then thunderTimeString = thunderTimeString .. tostring(hours%24) .. " hours, " end
                if(mins > 0) then thunderTimeString = thunderTimeString .. tostring(mins%60) .. " minutes, " end
                if(secs > 0) then thunderTimeString = thunderTimeString .. tostring(secs%60) .. " seconds" end

                Style:setLabel(thunderTime, thunderTimeString)
                Style:setLabelColor(thunderTime, "#56616f")
            end
        end

        if(dataTag:contains("SizeOnDisk", TYPE.LONG)) then
            local sizeOnDisk = dataTag.lastFound

            local MB = sizeOnDisk.value/1000000
            local roundMB = math.floor(MB * 100 + 0.5)/100

            Style:setLabel(sizeOnDisk, tostring(roundMB) .. "MB")
            Style:setLabelColor(sizeOnDisk, "#56616f")
        end

        -- MISSING ENTRIES
        if(dataTag:contains("generatorVersion", TYPE.INT)) then
            local generatorVersion = dataTag.lastFound

            if(generatorVersion.value == 0) then
                Style:setLabel(generatorVersion, "Flat")
                Style:setLabelColor(generatorVersion, "#56616f")
            elseif(generatorVersion.value == 1) then
                Style:setLabel(generatorVersion, "Normal")
                Style:setLabelColor(generatorVersion, "#56616f")
            end
        end
    end
end

return WorldSettingsDescriptions
