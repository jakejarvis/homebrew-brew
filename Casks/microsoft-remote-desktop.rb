cask 'microsoft-remote-desktop' do
  version '10.3.2'
  sha256 '0429c4f331d48698575e71267afb3361519e9f186de121ac83710e63137e633f'

  url "https://go.microsoft.com/fwlink/?linkid=868963"
  name 'Microsoft Remote Desktop'

  pkg "Microsoft_Remote_Desktop_#{version}_installer.pkg"

  zap trash: [
               '~/Library/Preferences/com.microsoft.rdc.macos',
               '~/Library/Caches/com.microsoft.rdc.macos',
               '~/Library/Application Support/com.microsoft.rdc.macos',
               '~/Library/Logs/Microsoft Remote Desktop',
               '~/Library/Application Support/Microsoft Remote Desktop',
             ]
end
