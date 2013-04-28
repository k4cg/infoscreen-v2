gl.setup(1024, 768)

gh = resource.load_image("Octocat.png")
font = resource.load_font("miso-regular.ttf")
logo = resource.load_image("rzl-logo.png")

-- scale image
w, h = logo:size()

new_w = 0.9 * WIDTH
new_h = (new_w / w) * h

x = (WIDTH - new_w) / 2
y = (HEIGHT - new_h) / 2

-- angle
a = 0

function node.render()
    gl.clear(1, 1, 1, 1)
    font:write(370, 500, "InfoScreen v2", 60, 0, 0, 0, 1)
    font:write(290, 600, "please contribute:         /infoscreen-v2", 40, 0, 0, 0, 1)
    gh:draw(530, 590, 600, 650)

    gl.translate(WIDTH / 2, 0, 0)
    gl.rotate(a, 0, 1, 0)
    a = (a + 2) % 360

    logo:draw(- WIDTH / 2 + x, y, new_w - WIDTH / 2, new_h)
end
