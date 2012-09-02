class Droid extends Sprite
  constructor:->
    super(32, 32)
    @game = enchant.Game.instance
    @image = @game.assets["image/droid.png"]
    @_style.zIndex = 2
    @addEventListener 'enterframe', =>
      @update()
      @checkGameOver()
  update:=>
    if @game.frame % 3 is 0
      @x += @game.moveDX
      @y += @game.moveDY
  checkGameOver:=>
    if @y >= 415
      @game.rootScene.backgroundColor = "red"
      @game.stop()
      alert "GAME OVER!!"
      return
