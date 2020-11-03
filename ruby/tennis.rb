class TennisGame1
  def initialize(player1Name, player2Name)
    @player1Name = player1Name
    @player2Name = player2Name
    @p1points = 0
    @p2points = 0
  end

  def score
    if even?
      evenMessage(@p1points)
    elsif win_or_advantage?
      winOrAdvantageMessage(@p1points, @p2points)
    else
      normalMessage(@p1points, @p2points)
    end
  end

  def won_point(playerName)
    if playerName == 'player1'
      @p1points += 1
    else
      @p2points += 1
    end
  end

  private

  def evenMessage(score)
    {
      0 => 'Love-All',
      1 => 'Fifteen-All',
      2 => 'Thirty-All'
    }.fetch(score, 'Deuce')
  end

  def winOrAdvantageMessage(p1_score, p2_score)
    diff = p1_score - p2_score

    if diff >= 2
      'Win for player1'
    elsif diff == 1
      'Advantage player1'
    elsif diff == -1
      'Advantage player2'
    else
      'Win for player2'
    end
  end

  def even?
    @p1points == @p2points
  end

  def win_or_advantage?
    @p1points >= 4 or @p2points >= 4
  end

  def normalMessage(p1_score, p2_score)
    "#{score_name(p1_score)}-#{score_name(p2_score)}"
  end

  def score_name(score)
    {
      0 => 'Love',
      1 => 'Fifteen',
      2 => 'Thirty',
      3 => 'Forty'
    }[score]
  end
end

class TennisGame2
  def initialize(player1Name, player2Name)
    @player1Name = player1Name
    @player2Name = player2Name
    @p1points = 0
    @p2points = 0
  end

  def won_point(playerName)
    if playerName == @player1Name
      p1Score
    else
      p2Score
    end
  end

  def score
    if @p1points == @p2points
      even_message
    elsif @p1points > @p2points
      p1_stronger_message
    elsif @p2points > @p1points
      p2_stronger_message
    end
  end

  def p2_stronger_message
    return 'Win for ' + @player2Name if p2wins?
    return 'Advantage ' + @player2Name if @p2points > 3

    normal_message
  end

  def p1_stronger_message
    return 'Win for ' + @player1Name if p1wins?
    return 'Advantage ' + @player1Name if @p1points > 3

    normal_message
  end

  def even_message
    return 'Deuce' if @p1points > 2

    name_of(@p1points) + '-All'
  end

  def normal_message
    name_of(@p1points) + '-' + name_of(@p2points)
  end

  def name_of(score)
    {
      0 => 'Love',
      1 => 'Fifteen',
      2 => 'Thirty',
      3 => 'Forty'
    }[score]
  end

  def p1wins?
    (@p1points >= 4) && ((@p1points - @p2points) >= 2)
  end

  def p2wins?
    (@p2points >= 4) && ((@p2points - @p1points) >= 2)
  end

  def setp1Score(number)
    (0..number).each do |_i|
      p1Score
    end
  end

  def setp2Score(number)
    (0..number).each do |_i|
      p2Score
    end
  end

  def p1Score
    @p1points += 1
  end

  def p2Score
    @p2points += 1
  end
end

class TennisGame3
  def initialize(player1Name, player2Name)
    @p1N = player1Name
    @p2N = player2Name
    @p1 = 0
    @p2 = 0
  end

  def won_point(n)
    if n == @p1N
      @p1 += 1
    else
      @p2 += 1
    end
  end

  def score_name(score)
    %w[Love Fifteen Thirty Forty][score]
  end

  def score
    if normal_or_all?
      p1_score_name = score_name(@p1)
      even? ? p1_score_name + '-All' : p1_score_name + '-' + score_name(@p2)
    else
      if even?
        'Deuce'
      else
        winner = @p1 > @p2 ? @p1N : @p2N
        (@p1 - @p2).abs == 1 ? 'Advantage ' + winner : 'Win for ' + winner
      end
    end
  end

  def normal_or_all?
    not_duce = (@p1 + @p2 < 6)
    [@p1, @p2].max < 4 && not_duce
  end

  def even?
    @p1 == @p2
  end
end
