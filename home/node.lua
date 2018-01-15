gl.setup(1024, 768)

gh = resource.load_image("Octocat.png")
font = resource.load_font("miso-regular.ttf")
logo = resource.load_image("k4cg-logo.png")

-- scale image
w, h = logo:size()

new_w = 0.7 * WIDTH
new_h = (new_w / w) * h

x = (WIDTH - new_w) / 2
y = (HEIGHT - new_h) / 5

function node.render()
    gl.clear(0, 0, 0, 1)
    font:write(370, 550, "K4CG InfoScreen", 60, 0, 0.5, 0, 1)
    font:write(290, 650, "please contribute:         /k4cg/infoscreen-v2", 40, 0, 0.5, 0, 1)
    gh:draw(530, 640, 600, 700)

    logo:draw(0, 0, new_w , new_h)
end
