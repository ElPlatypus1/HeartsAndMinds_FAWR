btc_cache_obj = selectRandom btc_cache_type createVehicle btc_cache_pos;
btc_cache_obj setPosATL btc_cache_pos;
btc_cache_obj setDir (random 360);

clearWeaponCargoGlobal btc_cache_obj;
clearItemCargoGlobal btc_cache_obj;
clearMagazineCargoGlobal btc_cache_obj;

btc_cache_obj addEventHandler ["HandleDamage", btc_fnc_cache_hd_cache];

private _pos_type_array = ["TOP", "FRONT", "CORNER_L", "CORNER_R"];

for "_i" from 1 to (1 + round random 3) do {
    private _holder = createVehicle ["groundWeaponHolder", btc_cache_pos, [], 0, "can_collide"];
    _holder addWeaponCargoGlobal [selectRandom btc_cache_weapons_type, 1];
    _holder setVariable ["no_cache", true];

    private _pos_type = selectRandom _pos_type_array;
    _pos_type_array = _pos_type_array - [_pos_type];
    [btc_cache_obj, _holder, _pos_type] call btc_fnc_cache_create_attachto;
};

if (btc_debug_log) then {
    diag_log format ["CACHE SPAWNED: ID %1 POS %2", btc_cache_n, btc_cache_pos];
};

if (btc_debug) then {
    systemChat format ["Cache spawned in %1", btc_cache_pos];
    //Marker
    private _marker = createMarker [format ["%1", btc_cache_pos], btc_cache_pos];
    _marker setMarkerType "mil_unknown";
    _marker setMarkerText format ["Cache %1", btc_cache_n];
    _marker setMarkerSize [0.8, 0.8];
};
