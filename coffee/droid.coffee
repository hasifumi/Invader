class Droid extends Sprite
  constructor:->
    super(32, 32)
    @game = enchant.Game.instance
    #@fighter = fighter
    @image = @game.assets["image/droid.png"]
    @_style.zIndex = 2
