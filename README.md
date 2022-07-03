# Driver School
🅿 Best driving school for qb-core framework 🅿

## Dependencies:
- [qb-core](https://github.com/qbcore-framework/qb-core) -Main framework
- [qb-target](https://github.com/BerkieBb/qb-target)

## Preview:
[Preview - Youtube](https://youtu.be/MDoQ--jluQg)

## Features(All in one):
- Many classes of driver's license
- Edited and inspired by esx_dmvschool
- Support multiple languages
- You can translate through your language easily through `locales\yourlang.lua`
- Easy configuration via `config.lua`

## Installation:

### Manual:
- Download the script and put it in the `resources` directory.
- Add the following code to your server.cfg/resouces.cfg
```
ensure drivingschool
```
### Edit the resources according to the following instructions:

#### qb-hud:

- Add to qb-hud\client.lua:

```
local function checkseatbelt()
	return seatbeltOn
end

exports('checkseatbelt', checkseatbelt)
```