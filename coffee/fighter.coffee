class Fighter extends Sprite
  constructor:->
    super(32, 32)
    game = enchant.Game.instance
    @image = game.assets["image/apple.png"]
    @x = game.width/2
    @y = game.height - 40
    @_style.zIndex = 1
    #@addEventListener('enterframe', @enterFrame())
    @addEventListener 'enterframe', ->
        if game.input.left
          @x -= 4
          if @x < 0
            @x = 0
        if game.input.right
          @x += 4
          if @x > (game.width - @width)
            @x = (game.width - @width)
  enterFrame:=>
    game = enchant.Game.instance
    if game.input.left
      @x -= 4
      if @x < 0
        @x = 0
    if game.input.right
      @x += 4
      if @x > (game.width - @width)
        @x = (game.width - @width)





          #      fighter = new Sprite(32, 32)
          #      fighter.image = @assets["image/apple.png"]
          #      fighter.x = @width/2
          #      fighter.y = @height - 40
          #      fighter._style.zIndex = 1
          #      @rootScene.addChild fighter
          #
          #      moveFighter = =>
          #        if @input.left
          #          fighter.x -= 4
          #          if fighter.x < 0
          #            fighter.x = 0
          #        if @input.right
          #          fighter.x += 4
          #          if fighter.x > (@width - fighter.width)
          #            fighter.x = @width - fighter.width
          #        if beam.flag is false
          #          beam.x = fighter.x + 14
          #          beam.y = fighter.y - 11

