local levelGenerator = {
    generate = function(dimension, generator)
        assert(generator ~= nil, 'Generator function should be provided')

        local map = {}
        for i = 1, dimension.h do
            map[i] = {}
            for j = 1, dimension.w do
                map[i][j] = generator(map, {w = j, h = i})
            end
        end

        return map
    end
}

return levelGenerator
