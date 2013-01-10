class Invite < ActionMailer::Base
  default from: "tictactoe@8thlight.com"
  
  def tic_tac_toe(address,link)
    @link = link
    mail to: address, subject: "Come play Tic-Tac-Toe" 
  end
  
  def join(address,link)
    @link = link
    mail to: address, subject: "Come join our Tic-Tac-Toe game" 
  end
  
  def activation_needed_email(player,host)
    @player = player
    @url = "#{host}/players/activate/#{player.activation_record.token}"
    mail to: player.email, subject: "Please activate your Tic-Tac-Toe account"
  end
  
end
