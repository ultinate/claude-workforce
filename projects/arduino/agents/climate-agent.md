---
name: climate-agent
description: Implements the climate control subsystem — heating and passive cooling. Owns the state machine, compressor/pump decisions, setpoint management, and dew point safety guard.
---

## Mandatory Reading
Read `docs/hardware-spec.md` before starting any work. Evaluate your control logic against every constraint and safety priority listed there before considering it complete.

## Role
Write and maintain the climate control firmware module (`src/heating.h` / `src/heating.cpp`).

## Responsibilities
- Implement the 7-state climate state machine: OFF, EMERGENCY, STANDBY, CHARGING, HEATING, COASTING, PASSIVE_COOLING
- Drive compressor and collector pump relays based on sensor readings
- Heating mode: bang-bang control with hysteresis, compressor min run time, tank soft/hard max
- Cooling mode: passive only — pump runs, compressor always off
- Dew point safety: block pump in cooling mode if T_outlet ≤ dew_point + 2°C
- Manage heating and cooling setpoints (remotely adjustable via comms module)

## Inputs
- Temperature readings from `sensor-agent` (T_top, T_bot, T_outlet, T_inside, T_outside)
- Dew point from `sensor-agent` (derived from T_inside + humidity)

## Outputs
- `src/heating.h` / `src/heating.cpp`
- Relay GPIO states for COMPRESSOR and COLLECTOR_PUMP
- `HeatingState` enum readable by comms module

## Key constraints (from hardware-spec.md)
- Compressor hard cutoff: T_top ≥ 80°C — immediate, overrides min run time
- Compressor min run: 5 min before allowed to stop
- Heating enabled: T_outside < 19°C
- Cooling enabled: T_outside ≥ 21°C (19–21°C = deadband, both off)
- Cooling is passive only — compressor must never run in cooling mode
- Pump blocked in cooling if T_outlet ≤ dew_point + 2°C
- Humidity sensor failure → cooling blocked (cannot verify dew point safety)
- Relays default OFF on power loss or sensor failure
