### Step 1
In the init.sqf file at the top add:
```html
call compile preprocessFileLineNumbers "scripts\Init_UPSMON.sqf";
[] execVM "sarge\SAR_AI_init.sqf";
```
### Step 2
At the bottom of the description.ext file add this line:
```html
#include "sarge\SAR_define.hpp"
```

### Step 3
Open the config.cpp file in the mission PBO root and search for the word CfgExileCustomCode and make it look like the following:
```html
class CfgExileCustomCode 
{
	/*
		You can overwrite every single file of our code without touching it.
		To do that, add the function name you want to overwrite plus the 
		path to your custom file here. If you wonder how this works, have a
		look at our bootstrap/fn_preInit.sqf function.

		Simply add the following scheme here:

		<Function Name of Exile> = "<New File Name>";

		Example:

		ExileClient_util_fusRoDah = "myaddon\myfunction.sqf";
	*/
	ExileClient_system_rating_balance = "sarge\ratingFix.sqf";
};
```

### Step 4
Download and extract the sarge and scripts folders  to the root of the mission folder

### Step 5
Repackage your mission PBO and enjoy!

### InfiniStar
In the EXILE_AH.sqf file inside the PBO do a search for rating. This should be line 793 and should look like the below. Remove this line:
```html
if(rating player < 999999)then{player addRating 9999999;};
```
Then look for this about line 3955 and remove it to stop log spamming:
```html
_rating = rating _x;
if(_rating < 500000)then
{
  if(_rating isEqualTo 0)exitWith{};
  _RatingCheckTries = _x getVariable['RatingCheckTries',0];
  if(_RatingCheckTries > 2)then
  {
  	_x setVariable['RatingCheckTries',_RatingCheckTries + 1];
  }
  else
  {
    _log = format['Player Low Rating! %1 - %2 - @%3 %4',_rating,_xtype,getPos _x,mapGridPosition _x];
    [_name,_uid,'HLOG_SKICK',toArray(_log)] call "+_FNC_AH_KICKLOG+";
  };
};
```
