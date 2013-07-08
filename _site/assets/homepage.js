(function() {
  var Homepage;

  Homepage = (function() {

    function Homepage() {
      var _this = this;
      this.kanjify = new Kanjify({
        kanjivgPath: '/kanjify/assets/kanjivg/kanji/'
      });
      this.kanjify.setCharacter('私');
      $('#animate').click(function() {
        return _this.kanjify.animate();
      });
    }

    return Homepage;

  })();

  window.page = new Homepage();

}).call(this);
