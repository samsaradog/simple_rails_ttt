class Invite < ActionMailer::Base
  default from: "tictactoe@8thlight.com"
  
  def tic_tac_toe(address,link)
    @link = link + wpmiwke_path
    mail to: address, subject: "Come play Tic-Tac-Toe" 
  end
end
