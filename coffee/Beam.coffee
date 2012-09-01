class Beam extends Sprite
  constructor:(fighter)->
    super(4, 16)
    @game = enchant.Game.instance
    @fighter = fighter
    @flag = false
    @image = @game.assets["image/beam.png"]
    @_style.zIndex = 2
    @addEventListener 'enterframe', ->
      @setBeam()
      @startBeam()
      @moveBeam()
  setBeam:->
    if @flag is false
      @x = @fighter.x + 14
      @y = @fighter.y - 11
  startBeam:->
    #if (@flag is false) and (@game.input.a)
    if @flag is false
      @flag = true
  moveBeam:->
    if @flag
      @y -= 8
      if @y < -32
        @flag = false

