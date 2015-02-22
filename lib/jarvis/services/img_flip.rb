
# Require All Supported Memes
Dir[File.dirname(__FILE__) + '/img_flip_memes/*.rb'].each {|file| require file }

class ImgFlip < Jarvis::Service
  interpreter_pattern /you're gonna have a bad time|
    and it'?s gone|
    afraid to ask|
    sudden clarity|
    success kid|
    not sure if|
    picard|
    one does not simply|
    y u no|
    what if i told you|
    willy wonka|
    overly attached girlfriend|
    everywhere|
    i don'?t always.+but when i do'?/xi

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
    end
  end

  def create_meme
    self.meme_link = meme_class.new(text, imgflip_user, imgflip_password).create_meme
  end

end
