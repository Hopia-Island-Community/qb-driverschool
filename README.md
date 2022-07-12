# Driver School
🅿 Best driving school for qb-core framework 🅿

## Dependencies:
- [qb-core](https://github.com/qbcore-framework/qb-core) -Main framework
- [qb-target](https://github.com/BerkieBb/qb-target)

## Preview:
[Preview - Youtube](https://youtu.be/MDoQ--jluQg)

## Features(All in one):
- A modern display
- Create all formation you want
- A completely customizable theory test
- Support multiple languages
- You can translate through your language easily through `locales\yourlang.lua`
- Easy configuration via `config.lua` and `html/config.js`


## Installation:

### Manual:
- Download the script and put it in the `resources` directory.
- Add the following code to your server.cfg/resouces.cfg
```
ensure qb-driverschool
```
## Use seatbelt checker
In order to be able to use the seat belt check you need to make some changes. By default, qb-hud doesn't export any function to check this, it's up to you to add it like this:

- Add to qb-hud\client.lua:
```lua
local function checkseatbelt()
	return seatbeltOn
end

exports('checkseatbelt', checkseatbelt)
```
- Change the qb-driverschool/client/cl_customise.lua:
```lua
function  Checkseatbelt()
	if not Config.seatbelt  then  return  true  end
	return  exports['qb-hud']:checkseatbelt()
end
```
If you use another script to manage the belts, you will have to check if an export exists and replace the `exports['cd_carhud']:checkseatbelt()` with this other exported function