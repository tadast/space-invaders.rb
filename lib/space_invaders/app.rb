require "gosu"
require 'pry'

require 'space_invaders/screens/welcome_screen'
require 'space_invaders/screens/game_over_screen'
require 'space_invaders/screens/next_level_screen'

require 'space_invaders/invaders_container'
require 'space_invaders/ship'
require 'space_invaders/score_tracker'
require 'space_invaders/lives_tracker'
require 'space_invaders/images'
require 'space_invaders/sounds'
require 'space_invaders/base'
require 'space_invaders/game_status'
require 'space_invaders/button_controller'
require 'space_invaders/red_invader'
require 'space_invaders/u_block'
require 'space_invaders/u_block_container'
require 'space_invaders/utils'

module SpaceInvaders
  class App < Gosu::Window

    DEFAULT_FONT = "assets/fonts/unifont.ttf"

    STATICS = :game_status, :button_controller, :images, :sounds, 
              :welcome_screen, :game_over_screen, :next_level_screen
    TRACKERS = :lives_tracker, :score_tracker
    DYNAMICS = :ship, :invaders_container, :u_block_container, :red_invader

    attr_reader *STATICS, *TRACKERS, *DYNAMICS

    def initialize width=800, height=600, fullscreen=false
      super
      self.caption = "Sprite Demonstration"
      initialize_statics
      initialize_dynamics_and_trackers
    end

    def button_down id
      button_controller.button_down id
    end

    def update
      if game_status.drowned_ship?
        ship.update
      elsif game_status.being_played?
        update_dynamics
      end
    end

    def draw
      if game_status.hasnt_started?
        welcome_screen.draw
      elsif game_status.next_level?
        next_level_screen.draw
      elsif game_status.drowned_ship? or game_status.being_played?
        draw_dynamics
        draw_trackers
      elsif game_status.finished?
        game_over_screen.draw
      end
    end

    def initialize_statics
      define_properties *STATICS
    end

    def initialize_dynamics_and_trackers
      define_properties *DYNAMICS, *TRACKERS
    end

    def draw_dynamics
      DYNAMICS.each {|dynamic_element| self.send(dynamic_element).draw}
    end

    def draw_trackers
      TRACKERS.each {|tracker_element| self.send(tracker_element).draw}
    end

    def update_dynamics
      DYNAMICS.each {|dynamic_element| self.send(dynamic_element).update}
    end

    private

      def define_properties(*properties)
        properties.each do |property|
          instance_variable_set "@#{property}", Utils.to_klass(property).new(self)
        end
      end

  end
end