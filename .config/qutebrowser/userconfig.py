c.content.geolocation = False
c.content.mouse_lock = False
c.content.notifications.enabled = False
c.content.register_protocol_handler = False

c.downloads.position = 'bottom'
c.downloads.remove_finished = 10000
c.tabs.position = 'top'

c.editor.command = ['nvim', '-f', '{file}', '-c', 'normal {line}G{column0}l']
c.spellcheck.languages = ["en-US", "ru-RU"]

config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')
config.bind('D', 'tab-close')

config.unbind('r')
config.unbind('d')

config.bind(',p', 'spawn --userscript qute-pass --dmenu-invocation dmenu')
config.bind(',P', 'spawn --userscript qute-pass --dmenu-invocation dmenu --password-only')
config.bind(',m', 'spawn mpv {url}')
config.bind(',t', 'set content.proxy system')
config.bind(',T', 'set content.proxy socks://localhost:9050/')
config.bind('X', 'hint links spawn linkhandler "{hint-url}"')

