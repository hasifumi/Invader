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
  }
  constructor:->
    super(@config.WIDTH, @config.HEIGHT)
    @fps = @config.FPS
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
    enemy = []
    total = 0
    @onload = =>
      fighter = new Sprite(32, 32)
      fighter.image = @assets["image/apple.png"]
      fighter.x = @width/2
      fighter.y = @height - 40
      fighter._style.zIndex = 1
      @rootScene.addChild fighter

      beam = new Sprite(4, 16)
      beam.flag = false
      beam.x = fighter.x + 14
      beam.y = fighter.y - 8
      beam.image = @assets["image/beam.png"]
      beam._style.zIndex = 2
      @rootScene.addChild beam

      @keybind(90, "a")
      drawEnemy = =>
        for i in [0..5]
          for j in [0..1]
            sp = new Sprite(32, 32)
            sp.image = @assets["image/droid.png"]
            sp.x = j * (32+10)
            sp.y = i * 32 + 30
            console.log "#{count}: sp.x:"+sp.j+", y:"+sp.i
            sp._style.zIndex = 2
            @rootScene.addChild sp
            enemy.push sp
            count += 1
        total = count

      startBeam = =>
        if beam.flag is false
          if @input.a
            beam.flag = true
            beam.x = fighter.x + 14
            beam.y = fighter.y - 11

      moveBeam = =>
        if beam.flag
          beam.y -= 8
          if beam.y < -32
            beam.flag = false

      moveFighter = =>
        if @input.left
          fighter.x -= 4
          if fighter.x < 0
            fighter.x = 0
        if @input.right
          fighter.x += 4
          if fighter.x > (@width - fighter.width)
            fighter.x = @width - fighter.width
        if beam.flag is false
          beam.x = fighter.x + 14
          beam.y = fighter.y - 11

      hitCheck = =>
        for i in enemy
          if beam.intersect(i)
            beam.flag = false
            i.y = -9999
            score += 1
            total -= 1
            if total < 1
              setTimeout(drawEnemy(), 2000)
        scoreLabel.text = "SCORE: "+score

      drawEnemy()
      @rootScene.addEventListener 'enterframe', ->
        startBeam()
        moveBeam()
        moveFighter()
        hitCheck()

    @start()

window.onload = ->
  new Invader

