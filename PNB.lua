if OwnerValidity == true and Owner == "FrendyGT" then
    storage = string.upper(WorldBlock)
    storageid = string.upper(WorldBlockID)
    pnbdunya = string.upper(WorldPnb)
    pnddunyaid = string.upper(WorldPnbID)
    StorageSeed = string.upper(WorldSeed)
    StorageSeedID = string.upper(WorldSeedID)
    PackDropWorld = string.upper(PackDropWorld)
    PackDropWorldID = string.upper(PackDropWorldID)

    Botad = bot.name
    kirilan = 0
    if UseGaut == "Use" then
        bot.auto_collect = false
    end

    function AnlikYer()
        Dunyadami = tostring(world.name)
        if Dunyadami ~= "" and Dunyadami ~= "EXIT" then
            localbot = world:getLocal()
            if localbot then
                Botx = math.floor(localbot.posx / 32) 
                Boty = math.floor(localbot.posy / 32)
            end
        end
    end

    function join(a,b) 
        sleep(DelayJoinWorld)
        bot:warp(a,b)
        sleep(DelayJoinWorld)
        AnlikYer()
        Dunyadami = tostring(world.name)
        if Dunyadami ~= "" and Dunyadami ~= "EXIT" then
            if world:getTile(Botx,Boty).fg == 6 then
                join(a,b)
            end
        end
    end

    function takeP()
        for _, obj in pairs(world:getObjects()) do
        if obj.id == 98 then
            xp = math.floor(obj.x / 32)
            yp = math.floor(obj.y / 32)
            bot:findPath(xp,yp)
            sleep(1000)
            bot.auto_collect = true
            bot.collect_range = 1 
            sleep(500)
            bot.auto_collect = false
            if inventory:getItemCount(98) > 0 then
            break
            end
        end
        end
    end

    function dropPick()
        bot:sendPacket(2, "action|drop\n|itemID|" .. 98)
        bot:sendPacket(2, "action|dialog_return\ndialog_name|drop_item\nitemID|" .. 98 .. "|\ncount|" .. inventory:getItemCount(98) - 1)
        sleep(1000)
    end

    function cekpik()
        if Pick == "Yes" and inventory:getItemCount(98) > 1 then
            join(PickWorld,PickWorldID)
            dropPick()
            sleep(1000)
        end
    end

    cekpik()

    function PickaxeControl()
        if Pick == "Yes" and inventory:getItemCount(98) == 0 then
            join(PickWorld,PickWorldID)
            sleep(500)
            takeP()
            sleep(3000)
            if inventory:getItemCount(98) > 0 then
                bot:wear(98)
                sleep(2000)
                dropPick()
                sleep(1000)
                if inventory:getItemCount(98) > 1 then
                    join(PickWorld,PickaxeWorldID)
                    dropPick()
                    sleep(1000)
                end
            else
                while inventory:getItemCount(98) == 0 do
                    sleep(5000)
                    join(PickWorld,PickWorldID)
                    sleep(500)
                    takeP()
                    sleep(3000)
                    if inventory:getItemCount(98) > 0 then
                        bot:wear(98)
                        sleep(2000)
                        dropPick()
                        sleep(1000)
                        if inventory:getItemCount(98) > 1 then
                            join(PickWorld,PickWorldID)
                            dropPick()
                            sleep(1000)
                            cekpik()
                        end
                    end
                end
            end
        end
        if inventory:getItemCount(98) > 1 then
            join(PickaxeWorld,PickaxeWorldID)
            dropPick()
            sleep(1000)
        end
    end

    PickaxeControl()

    function take() 
        ReconnectTakeBlock()
        for _,obj in pairs(world:getObjects()) do
        if obj.id == BlockID then 
                ReconnectTakeBlock()
                AnlikYer()
                if world:getTile(Botx,Boty).fg == 6 then
                    join(storage,storageid)
                end
                local x = math.floor(obj.x / 32)
                local y = math.floor(obj.y / 32)
                bot:findPath(x,y)
                bot.auto_collect = true
                sleep(1000) 
            end
            if inventory:getItemCount(BlockID) > 1 then
                bot.auto_collect = false
                break
            end
        end
    end
    itemler = 0
    function tarama()
        itemler = 0
        for _, obj in pairs(world:getObjects()) do
            if obj.id == BlockID then 
                itemler = itemler + obj.count
            end
        end
        return itemler
    end

    function TrashTheJunks()
        for i, trash in ipairs(trashList) do
            if inventory:getItemCount(trash) > WhenTrashCount then
                bot:trash(trash, inventory:getItemCount(trash))
                sleep(1000)
            end
        end
    end

    join(storage,storageid)
    sleep(1000)
    tarama()
    while itemler == 0 do
        join(storage,storageid)
        tarama()
        sleep(2000)
    end
    sleep(1000)
    Kalanlar = itemler

    function OnlineControl()
        if bot.status ~= 1 then
            while bot.status ~= 1 do
                bot:connect()
                sleep(10000)
            end
        end
    end
            
    function tilealfg(x,y)
        OnlineControl()
        AnlikYer()
        Dunyadami = tostring(world.name)
        if Dunyadami ~= "" and Dunyadami ~= "EXIT" then
            tilefgx = world:getTile(x,y).fg
            return {tilefg = tilefgx}
        end
    end

    function tilealbg(x,y)
        OnlineControl()
        AnlikYer()
        Dunyadami = tostring(world.name)
        if Dunyadami ~= "" and Dunyadami ~= "EXIT" then
            tilebgx = world:getTile(x,y).bg
            return {tilebg = tilebgx}
        end
    end

    function pnbatas()
        if (tilealfg(Botx,Boty-2).tilefg ~= 0 or tilealbg(Botx,Boty-2).tilebg ~= 0) then
            Reconnect()
            AnlikYer()
            bot:hit(Botx,Boty-2) 
            sleep(Delay)
        elseif tilealfg(Botx,Boty-2).tilefg == 0 then
            AnlikYer()
            bot:place(Botx,Boty-2,BlockID)
            sleep(Delay)
        end
    end

    function pnbbawah()
        if (tilealfg(Botx,Boty+2).tilefg ~= 0 or tilealbg(Botx,Boty+2).tilebg ~= 0) then
            Reconnect()
            AnlikYer()
            bot:hit(Botx,Boty+2) 
            sleep(Delay)
        elseif tilealfg(Botx,Boty+2).tilefg == 0 then
            AnlikYer()
            bot:place(Botx,Boty+2,BlockID)
            sleep(Delay)
        end
    end

    function anjay(a)
        for _, obj in pairs(getTiles()) do
            if obj.bg == a or obj.fg == a then
                xx = math.floor(obj.x+1 / 32)
                yy = math.floor(obj.y+1 / 32)
                break
            end
        end
        for _, bots in pairs(getBots()) do
            if bot.name:upper() == bot.name:upper() then
            bots:findPath(xx,yy)
        end
        xx = xx+1
        yy = yy
        sleep(500)
        end
    end

    function PNB()
        if UseGaut == "No" then
            bot.auto_collect = true
        else
            bot.auto_collect = false
        end
        AnlikYer()
        bot:setSkin(math.random(1, 6))
        while inventory:getItemCount(BlockID) > 0 do
            Reconnect()
            if TileBreak == "Multi" then
                pnbatas()
                pnbbawah()
            end
            if TileBreak == "Up" then 
                pnbatas()
            elseif TileBreak == "Down" then 
                pnbbawah()
            end
        end
        kirilan = kirilan + 200
        Kalanlar = Kalanlar - 200
        Reconnect()
        if kirilan == 200 and UseGaut == "Use" then 
            if Retrieve == "Use" then
                Reconnect()
                for _, titid in pairs(world:getTiles()) do
                    if titid.fg == 6946 then
                    Reconnect()
                    bot:findPath(titid.x, titid.y - 1)
                    sleep(1000)
                end
            end
            sleep(1000)
            AnlikYer()
            bot:retrieve(Botx,Boty+1)
            for _, kisik in pairs(world:getTiles()) do
                if kisik.fg == 6948 then
                    Reconnect()
                    bot:findPath(kisik.x, kisik.y - 1)
                    sleep(500)
                end
            end
            sleep(1000)
            AnlikYer()
            bot:retrieve(Botx,Boty+1)
            sleep(500)
            kirilan = 0
            end
        end
    end

    function DropF()
        bot.auto_collect = false
        while UseGaut == "No" and bot.gem_count > pricepack and BuyPack == "Buy" do
            Reconnectpkt()
            bot:sendPacket(2, "action|buy\nitem|"..packname)
            sleep(3000) -- you can change delay
        end
        if inventory:getItemCount(SeedID) > 0 then
            join(StorageSeed,StorageSeedID)
            Reconnect()
            while (inventory:getItemCount(SeedID) > 0) do
                if world.name ~= StorageSeed then
                    join(StorageSeed,StorageSeedID)
                end
                Reconnect()
                AnlikYer()
                bot:moveLeft()
                sleep(1000)
                bot:drop(SeedID,inventory:getItemCount(SeedID))
                sleep(500)
                bot:moveLeft()
            end  
        end
        if inventory:getItemCount(packID) > packDropCount then
            join(PackDropWorld,PackDropWorldID)
            Reconnect()
            while inventory:getItemCount(packID) > packDropCount do
                if world.name ~= PackDropWorld then
                    join(PackDropWorld,PackDropWorldID)
                end
                Reconnect()
                AnlikYer()
                bot:moveLeft()
                sleep(1000)
                bot:drop(packID,inventory:getItemCount(packID))
                sleep(500)
                bot:moveLeft()
            end
        end
    end

    function Reconnectpkt()
        if bot.status ~= 1 then       
            while bot.status ~= 1 do
                bot:connect()
                sleep(10000)
            end
            join(pnbdunya,pnddunyaid)
        end
    end

    function ReconnectTakeBlock()
        if bot.status ~= 1 then
            while bot.status ~= 1 do
                bot:connect()
                sleep(10000)
            end
            join(storage,storageid)
        end
        Dunyadami = tostring(world.name)
        if Dunyadami ~= "" and Dunyadami ~= "EXIT" then
            AnlikYer()
            if world:getTile(Botx,Boty).fg == 6 then
                join(storage,storageid)
            end
        end
    end

    function Reconnect()
        if bot.status ~= 1 then 
            while bot.status ~= 1 do
                bot:connect()
                sleep(10000)
            end
            join(pnbdunya,pnddunyaid)
        end
        Dunyadami = tostring(world.name)
        if Dunyadami ~= "" and Dunyadami ~= "EXIT" then
            AnlikYer()
            if world:getTile(Botx,Boty).fg == 6 then
                join(pnbdunya,pnddunyaid)
            end
        end
    end

    isOwner = true

    while Kalanlar > 1 and isOwner == true do 
        Reconnect()
        cekpik()
        DropF()
        if inventory:getItemCount(BlockID) == 0 then
            join(storage,storageid)
            take()
        end
        if inventory:getItemCount(BlockID) > 0 then
            join(pnbdunya,pnddunyaid)
            anjay(Patokan)
            PNB()
        end
        DropF()
        TrashTheJunks()
    end

    if isOwner == true then
        bot.auto_collect = false
        join(storage,storageid)
        bot:drop(SeedID,inventory:getItemCount(SeedID))
        sleep(500)
        bot:drop(packID,inventory:getItemCount(packID))
        sleep(500)
        bot:leaveWorld()
    end
end

