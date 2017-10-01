require 'SpriteInstance'

function test_New_ReturnsInstance()
	sprite = loadfile('sprites/Lavaman.lua')()
	instance = SpriteInstance:new(sprite)
	assert_table(instance)
end

function test_New_ReturnsInstanceWithDefaultProperties()
	sprite = loadfile('sprites/Lavaman.lua')()
	instance = SpriteInstance:new(sprite)
	assert_equal(1, instance.curr_frame)
end

function test_New_InstanceDefaultsToFirstAnimationType()
	sprite = loadfile('sprites/Lavaman.lua')()
	instance = SpriteInstance:new(sprite)
	assert_equal('idle', instance:GetCurrentAnimation())
end





function test_ChangeAnimationNow_ChangesAnimRightAway()
	sprite = loadfile('sprites/Lavaman.lua')()
	instance = SpriteInstance:new(sprite)
	assert_equal('idle', instance:GetCurrentAnimation())

	-- change
	instance:ChangeAnimationNow('attack')

	assert_equal('attack', instance:GetCurrentAnimation())
end


function test_ChangeAnimationSoon_ChangesAnimAfterTheCurrentAnim()
	sprite = loadfile('sprites/Lavaman.lua')()
	instance = SpriteInstance:new(sprite)
	assert_equal('idle', instance:GetCurrentAnimation())
	local framesInAnimation = #instance.sprite.animations[instance:GetCurrentAnimation()]
	local amountOfTimeToProceedToNextFrame = instance.sprite.frame_duration + 0.001

	-- change
	instance:ChangeAnimationSoon('attack')
	-- do some updates
	for i=1, framesInAnimation , 1  do
		instance:Update(amountOfTimeToProceedToNextFrame)
	end

	assert_equal('attack', instance:GetCurrentAnimation())
end




function test_UpdateInstance_UpdatesCounter()
	sprite = loadfile('sprites/Lavaman.lua')()
	instance = SpriteInstance:new(sprite)
	assert_equal(0, instance.elapsed_time)

	-- do upate
	instance:Update(0.05)

	assert_equal(0.05, instance.elapsed_time)
end

function test_UpdateInstance_UpdatesFrame()
	sprite = loadfile('sprites/Lavaman.lua')()
	instance = SpriteInstance:new(sprite)
	local amountOfTimeToProceedToNextFrame = instance.sprite.frame_duration + 0.001

	assert_equal(1, instance.curr_frame)

	-- do update
	instance:Update(amountOfTimeToProceedToNextFrame)

	assert_equal(2, instance.curr_frame)
end

function test_UpdateInstance_LoopsFrameBackToZero()
	sprite = loadfile('sprites/Lavaman.lua')()
	instance = SpriteInstance:new(sprite)
	local framesInAnimation = #instance.sprite.animations[instance:GetCurrentAnimation()]
	local amountOfTimeToProceedToNextFrame = instance.sprite.frame_duration + 0.001

	assert_equal(1, instance.curr_frame)

	-- do upate
	for i=1, framesInAnimation , 1  do
		instance:Update(amountOfTimeToProceedToNextFrame)
	end

	assert_equal(1, instance.curr_frame)
end

function test_UpdateInstance_DoesntGetInvalidFrames()
	sprite = loadfile('sprites/Lavaman.lua')()
	instance = SpriteInstance:new(sprite)
	local amountOfTimeToProceedToNextFrame = instance.sprite.frame_duration + 0.001

	-- update a bunch and make sure frames are valid
	for i=1, 100, 1  do
		instance:Update(amountOfTimeToProceedToNextFrame)
		assert_not_nil(instance.curr_frame)
		assert_lte(#instance.sprite.animations[instance:GetCurrentAnimation()], instance.curr_frame)
	end
end