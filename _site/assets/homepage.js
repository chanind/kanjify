(function() {
  var Homepage;

  Homepage = (function() {

    function Homepage() {
      this.kanjify = new Kanjify({
        kanjivgPath: '/kanjify/assets/kanjivg/kanji/'
      });
      this.kanjify.setCharacter('私');
      this.kanjify.render();
    }

    return Homepage;

  })();

  window.page = new Homepage();

}).call(this);
