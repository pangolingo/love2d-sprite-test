require 'SpriteInstance'

SpriteManager = {
	serialization_version = 1.0,
	sprite_bank = {},
	image_bank = {},

	LoadSprite = function(self, sprite_name)
		if sprite_name == nil then return nil end

		--Load the sprite definition file to ensure it exists
		local definition_file = loadfile('sprites/'..sprite_name..'.lua')

		--If the file doesn't exist or has syntax errors, it'll be nil.
	    if definition_file == nil then
	        --Spit out a warning and return nil.
	        print("Attempt to load an invalid file (inexistent or syntax errors?): "..sprite_name)
	        return nil
	    end

	    self.sprite_bank[sprite_name] = definition_file()

	    -- skipping version check

	    -- load the image
	    local image_file = self.sprite_bank[sprite_name].sprite_sheet

	    --Load the image.
	    self.image_bank[image_file] = love.graphics.newImage(image_file)

	    --Check if the loaded image is valid.
	    if self.image_bank[image_file] == nil then
	        error("Failed loading sprite "..sprite_def..", invalid image path ( "..sprite_sheet.." ).")
	    end

	    return self.sprite_bank[sprite_name]

	end,

	GetInstance = function(self, sprite_name)
		if sprite_name == nil then return nil end

		if self.sprite_bank[sprite_name] == nil then
			loaded_sprite =  self.LoadSprite(self, sprite_name)
		end
		loaded_sprite = self.sprite_bank[sprite_name]

		if loaded_sprite == nil then return nil end

		return SpriteInstance:new(loaded_sprite)
	end,

	UpdateInstance = function(self, sprite_instance, dt)
		sprite_instance:Update(dt)
	end,

	DrawInstance = function(self, sprite_instance, x, y)
		love.graphics.draw (
	        self.image_bank[sprite_instance.sprite.sprite_sheet], --The image
	        --Current frame of the current animation
	        sprite_instance.sprite.animations[sprite_instance:GetCurrentAnimation()][sprite_instance.curr_frame],
	        x,
	        y,
	        sprite_instance.rotation,
	        sprite_instance.size_scale,
	        sprite_instance.size_scale,
	        flip_h,
	        flip_v
	    )
	end,

}