gl.setup(1024, 768)

wifi = resource.load_image("wifi.png")
font = resource.load_font("miso-regular.ttf")

-- scale image
w, h = wifi:size()

function node.render()
    gl.clear(0, 0, 0, 1)
    font:write(100, 550, "SSID: k4cg-intern", 60, 0, 0.5, 0, 1)
    font:write(100, 650, "Password: EDITME", 40, 0, 0.5, 0, 1)

    wifi:draw( 0 , 0, w * 0.8, h * 0.8)
end
