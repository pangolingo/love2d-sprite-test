SpriteInstance = {

	sprite = nil,
	-- curr_anim = nil,
	anim_queue = {},
	curr_frame = 1,
	elapsed_time = 0,
	size_scale = 1,
	time_scale = 1,
	rotation = 0,
	flip_h = 1,
	flip_v = 1,
	pos_x = 100,
	pos_y = 100,
	facing = "right",
	move_speed = 1,
	-- default_anim = "idle"

	new = function(self, sprite)
		if sprite == nil then error("SpriteInstance:new must receive a sprite") end

		newobject = {}
		setmetatable(newobject, self)
      	self.__index = self

      	newobject.sprite = sprite
      	newobject:ChangeAnimationNow(sprite.animation_names[1])

      	return newobject
	end,

	Attack = function(self)
		print("ATTACK!")
		if(self.facing == "right") then
			self:ChangeAnimationNow('attack', false)
  			-- self:AddAnimationToQueue('idle')
  		else
  			self:ChangeAnimationNow('attack_back', false)
  			-- self:AddAnimationToQueue('idle_back')
		end

	end,

	MoveRight = function(self)
		if self.facing == "left" then
			self:ChangeAnimationNow("idle", false)
		end

		self.pos_x = self.pos_x + self.move_speed
		self.facing = "right"
		-- self:ChangeAnimationSoon("idle")
	end,

	MoveLeft = function(self)
		if self.facing == "right" then
			self:ChangeAnimationNow("idle_back", false)
		end

		self.pos_x = self.pos_x - self.move_speed
		self.facing = "left"
		-- self:ChangeAnimationSoon("idle_back")
	end,

	GetCurrentAnimation = function(self)
		return self.anim_queue[1]
	end,

	AddAnimationToQueue = function(self, anim_name)
		-- table.insert(self.anim_queue, #self.anim_queue + 1, anim_nam)
		self.anim_queue[#self.anim_queue+1] = anim_name
	end,

	ChangeAnimationSoon = function(self, anim_name)
		-- self.curr_frame = 1
		-- self.curr_anim = anim_name
		self:AddAnimationToQueue(anim_name)
	end,

	ChangeAnimationNow = function(self, anim_name, interruptIfDoing)
		if not interruptIfDoing and self:GetCurrentAnimation() == anim_name then
			return
		end
		self.anim_queue = {}
		self.curr_frame = 1
		self:AddAnimationToQueue(anim_name)
	end,

	Update = function(self, dt)
		--Increment the internal counter.
		self.elapsed_time = self.elapsed_time + dt

		-- update the frame if the counter has exceeded a certain value. then reset counter
		if self.elapsed_time > self.sprite.frame_duration then
			-- if we're at the last frame, go back to 1
			--  # returns the total entries of an array.
			if self.curr_frame >= #self.sprite.animations[self:GetCurrentAnimation()] then
				self.curr_frame = 1
				self:ProceedToNextAnimationInQueue()
			else
				self.curr_frame = self.curr_frame + 1
			end

			-- Reset internal counter on frame change.
        	self.elapsed_time = 0
		end
	end,

	ProceedToNextAnimationInQueue = function(self)
		-- if there are multiple things in the queue, remove the first: it's done
		-- if #self.anim_queue > 1 then
		if #self.anim_queue > 0 then
			if #self.anim_queue > 1 then
				print("transitioning animation: "..self.anim_queue[1] .. " to " .. self.anim_queue[2])
			else
				print("emptying anim queue: going to idle")
			end
			table.remove(self.anim_queue, 1)
		end

		if #self.anim_queue < 1 then
			
			if self.facing == "right" then
				self:AddAnimationToQueue("idle")
			else
				self:AddAnimationToQueue("idle_back")
			end
		end
		-- end
		-- print("queue: "..self:AnimQueueToString())
	end,

	AnimQueueToString = function(self)
		local str = "{"
		for i, v in pairs(self.anim_queue) do
			str = str .. ", " .. self.anim_queue[i]
		end
		str = str .. " }"
		return str
	end

}