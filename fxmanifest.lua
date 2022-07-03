fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Devix'
version '0.5.0'
description 'Driving School'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/fr.lua', -- Change this to your preferred language
	'config.lua'
}

server_scripts {
	'server.lua'
}

client_scripts {
	'client/client.lua',
	'client/drivingTest.lua'
}

ui_page 'html/ui.html'

files {
	'html/configs.js',
	'html/css/**.css',
	'html/js/**.js',
	'html/resources/**',
	'html/ui.html',
}

escrow_ignore {
	'config.lua',
	'locales/**'
}