fx_version 'cerulean'
game 'gta5'

lua54 'yes'

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'locales/*.lua',
	'client/main.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'locales/*.lua',
	'server/main.lua'
}

ui_page 'html/ui.html'

files {
	'html/ui.html',
    'html/style.css',
    'html/media/font/Bariol_Regular.otf',
    'html/media/font/Vision-Black.otf',
    'html/media/font/Vision-Bold.otf',
    'html/media/font/Vision-Heavy.otf',
    'html/media/img/bg.png',
    'html/media/img/circle.png',
    'html/media/img/curve.png',
    'html/media/img/fingerprint.png',
    'html/media/img/fingerprint.jpg',
    'html/media/img/graph.png',
    'html/media/img/logo-big.png',
    'html/media/img/logo-top.png'
}
