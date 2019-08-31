
/* ----------------------------------------------------------------------------
Function: btc_fnc_chem_propagate

Description:
    Propagate from the item or vehicle contaminated to the item or vehicle not contaminated.

Parameters:
    _item - Item. [Object]
    _vehicle - Vehicle. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject, vehicle player] call btc_fnc_chem_propagate;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_item", objNull, [objNull]],
    ["_vehicle", objNull, [objNull]]
];

if (_item in btc_chem_contaminated) then {
    btc_chem_contaminated pushBack _vehicle;
} else {
    if (_vehicle in btc_chem_contaminated) then {
        btc_chem_contaminated pushBack _item;
    };
};

_this
