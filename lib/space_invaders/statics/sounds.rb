require 'space_invaders/base'
module SpaceInvaders
  class Sounds < Base

    def ship_hit_sound
      @ship_hit_sound ||= Gosu::Sample.new(app, "assets/sounds/ShipHit.wav")
    end
  
    def ship_bullet_sound
      @ship_bullet_sound ||= Gosu::Sample.new(app, "assets/sounds/ShipBullet.wav")
    end

    def invader_hit_sound
      @invader_hit_sound ||= Gosu::Sample.new(app, "assets/sounds/InvaderHit.wav")
    end

    def invader_bullet_sound
      @invader_bullet_sound ||= Gosu::Sample.new(app, "assets/sounds/InvaderBullet.wav")
    end

    def play_ship_hit!
      ship_hit_sound.play volume=0.5
    end

    def play_ship_fire!
      ship_bullet_sound.play volume=0.05
    end

    def play_invader_hit!
      invader_hit_sound.play volume=0.5
    end

    def play_invader_fire!
      invader_bullet_sound.play volume=0.05
    end
  end
end