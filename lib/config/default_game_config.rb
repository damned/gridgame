require_relative 'game_config'

class DefaultGameConfig < GameConfig
  def initialize
    super
    with_size(20, 10).
    with_player_at(1, 8).
    with_destination_at(18, 1).
    with_blocker_at(4, 9).
    with_experience_builder_at(7, 6).
    with_charming_chain_at(1, 1).
    with_actor_at(14, 3)
  end
end