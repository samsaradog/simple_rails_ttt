class Invite < ActionMailer::Base
  default from: "tictactoe@8thlight.com"
  
  def tic_tac_toe(address,link)
    @link = link
    mail to: address, subject: "Come play Tic-Tac-Toe" 
  end
  
  def activation_needed_email(player,host)
    @player = player
    @url = "#{host}/players/activate/#{player.activation_token}"
    mail to: player.email, subject: "Please activate your Tic-Tac-Toe account"
  end
  
end
