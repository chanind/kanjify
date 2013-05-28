---
---
class window.Kanjify
    options:
        target: '#kanjify'
        kanjivgPath: null
        width: 200
        height: 200

    constructor: (options = {}) ->
        @options[key] = value for key, value of options
        @svg = d3.select(@options.target).append('svg')
            .attr('width', @options.width)
            .attr('height', @options.height)

    setCharacter: (@char) ->
        console.log @char

    render: ->
        @loadKanjivg (err, @charSvg) =>
            @svg.append(@charSvg)


    loadKanjivg: (callback) -> d3.xml(@getKanjivgFilePathForChar(), callback)

    getKanjivgFilePathForChar: ->
        charCode = @char.charCodeAt(0).toString(16)
        console.log charCode
        l = charCode.length
        fileBase = switch charCode.length
            when 0 then '00000'
            when 1 then '0000' + charCode
            when 2 then '000' + charCode
            when 3 then '00' + charCode
            when 4 then '0' + charCode
            when 5 then charCode
        @options.kanjivgPath + fileBase + '.svg'
