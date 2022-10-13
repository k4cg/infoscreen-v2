gl.setup(1080,1920)

wifi = resource.load_image("wifi.png")
font = resource.load_font("miso-regular.ttf")

-- scale image
w, h = wifi:size()

function node.render()
    gl.clear(0, 0, 0, 1)
    font:write(WIDTH/4, HEIGHT-550, "SSID: k4cg-intern", 80, 0, 0.5, 0, 1)
    font:write(WIDTH/4, HEIGHT-650, "Password: bernd2342", 80, 0, 0.5, 0, 1)

    wifi:draw( 0 , 0, w, h)
end
