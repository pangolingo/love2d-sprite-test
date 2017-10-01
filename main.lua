local lovetest = require "test/lovetest"
require 'SpriteManager'

function love.load(arg)
	if lovetest.detect(arg) then
	    -- Run the tests
	    lovetest.run()
  end

  love.keyboard.setKeyRepeat(true)

	lavaman = SpriteManager:GetInstance('Lavaman')

	-- lavamanSprite = dofile("LavamanSprite.lua")
end

function love.update(dt)

  if love.keyboard.isDown( "up" ) then
    lavaman.pos_y = lavaman.pos_y - 5
  end
  if love.keyboard.isDown( "down" ) then
    lavaman.pos_y = lavaman.pos_y + 5
  end
  if love.keyboard.isDown( "left" ) then
    lavaman:MoveLeft()
  end
  if love.keyboard.isDown( "right" ) then
    lavaman:MoveRight()
  end

  SpriteManager:UpdateInstance(lavaman, dt)
end

function love.draw()
  love.graphics.print("Hello World!", 400, 300)

  love.graphics.print(lavaman:AnimQueueToString(), 400, 500)

  SpriteManager:DrawInstance(lavaman, lavaman.pos_x, lavaman.pos_y)

  -- love.graphics.draw (
  --       love.graphics.newImage(lavamanSprite.sprite_sheet), --The image
  --       --Current frame of the current animation
  --       lavamanSprite.animations['idle'][4],
  --       5,
  --       10,
  --       0,
  --       1,
  --       1,
  --       0,
  --       0
  --   )

end

function love.mousepressed()
  -- lavaman:ChangeAnimation('attack')
  lavaman:Attack()
end

function love.mousereleased()
end

function love.keypressed( key )
  if key == "space" then
    lavaman:Attack()
  end
end

function love.keyreleased( key )
end
