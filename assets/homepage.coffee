---
---
class Homepage

    constructor: ->
        @kanjify = new Kanjify(kanjivgPath: '/kanjify/assets/kanjivg/kanji/')
        @kanjify.setCharacter('私')
        @kanjify.render()

window.page = new Homepage()