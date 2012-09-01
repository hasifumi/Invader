class Droid extends Sprite
  constructor:(w, h)->
    super(w, h)
    game = enchant.Game.instance
    @image = game.assets["image/apple.png"]
    @x = game.width/2
    @y = game.height - 40
    @_style.zIndex = 1
    @addEventListener 'enterframe', =>
      if game.input.left
        @x -= 4
        if @x < 0
          @x = 0
      if game.input.right
        @x += 4
        if @x > (game.width - @width)
          @x = (game.width - @width)


