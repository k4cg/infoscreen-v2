local INTERVAL = 20
gl.setup(1080,1920)

deck = {"home", "fahrplan", "wifi"}

slide_source = util.generator(function()
    return deck
end)

next_slide = sys.now() + INTERVAL
current_slide = "home"

function node.render()
    gl.clear(0, 1, 0, 1) -- green

    if sys.now() > next_slide then
        next_slide = sys.now() + INTERVAL
        current_slide = slide_source:next()
    end

    resource.render_child(current_slide):draw(0, 0, WIDTH, HEIGHT)
end
