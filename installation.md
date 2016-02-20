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
Download and extract the sarge and scripts folders  to the root of the mission folder

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
### Step 4
Repackage your mission PBO and enjoy!
