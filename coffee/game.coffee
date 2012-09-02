enchant()
class Invader extends Game
  config:{
    WIDTH: 360,
    HEIGHT: 480,
    FPS: 30,
    IMAGES:[
      "image/apple.png"
      "image/laser.png"
      "image/beam.png"
      "image/droid.png"
    ],
    MAXLASER: 4,
  }
  constructor:->
    super(@config.WIDTH, @config.HEIGHT)
    @fps = @config.FPS
    @game = enchant.Game.instance
    for i in @config.IMAGES
      @preload i
    @rootScene.backgroundColor = "black"
    scoreLabel = new Label("SCORE: 0")
    scoreLabel.font = "16px Tahoma"
    scoreLabel.color = "white"
    scoreLabel.x = 10
    scoreLabel.y = 5
    @rootScene.addChild scoreLabel
    score = 0
    count = 0
    @enemy = []
    total = 0
    @reverseFlag = false
    @setFlag false
    @moveDX = 0
    @moveDY = 0
    @setDX 4
    @setDY 0
    @cnt_laser = 0
    @onload = =>
      @fighter = new Fighter()
      @rootScene.addChild @fighter
      beam = new Beam(@fighter)
      @rootScene.addChild beam
      @keybind(90, "a")
      drawEnemy = =>
        for i in [0..5]
          for j in [0..7]
            droid = new Droid()
            droid.x = j * (32+10)
            droid.y = i * 32 + 30
            @rootScene.addChild droid
            @enemy.push droid
            count += 1
        total = count
      hitCheck = =>
        for i in @enemy
          if beam.intersect(i)
            beam.flag = false
            i.y = -9999
            score += 1
            total -= 1
            if total < 1
              #setTimeout(drawEnemy(), 2000)
              @rootScene.backgroundColor = "blue"
              @stop()
              alert "GAME CLEAR!!!"
        scoreLabel.text = "SCORE: "+score
      drawEnemy()
      @rootScene.addEventListener 'enterframe', =>
        hitCheck()
        @checkSide()
        @checkFlag()
        @addLaser()
      @rootScene.addEventListener 'touchstart', (e)=>
        @updateTouch(e)
      @rootScene.addEventListener 'touchmove', (e)=>
        @updateTouch(e)
      @rootScene.addEventListener 'touchend', =>
        @clearTouch()
    @start()
  updateTouch:(e)->
    if e.x > (@fighter.x + @fighter.width/2)
      @game.input.right = true
      @game.input.left  = false
    else
      @game.input.right = false
      @game.input.left  = true
  clearTouch:->
    @game.input.right = false
    @game.input.left  = false
  setFlag:(value)->
    @reverseFlag = value
    console.log "reverseFlag:"+@reverseFlag
  setDX:(value)->
    @moveDX = value
  setDY:(value)->
    @moveDY = value
  checkSide:->
    for i in @enemy
      if (i.x < 0) or ((i.x + i.width)> @game.width)
        @setFlag true
        break
  checkFlag:->
    if @reverseFlag
      @moveDX = -1 * @moveDX
      @moveDY = 8
      @setFlag false
    else
      @moveDY = 0
  addLaser:->
    if @cnt_laser < @config.MAXLASER
      pointer = Math.floor(Math.random() * 50)
      if @enemy[pointer]?
        lsr = new Laser(@enemy[pointer].x + 14, @enemy[pointer].y + 16, @fighter)
        @rootScene.addChild lsr
        @cnt_laser += 1
        console.log "addLaser @cnt_laser:"+@cnt_laser
  removeLaser:->
    @cnt_laser -= 1
    console.log "removeLaser @cnt_laser:"+@cnt_laser

window.onload = ->
  new Invader

