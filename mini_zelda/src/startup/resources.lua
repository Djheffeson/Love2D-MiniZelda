sprites = {}
sounds = {}

sprites.linkSheet = love.graphics.newImage('assets/graphics/player_sheet.png')
sprites.woodenSword = love.graphics.newImage('assets/graphics/wooden_sword_sheet.png')
sprites.swordParticles = love.graphics.newImage('assets/graphics/sword_particles_sheet.png')

sprites.heart_full = love.graphics.newImage('assets/graphics/heart_full.png')
sprites.heart_half = love.graphics.newImage('assets/graphics/heart_half.png')
sprites.heart_empty = love.graphics.newImage('assets/graphics/heart_empty.png')

sprites.itemFrame = love.graphics.newImage('assets/graphics/item_frame.png')
sprites.guiItems = love.graphics.newImage('assets/graphics/gui_items.png')

sprites.redOctorokSheet = love.graphics.newImage('assets/graphics/red_octorok_sprite.png')
sprites.blueOctorokSheet = love.graphics.newImage('assets/graphics/blue_octorok_sprite.png')
sprites.octorok_projectile = love.graphics.newImage('assets/graphics/octorok_projectile.png')

sprites.zoraSheet = love.graphics.newImage('assets/graphics/zora_sheet.png')
sprites.zoraProjectileSheet = love.graphics.newImage('assets/graphics/zora_projectile_sheet.png')

sprites.tektikeSheet = love.graphics.newImage('assets/graphics/tektike_sheet.png')
sprites.leeverSheet = love.graphics.newImage('assets/graphics/leever_sheet.png')
sprites.peahatSheet = love.graphics.newImage('assets/graphics/peahat_sheet.png')

sprites.dungeonDoors = love.graphics.newImage('assets/graphics/dungeon_doors.png')

sprites.keese = love.graphics.newImage('assets/graphics/keese_sprites.png')
sprites.gel = love.graphics.newImage('assets/graphics/gel_sprite.png')
sprites.stalfo = love.graphics.newImage('assets/graphics/stalfos_sprite.png')

sprites.deathSheet = love.graphics.newImage('assets/graphics/death_sheet.png')
sprites.recoverHeart = love.graphics.newImage('assets/graphics/recovery_heart_sheet.png')
sprites.key = love.graphics.newImage('assets/graphics/key.png')
sprites.rupee = love.graphics.newImage('assets/graphics/rupee_sheet.png')

sounds.useSword = love.audio.newSource('assets/sounds/sword_slash.wav', 'stream')
sounds.swordShoot = love.audio.newSource('assets/sounds/sword_shoot.wav', 'stream')

sounds.enemyDie = love.audio.newSource('assets/sounds/enemy_die.wav', 'stream') 
sounds.enemyHit = love.audio.newSource('assets/sounds/enemy_hit.wav', 'stream')

sounds.lowHealth = love.audio.newSource('assets/sounds/low_health.wav', 'stream')
sounds.linkHurt = love.audio.newSource('assets/sounds/link_hurt.wav', 'stream')
sounds.pickupItem = love.audio.newSource('assets/sounds/pickup_item.wav', 'stream')
sounds.pickupRupee = love.audio.newSource('assets/sounds/pickup_rupee.wav', 'stream')

sounds.openDoor = love.audio.newSource('assets/sounds/door_unlock.wav', 'stream')
