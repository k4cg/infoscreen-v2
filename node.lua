local INTERVAL = 30
gl.setup(1024, 768)

deck = {"home", "stats", "analogclock", "twitter", "tumblr", "fahrplan"}

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
