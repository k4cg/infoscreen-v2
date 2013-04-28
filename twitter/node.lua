local INTERVAL = 7

gl.setup(1024, 768)

json = require "json"

font = resource.load_font("miso-regular.ttf")

function wrap(str, limit, indent, indent1)
    limit = limit or 72
    local here = 1
    local wrapped = str:gsub("(%s+)()(%S+)()", function(sp, st, word, fi)
        if fi-here > limit then
            here = st
            return "\n"..word
        end
    end)
    local splitted = {}
    for token in string.gmatch(wrapped, "[^\n]+") do
        splitted[#splitted + 1] = token
    end
    return splitted
end

util.file_watch("tweets.json", function(content)
    tweets = json.decode(content)
    for idx, tweet in ipairs(tweets) do
        tweet.image = resource.load_image(tweet.image);
        tweet.lines = wrap(tweet.text, 50)
    end
end)

tweet_source = util.generator(function()
    return tweets
end)

function load_next()
    next_tweet = sys.now() + INTERVAL
    current_tweet = tweet_source:next()
end

load_next()

function node.render()
    gl.clear(1, 1, 1, 1)

    if sys.now() > next_tweet then
        load_next()
    end

    font:write(50, 40, "Twitter", 90, 0,0,0,1)

    current_tweet.image:draw(50, 310, 130, 390)
    font:write(150, 310, "@" .. current_tweet.user, 70, 0,0,0,1)
    lastidx = 0
    for idx, line in ipairs(current_tweet.lines) do
        font:write(50, 350 + idx * 50, line, 50, 0,0,0,1)
        lastidx = idx
    end
    font:write(50, 350 + (lastidx + 1) * 55, "-- " .. current_tweet.time, 40, 0.7,0.7,0.7,1)
end
