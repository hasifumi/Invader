(function() {
  var Invader,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  enchant();

  Invader = (function(_super) {

    __extends(Invader, _super);

    Invader.prototype.config = {
      WIDTH: 360,
      HEIGHT: 480,
      FPS: 30,
      IMAGES: ["image/apple.png", "image/laser.png", "image/beam.png", "image/droid.png"]
    };

    function Invader() {
      var count, enemy, i, score, scoreLabel, total, _i, _len, _ref,
        _this = this;
      Invader.__super__.constructor.call(this, this.config.WIDTH, this.config.HEIGHT);
      this.fps = this.config.FPS;
      _ref = this.config.IMAGES;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        i = _ref[_i];
        this.preload(i);
      }
      this.rootScene.backgroundColor = "black";
      scoreLabel = new Label("SCORE: 0");
      scoreLabel.font = "16px Tahoma";
      scoreLabel.color = "white";
      scoreLabel.x = 10;
      scoreLabel.y = 5;
      this.rootScene.addChild(scoreLabel);
      score = 0;
      count = 0;
      enemy = [];
      total = 0;
      this.onload = function() {
        var beam, drawEnemy, fighter, hitCheck, moveBeam, moveFighter, startBeam;
        fighter = new Sprite(32, 32);
        fighter.image = _this.assets["image/apple.png"];
        fighter.x = _this.width / 2;
        fighter.y = _this.height - 40;
        fighter._style.zIndex = 1;
        _this.rootScene.addChild(fighter);
        beam = new Sprite(4, 16);
        beam.flag = false;
        beam.x = fighter.x + 14;
        beam.y = fighter.y - 8;
        beam.image = _this.assets["image/beam.png"];
        beam._style.zIndex = 2;
        _this.rootScene.addChild(beam);
        _this.keybind(90, "a");
        drawEnemy = function() {
          var i, j, sp;
          for (i = 0; i <= 5; i++) {
            for (j = 0; j <= 1; j++) {
              sp = new Sprite(32, 32);
              sp.image = _this.assets["image/droid.png"];
              sp.x = j * (32 + 10);
              sp.y = i * 32 + 30;
              console.log(("" + count + ": sp.x:") + sp.j + ", y:" + sp.i);
              sp._style.zIndex = 2;
              _this.rootScene.addChild(sp);
              enemy.push(sp);
              count += 1;
            }
          }
          return total = count;
        };
        startBeam = function() {
          if (beam.flag === false) {
            if (_this.input.a) {
              beam.flag = true;
              beam.x = fighter.x + 14;
              return beam.y = fighter.y - 11;
            }
          }
        };
        moveBeam = function() {
          if (beam.flag) {
            beam.y -= 8;
            if (beam.y < -32) return beam.flag = false;
          }
        };
        moveFighter = function() {
          if (_this.input.left) {
            fighter.x -= 4;
            if (fighter.x < 0) fighter.x = 0;
          }
          if (_this.input.right) {
            fighter.x += 4;
            if (fighter.x > (_this.width - fighter.width)) {
              fighter.x = _this.width - fighter.width;
            }
          }
          if (beam.flag === false) {
            beam.x = fighter.x + 14;
            return beam.y = fighter.y - 11;
          }
        };
        hitCheck = function() {
          var i, _j, _len2;
          for (_j = 0, _len2 = enemy.length; _j < _len2; _j++) {
            i = enemy[_j];
            if (beam.intersect(i)) {
              beam.flag = false;
              i.y = -9999;
              score += 1;
              total -= 1;
              if (total < 1) setTimeout(drawEnemy(), 2000);
            }
          }
          return scoreLabel.text = "SCORE: " + score;
        };
        drawEnemy();
        return _this.rootScene.addEventListener('enterframe', function() {
          startBeam();
          moveBeam();
          moveFighter();
          return hitCheck();
        });
      };
      this.start();
    }

    return Invader;

  })(Game);

  window.onload = function() {
    return new Invader;
  };

}).call(this);
