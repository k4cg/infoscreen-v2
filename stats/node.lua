gl.setup(1024, 768)

font = resource.load_font("miso-regular.ttf")
box  = resource.load_image("box.png")

json = require "json"

util.file_watch("power.png", function(content)
    pw_img = resource.load_image("power.png")
end)

util.file_watch("stats.json", function(content)
    stats = json.decode(content)
    last_update = sys.now

    inet = {}
    inet["up"] = stats.internet_up
    inet["down"] = stats.internet_down

    account = stats.account
    members = stats.members
    devices = stats.devices
    door    = stats.door -- GENIUS
    power   = stats.power
    temp    = stats.temperature
end)

function node.render()
    gl.clear(1, 1, 1, 1)
    font:write(50, 40, "Statistiken", 90, 0,0,0,1)

    -- ACHTUNG, KREBS INCOMING

    -- internet
    box:draw(50, 150, 250, 320)
    font:write(85, 160, "Internet", 50, 0,0,0,1)
    font:write(100, 220, "up: " .. string.format("%3d", inet["up"]), 40, 0,0,0,1)
    font:write(80, 260, "down: " .. string.format("%4d", inet["down"]), 40, 0,0,0,1)

    -- members
    box:draw(50 + 230, 150, 250 + 230, 320)
    font:write(85 + 215, 160, "Mitglieder", 50, 0,0,0,1)
    font:write(80 + 270, 220, members, 70, 0,0,0,1)

    -- devices
    box:draw(50 + 460, 150, 500 + 210, 320)
    font:write(85 + 470, 160, "Geräte", 50, 0,0,0,1)
    font:write(80 + 500, 220, devices, 70, 0,0,0,1)
    
    -- power
    box:draw(50 + 690, 150, 750 + 190, 320)
    font:write(85 + 705, 160, "Strom", 50, 0,0,0,1)
    font:write(80 + 700, 220, string.format("%4d", power), 70, 0,0,0,1)
    
    -- temp
    box:draw(50, 120 + 220, 250, 150 + 290 + 80)
    font:write(55, 350, "Temperatur", 50, 0,0,0,1)
    font:write(75, 420, string.format("%.1f°C", temp), 70, 0,0,0,1)

    -- account
    box:draw(50, 350 + 190, 250, 350 + 300 + 80)
    font:write(60, 550, "Kontostand", 50, 0,0,0,1)
    font:write(70, 620, string.format("%4d €", account + 0.5), 70, 0,0,0,1)

     -- power img
    pw_img:draw(50 + 250, 130 + 220, 940, 740)
end
