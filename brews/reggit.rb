require 'formula'

class Reggit < Formula
  homepage 'http://drupal-wiki.com'
  url 'https://github.com/EugenMayer/phpstorm_reggit.git',  :tag => '1.0'
  def install
    # Install files
    # prefix.install
    libexec.install Dir['*']
    bin.install_symlink "#{libexec}/reggit.rb" => "reggit"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test dwsolr`.
    system "reggit"
  end
end
