node.alias('fahrplan')
gl.setup(1080,1920)

font = resource.load_font("miso-regular.ttf")
--logo = resource.load_image("vag-logo.png")

json = require "json"

local current_time = N.current_time or "00:00"
local current_seconds = N.current_seconds or 0

util.data_mapper{
    ["clock/set"] = function(time)
        current_time = time
        N.current_time = current_time
--        print("new time " .. current_time)
    end;
    ["seconds/set"] = function(seconds)
        current_seconds = tonumber(seconds)
        N.current_seconds = current_seconds
        node.render()
    end;
    }

local fahrplan = N.fahrplan or {["Haltestelle"] = "", ["Abfahrten"] = {}}

function node.render()
    gl.clear(0, 0, 0, 1)
--    gl.rotate(90, 1, 1, 0)
    font:write(50, 30, "Abfahrten ab", 35, 0.0,0.1,0.0,1)
    font:write(50, 70, fahrplan.Haltestelle, 90, 0,1,0,1)
  --  logo:draw(800, 60, 1000, 120)

    font:write(50, 170, "Abfahrt", 60,  0.8,0.8,0.8,1)
    font:write(270, 170, "Linie", 60,  0.8,0.8,0.8,1)
    font:write(440, 170, "Richtung", 60, 0.8,0.8,0.8,1)
    font:write(850, 170, "Verspätung", 60, 0.8,0.8,0.8,1)
    idx = 1
    for k,fahrt in ipairs(fahrplan.Abfahrten) do
	if os.date("*t").isdst then
	        departure = math.floor((fahrt.AbfahrtszeitSoll - 3600 - current_seconds) / 60)
	else
		departure = math.floor((fahrt.AbfahrtszeitSoll - current_seconds) / 60)
	end

        if departure == 0 then
           departure = "jetzt"
        else
           departure = "in " .. departure  .. "'"
        end
        if (fahrt.AbfahrtszeitSoll > current_seconds) then
                font:write(50, 150 + 70 * idx, departure, 80, 0,1,0,1)
                font:write(270, 150 + 70 * idx, fahrt.Linienname, 80,  0,1,0,1)
                font:write(440, 150 + 70 * idx, fahrt.Richtungstext, 80, 0,1,0,1)
                if fahrt.Verspaetung > 0 then
                      font:write(970, 150 + 70 * idx, "" .. fahrt.Verspaetung, 80, 0.8,0.8,0.3,1)
                else
                      --font:write(970, 150 + 70 * idx, "0", 80, 0.8,0.8,0.3,1)
                end
                idx = idx + 1
                if idx > 23 then
                   break
                end
        end
    end
    font:write(WIDTH - 240, 0, current_time, 80, 0,1,0,1)
end

node.event("input", function(line, client)
    fahrplan = json.decode(line)
    N.fahrplan = fahrplan
    print("departures update")
    node.render()
end)
