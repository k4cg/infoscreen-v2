local INTERVAL = 7

gl.setup(1024, 768)

json = require "json"

font = resource.load_font("miso-regular.ttf")
hdr_offs = 150

util.file_watch("tumblr.json", function(content)
    images = json.decode(content)
    for idx, image in ipairs(images) do
        pcall(function()
            image.image = resource.load_image(image.image)
            image.w, image.h = image.image:size()
        end)
    end
end)

image_source = util.generator(function()
    return images
end)

function load_next()
    next_image = sys.now() + INTERVAL
    current_image = image_source:next()
end

load_next()

function node.render()
    gl.clear(1, 1, 1, 1)

    if sys.now() > next_image then
        load_next()
    end

    font:write(50, 40, "Tumblr", 90, 0,0,0,1)

    -- scale images (down + up, if necessary)
    new_w = current_image.w
    new_h = current_image.h
    if current_image.w > current_image.h then
        new_w = 0.9 * WIDTH
        new_h = new_w / current_image.w * current_image.h

        -- rescale height if necessary
        if new_h > HEIGHT - hdr_offs then
            new_h = HEIGHT - hdr_offs
            new_w = new_h / current_image.h * current_image.w
        end
    else
        new_h = 0.9 * (HEIGHT - hdr_offs)
        new_w = new_h / current_image.h * current_image.w

        -- rescale width if necessary
        if new_w > WIDTH then
            new_w = WIDTH
            new_h = new_w / current_image.h * current_image.w
        end
    end

    new_x = (WIDTH - new_w) / 2
    new_y = (HEIGHT + hdr_offs - new_h) / 2

    current_image.image:draw(new_x, new_y, new_x + new_w, new_y + new_h)
end
