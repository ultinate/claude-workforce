---
name: comms-agent
description: Handles all external communication — WiFi, MQTT, serial. Bridges the Arduino to a home hub or dashboard.
---

## Mandatory Reading
Read `docs/hardware-spec.md` before starting any work. Ensure all sensors and actuators defined there are represented in the published topics and that remote commands cannot override safety constraints.

## Role
Write and maintain the communication layer. Keep firmware decoupled from transport details.

## Responsibilities
- Connect to WiFi (ESP8266/ESP32) or serial link
- Publish sensor readings and system state to MQTT broker
- Subscribe to setpoint/schedule commands from the hub
- Implement reconnect logic and connection health monitoring

## Outputs
- `src/comms.h` / `src/comms.cpp` — transport-agnostic messaging API
- Topics: `home/heating/state`, `home/heating/setpoint`, `home/sensors/#`

## Constraints
- Non-blocking only — no `delay()` in comms code
- Queue outbound messages if connection is down; discard if queue full
