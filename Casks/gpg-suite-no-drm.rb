cask 'gpg-suite-no-drm' do
  version '2019.1_83'
  sha256 '446f80f96ad57a93a657a66f4dc5ce3833aed94c7bd3d5dc839ac5fada0b5a6d'

  url "https://github.com/GpgMailNoActivation/GpgMailNoActivation/releases/download/Ver_#{version}/RemoveGPGMailDRM_#{version}.dmg"
  appcast 'https://github.com/GpgMailNoActivation/GpgMailNoActivation/releases.atom'
  name 'GPG Suite No DRM'
  homepage 'https://github.com/GpgMailNoActivation/GpgMailNoActivation'

  depends_on macos: '>= sierra'
  depends_on cask: 'gpg-suite'
  conflicts_with cask: 'gpg-suite-no-mail'

  # move bundles out of DMG and into Application Support
  artifact 'GPGMail_13.mailbundle', target: '/Library/Application Support/GPGTools/GPGMail/GPGMail_13.mailbundle'
  artifact 'GPGMail_14.mailbundle', target: '/Library/Application Support/GPGTools/GPGMail/GPGMail_14.mailbundle'

  # save DRM'ed bundle in case of uninstall
  preflight do
    system_command '/bin/mv',
                    args: [
                            '/Library/Application Support/GPGTools/GPGMail/GPGMail_14.mailbundle',
                            '/Library/Application Support/GPGTools/GPGMail/GPGMail_14.mailbundle.drm'
                          ],
                    sudo: true
  end
  
  # on uninstall, restore DRM'ed GPGMail_14.mailbundle and delete GPGMail_13.mailbundle
  uninstall_postflight do
    system_command '/bin/mv',
                    args: [
                            '/Library/Application Support/GPGTools/GPGMail/GPGMail_14.mailbundle.drm',
                            '/Library/Application Support/GPGTools/GPGMail/GPGMail_14.mailbundle'
                          ],
                    sudo: true
  end
end
