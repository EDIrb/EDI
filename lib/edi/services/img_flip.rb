require 'edi/services/img_flip_memes/base_meme'
# Require All Supported Memes
Dir[File.dirname(__FILE__) + '/img_flip_memes/*.rb'].each {|file| require file }

class ImgFlip < EDI::Service
  interpreter_pattern /you're gonna have a bad time|and it'?s gone|afraid to ask|sudden clarity|success kid|not sure if|picard|one does not simply|y u no|what if i told you|willy wonka|overly attached girlfriend|everywhere|i don'?t always.+but when i do'?/i

  environment :imgflip_user, :imgflip_password
  before_invoke :create_meme

  attr_accessor :meme_link

  def run
    "Here you go, #{user_name}\n\n#{meme_link}"
  end

private

  def meme_class
    case text
    when /success kid/i
      ImgFlipMemes::SuccessKid
    when /afraid to ask/i
      ImgFlipMemes::AfraidToAsk
    when /and it'?s gone/i
      ImgFlipMemes::AndItsGone
    when /everywhere/i
      ImgFlipMemes::Everywhere
    when /you're gonna have a bad time/i
      ImgFlipMemes::GonnaHaveABadTime
    when /i don'?t always.+but when i do/i
      ImgFlipMemes::MostInterestingMan
    when /not sure if/i
      ImgFlipMemes::NotSureIf
    when /one does not simply/i
      ImgFlipMemes::OneDoesNotSimply
    when /overly attached girlfriend/i
      ImgFlipMemes::OverlyAttachedGirlfriend
    when /picard/i
      ImgFlipMemes::Picard
    when /sudden clarity/i
      ImgFlipMemes::SuddenClarity
    when /what if I told you/i
      ImgFlipMemes::WhatIfIToldYou
    when /willy wonka/i
      ImgFlipMemes::WillyWonka
    when /y u no/i
      ImgFlipMemes::YUNo
    end
  end

  def create_meme
    self.meme_link = meme_class.new(message, imgflip_user, imgflip_password).create_meme
  end

end
