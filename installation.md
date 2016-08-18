ATTENTION!
All code from prior versions of 2.0.0 MUST be removed from the init.sqf and the descriptions.ext!

### Step 1
Place the sarge PBO inside the @ExileServer\addons folder.

### Step 2
Place the ratingFix.sqf inside the mission root then open the config.cpp file in the mission PBO root and search for the word CfgExileCustomCode and make it look like the following: 
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
	ExileClient_system_rating_balance = "ratingFix.sqf";
};
```

### Step 3 InfiniStar (Optional)
In the EXILE_AH.sqf file do a search for rating. This should be line 793 and should look like the below. Remove this line:
```html
if(rating player < 999999)then{player addRating 9999999;};
```
Then look for this about line 3955:
```html
if(_rating < 500000)then
```
Now change it to this:
```html
if(0==1)then
```

If you want to make changes in the sarge code then unpackage the PBO, make changes and repackage. Most customizations can be found in the SAR_config.sqf file.
