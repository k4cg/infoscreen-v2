gl.setup(1024, 768)

font = resource.load_font("miso-regular.ttf")
logo = resource.load_image("rnv-logo.png")

json = require "json"

util.file_watch("fahrplan.json", function(content)
    fahrplan = json.decode(content)
    last_update = sys.now
end)

function node.render()
    gl.clear(1, 1, 1, 1)
    font:write(50, 40, "Fahrplan", 90, 0,0,0,1)
    logo:draw(800, 60, 930, 110)

    font:write(50, 140, "Uhrzeit", 50, 0,0,0,1)
    font:write(300, 140, "Linie", 50, 0,0,0,1)
    font:write(400, 140, "Uhrzeit", 50, 0,0,0,1)
    font:write(750, 140, "Verspätung", 50, 0,0,0,1)
    for idx, fahrt in ipairs(fahrplan) do
        font:write(50, 150 + 50 * idx, fahrt.uhrzeit, 40, 0,0,0,1)
        font:write(330, 150 + 50 * idx, fahrt.linie, 40, 0,0,0,1)
        font:write(400, 150 + 50 * idx, fahrt.ziel, 40, 0,0,0,1)
        if 0+fahrt.verspaetung > 0 then
            font:write(830, 150 + 50 * idx, "+" .. fahrt.verspaetung, 40, 1,0,0,1)
        else
            font:write(830, 150 + 50 * idx, "+" .. fahrt.verspaetung, 40, 0,0,0,1)
        end
    end
end
