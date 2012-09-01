// Generated by CoffeeScript 1.3.3
(function() {
  var Beam, Droid, Fighter, Invader,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

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
      this.game = enchant.Game.instance;
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
        var beam, drawEnemy, hitCheck;
        _this.fighter = new Fighter();
        _this.rootScene.addChild(_this.fighter);
        beam = new Beam(_this.fighter);
        _this.rootScene.addChild(beam);
        _this.keybind(90, "a");
        drawEnemy = function() {
          var droid, j, _j, _k;
          for (i = _j = 0; _j <= 5; i = ++_j) {
            for (j = _k = 0; _k <= 1; j = ++_k) {
              droid = new Droid();
              droid.x = j * (32 + 10);
              droid.y = i * 32 + 30;
              _this.rootScene.addChild(droid);
              enemy.push(droid);
              count += 1;
            }
          }
          return total = count;
        };
        hitCheck = function() {
          var _j, _len1;
          for (_j = 0, _len1 = enemy.length; _j < _len1; _j++) {
            i = enemy[_j];
            if (beam.intersect(i)) {
              beam.flag = false;
              i.y = -9999;
              score += 1;
              total -= 1;
              if (total < 1) {
                setTimeout(drawEnemy(), 2000);
              }
            }
          }
          return scoreLabel.text = "SCORE: " + score;
        };
        drawEnemy();
        _this.rootScene.addEventListener('enterframe', function() {
          return hitCheck();
        });
        _this.rootScene.addEventListener('touchstart', function(e) {
          return _this.updateTouch(e);
        });
        _this.rootScene.addEventListener('touchmove', function(e) {
          return _this.updateTouch(e);
        });
        return _this.rootScene.addEventListener('touchend', function() {
          return _this.clearTouch();
        });
      };
      this.start();
    }

    Invader.prototype.updateTouch = function(e) {
      if (e.x > (this.fighter.x + this.fighter.width / 2)) {
        this.game.input.right = true;
        return this.game.input.left = false;
      } else {
        this.game.input.right = false;
        return this.game.input.left = true;
      }
    };

    Invader.prototype.clearTouch = function() {
      this.game.input.right = false;
      return this.game.input.left = false;
    };

    return Invader;

  })(Game);

  window.onload = function() {
    return new Invader;
  };

  Fighter = (function(_super) {

    __extends(Fighter, _super);

    function Fighter() {
      Fighter.__super__.constructor.call(this, 32, 32);
      this.game = enchant.Game.instance;
      this.image = this.game.assets["image/apple.png"];
      this.x = this.game.width / 2;
      this.y = this.game.height - 40;
      this._style.zIndex = 1;
      this.addEventListener('enterframe', this.enterFrame);
    }

    Fighter.prototype.enterFrame = function() {
      if (this.game.input.left) {
        this.x -= 4;
        if (this.x < 0) {
          this.x = 0;
        }
      }
      if (this.game.input.right) {
        this.x += 4;
        if (this.x > (this.game.width - this.width)) {
          return this.x = this.game.width - this.width;
        }
      }
    };

    return Fighter;

  })(Sprite);

  Beam = (function(_super) {

    __extends(Beam, _super);

    function Beam(fighter) {
      Beam.__super__.constructor.call(this, 4, 16);
      this.game = enchant.Game.instance;
      this.fighter = fighter;
      this.flag = false;
      this.image = this.game.assets["image/beam.png"];
      this._style.zIndex = 2;
      this.addEventListener('enterframe', function() {
        this.setBeam();
        this.startBeam();
        return this.moveBeam();
      });
    }

    Beam.prototype.setBeam = function() {
      if (this.flag === false) {
        this.x = this.fighter.x + 14;
        return this.y = this.fighter.y - 11;
      }
    };

    Beam.prototype.startBeam = function() {
      if (this.flag === false) {
        return this.flag = true;
      }
    };

    Beam.prototype.moveBeam = function() {
      if (this.flag) {
        this.y -= 8;
        if (this.y < -32) {
          return this.flag = false;
        }
      }
    };

    return Beam;

  })(Sprite);

  Droid = (function(_super) {

    __extends(Droid, _super);

    function Droid() {
      Droid.__super__.constructor.call(this, 32, 32);
      this.game = enchant.Game.instance;
      this.image = this.game.assets["image/droid.png"];
      this._style.zIndex = 2;
    }

    return Droid;

  })(Sprite);

}).call(this);
