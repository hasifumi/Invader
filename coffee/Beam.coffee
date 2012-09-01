class Beam extends Sprite
  constructor:(fighter)->
    super(4, 16)
    @game = enchant.Game.instance
    @flag = false
    @image = @game.assets["image/beam.png"]
    @x = fighter.x + 14
    @y = fighter.y - 8
    @_style.zIndex = 2
    @startBeam = =>
      if @flag is false
        if @game.input.a
          @flag = true
          @x = fighter.x + 14
          @y = fighter.y - 11
    @moveBeam = =>
      if @flag
        @y -= 8
        if @y < -32
          @flag = false
    @addEventListener 'enterframe', =>
      @startBeam()
      @moveBeam()

