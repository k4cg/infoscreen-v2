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

-- angle
a = 0

function node.render()
    gl.clear(0, 0, 0, 1)
    font:write(370, 550, "K4CG InfoScreen", 60, 0, 0.5, 0, 1)
    font:write(290, 650, "please contribute:         /k4cg/infoscreen-v2", 40, 0, 0.5, 0, 1)
    gh:draw(530, 640, 600, 700)

    gl.translate(WIDTH / 2, 0, 0)
    gl.rotate(a, 0, 1, 0)
    a = (a + 2) % 360

    logo:draw(- WIDTH / 2 + x, y, new_w - WIDTH / 2, new_h)
end
