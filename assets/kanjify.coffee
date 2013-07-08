---
---
class window.Kanjify
    options:
        target: '#kanjify'
        kanjivgPath: null
        width: 200
        height: 200
        baseStrokeStyle: 'fill:none;stroke:#000000;stroke-width:3;stroke-linecap:round;stroke-linejoin:round;'

    constructor: (options = {}) ->
        @options[key] = value for key, value of options
        @svg = d3.select(@options.target).append('svg')
            .attr('width', @options.width)
            .attr('height', @options.height)
        @g = @svg.append('g').attr('style', @options.baseStrokeStyle)

    setCharacter: (@char) ->
        console.log @char

    render: ->
        @loadKanjivg (err, @charSvg) =>
            strokes = @charSvg.getElementsByTagName('path')
            @fixScaling()
            @paths = for stroke in strokes
                @g.append('path')
                    .attr('d', stroke.attributes.d.textContent)

    fixScaling: ->
        svgHeight = parseInt(@charSvg.documentElement.attributes.height.nodeValue)
        svgWidth = parseInt(@charSvg.documentElement.attributes.width.nodeValue)
        heightScale = @options.height / svgHeight
        widthScale = @options.width / svgWidth
        scale = Math.min(heightScale, widthScale)
        console.log scale
        @g.attr('transform', "scale(#{scale})")

    animate: ->
        for path in @paths
            path.style('stroke-dasharray', '0,99999')
        @_animateHelper(0)

    _animateHelper: (pathNum) ->
        path = @paths[pathNum]
        return unless path
        path
            .transition()
            .style('stroke-dasharray', '100,99999')
            .each 'end', =>
                @_animateHelper(pathNum + 1)

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
