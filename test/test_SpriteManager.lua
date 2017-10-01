require 'SpriteManager'

function test_LoadSprite_LoadsSprite()
	local instance = SpriteManager:LoadSprite('Lavaman')
	assert_not_nil(instance)
end

function test_LoadSprite_ReturnsNilWhenSpriteDoesntExist()
	local sprite = SpriteManager:LoadSprite('blah')
	assert_nil(sprite)
end

function test_GetInstance_ReturnsInstance()
	local instance = SpriteManager:GetInstance('Lavaman')
	assert_table(instance)
end

function test_GetInstance_ReturnsNilWhenSpriteDoesntExist()
	local sprite = SpriteManager:GetInstance('blah')
	assert_nil(sprite)
end

function test_GetInstance_ReturnsInstanceWithProperties()
	local instance = SpriteManager:GetInstance('Lavaman')
	assert_equal('Lavaman', instance.sprite.sprite_name)
end

-- function test_UpdateInstance_UpdatesCounter()
-- 	local instance = SpriteManager:GetInstance('Lavaman')
-- 	assert_equal(0, instance.elapsed_time)

-- 	-- do upate
-- 	SpriteManager:UpdateInstance(instance, 0.05)

-- 	assert_equal(0.05, instance.elapsed_time)
-- end

-- function test_UpdateInstance_UpdatesFrame()
-- 	local instance = SpriteManager:GetInstance('Lavaman')
-- 	local amountOfTimeToProceedToNextFrame = instance.sprite.frame_duration + 0.001

-- 	assert_equal(1, instance.curr_frame)

-- 	-- do update
-- 	SpriteManager:UpdateInstance(instance, amountOfTimeToProceedToNextFrame)

-- 	assert_equal(2, instance.curr_frame)
-- end

-- function test_UpdateInstance_LoopsFrameBackToZero()
-- 	local instance = SpriteManager:GetInstance('Lavaman')
-- 	local framesInAnimation = #instance.sprite.animations[instance:GetCurrentAnimation()]
-- 	local amountOfTimeToProceedToNextFrame = instance.sprite.frame_duration + 0.001

-- 	assert_equal(1, instance.curr_frame)

-- 	-- do upate
-- 	for i=1, framesInAnimation , 1  do
-- 		SpriteManager:UpdateInstance(instance, amountOfTimeToProceedToNextFrame)
-- 	end

-- 	assert_equal(1, instance.curr_frame)
-- end

-- function test_UpdateInstance_DoesntGetInvalidFrames()
-- 	local instance = SpriteManager:GetInstance('Lavaman')
-- 	local amountOfTimeToProceedToNextFrame = instance.sprite.frame_duration + 0.001

-- 	-- update a bunch and make sure frames are valid
-- 	for i=1, 100, 1  do
-- 		SpriteManager:UpdateInstance(instance, amountOfTimeToProceedToNextFrame)
-- 		assert_not_nil(instance.curr_frame)
-- 		assert_lte(#instance.sprite.animations[instance:GetCurrentAnimation()], instance.curr_frame)
-- 	end
-- end

function test_DrawInstance_DoesntErrorOut()
	local instance = SpriteManager:GetInstance('Lavaman')
	result = SpriteManager:DrawInstance(instance, 1, 1)
	assert_nil(result)
end