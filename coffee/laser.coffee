class Laser extends Sprite
  constructor:(x, y, fighter)->
    super(4, 16)
    @game = enchant.Game.instance
    @fighter = fighter
    @image = @game.assets["image/laser.png"]
    @x = x
    @y = y
    @_style.zIndex = 1
    @addEventListener 'enterframe', ->
      @update()
  update:->
    if @y >= 0
      @y += 8
    if @y > (@game.height + @height)
      console.log "laser @y:"+@y
      @game.rootScene.removeChild @
      @game.removeLaser()
    if @intersect @fighter
      @game.rootScene.backgroundColor = "red"
      @game.stop()
      alert "GAME OVER!!"

