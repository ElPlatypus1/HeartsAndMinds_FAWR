
/* ----------------------------------------------------------------------------
Function: btc_fnc_eh_player

Description:
    Add event handler to player.

Parameters:
    _player - Player to add event. [Object]

Returns:
    _eventHandleID - ID of the WeaponAssembled event handle. [Number]

Examples:
    (begin example)
        _eventHandleID = [player] call btc_fnc_eh_player;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_player", objNull, [objNull]]
];

_player addEventHandler ["Respawn", format ["[%1] call btc_fnc_eh_player_respawn", getPosASL player]];
_player addEventHandler ["CuratorObjectPlaced", btc_fnc_eh_CuratorObjectPlaced];
["ace_treatmentSucceded", btc_fnc_eh_treatment] call CBA_fnc_addEventHandler;
_player addEventHandler ["WeaponAssembled", btc_fnc_civ_add_leaflets];
_player addEventHandler ["WeaponAssembled", {
    params [
        ["_player", objNull, [objNull]],
        ["_rallyPoint", objNull, [objNull]]
    ];

    if !(_rallyPoint isKindOf "Camping_base_F") exitWith {_this};

    [_rallyPoint] remoteExecCall ["btc_fnc_fob_init", [0, 2] select isDedicated];

    _this
}];

if (btc_p_chem) then {
     // Add biopsy
    [missionnamespace, "probingStarted", {
        btc_int_ask_data = nil;
        ["btc_chem_contaminated"] remoteExecCall ["btc_fnc_int_ask_var", 2];
    }] call BIS_fnc_addScriptedEventHandler;
    [missionnamespace, "probingEnded", btc_fnc_chem_biopsy] call BIS_fnc_addScriptedEventHandler;

     // Disable BI shower
    ["DeconShower_01_F", "init", {(_this select 0) setVariable ['bin_deconshower_disableAction', true];}] call CBA_fnc_addClassEventHandler;
    ["DeconShower_02_F", "init", {(_this select 0) setVariable ['bin_deconshower_disableAction', true];}] call CBA_fnc_addClassEventHandler;
};
