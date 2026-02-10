============================================================
# NTP Synchronization Report — ptaeecat001
============================================================

## 1. Summary
- Server: `ptaeecat001.estonia.confidens`
- Primary source marked with `^*`

---
## 2. Source Status (chronyc sources)
```

  .-- Source mode  '^' = server, '=' = peer, '#' = local clock.
 / .- Source state '*' = current best, '+' = combined, '-' = not combined,
| /             'x' = may be in error, '~' = too variable, '?' = unusable.
||                                                 .- xxxx [ yyyy ] +/- zzzz
||      Reachability register (octal) -.           |  xxxx = adjusted offset,
||      Log2(Polling interval) --.      |          |  yyyy = measured offset,
||                                \     |          |  zzzz = estimated error.
||                                 |    |           \
MS Name/IP address         Stratum Poll Reach LastRx Last sample               
===============================================================================
^+ ptaeentp001.estonia.conf>     1   7   377    47    -80us[  -80us] +/- 1558us
^* ptaeentp002.estonia.conf>     1   6   377    47   +108us[ +146us] +/- 1252us
```

---
## 3. Tracking Status (chronyc tracking)
```
Reference ID    : 0A2900DB (ptaeentp002.estonia.confidens)
Stratum         : 2
Ref time (UTC)  : Tue Feb 10 11:54:11 2026
System time     : 0.000038185 seconds fast of NTP time
Last offset     : +0.000038266 seconds
RMS offset      : 0.000068576 seconds
Frequency       : 15.491 ppm fast
Residual freq   : -0.000 ppm
Skew            : 0.020 ppm
Root delay      : 0.000519172 seconds
Root dispersion : 0.001044373 seconds
Update interval : 64.5 seconds
Leap status     : Normal
```

---
## 4. Source Statistics (chronyc sourcestats)
```
Name/IP Address            NP  NR  Span  Frequency  Freq Skew  Offset  Std Dev
==============================================================================
ptaeentp001.estonia.conf>  14   6   906     -0.008      0.153   -103us    38us
ptaeentp002.estonia.conf>  13  10   21m     +0.000      0.018   +110us  6636ns
```

---
## 5. Overall Health Assessment
- Primary source line: `^* ptaeentp002.estonia.conf>     1   6   377    47   +108us[ +146us] +/- 1252us`
- Primary offset: 108 µs (abs: 108 µs)
- Status: **OK**

Thresholds:
- Warning  > 5 ms  (5000 µs)
- Critical > 20 ms (20000 µs)

---
## 6. Notes
- Offset evaluated as absolute value.
- Persistent WARN/CRITICAL → check network path + NTP appliance health.

============================================================
# NTP Synchronization Report — ptaeecat002
============================================================

## 1. Summary
- Server: `ptaeecat002.estonia.confidens`
- Primary source marked with `^*`

---
## 2. Source Status (chronyc sources)
```

  .-- Source mode  '^' = server, '=' = peer, '#' = local clock.
 / .- Source state '*' = current best, '+' = combined, '-' = not combined,
| /             'x' = may be in error, '~' = too variable, '?' = unusable.
||                                                 .- xxxx [ yyyy ] +/- zzzz
||      Reachability register (octal) -.           |  xxxx = adjusted offset,
||      Log2(Polling interval) --.      |          |  yyyy = measured offset,
||                                \     |          |  zzzz = estimated error.
||                                 |    |           \
MS Name/IP address         Stratum Poll Reach LastRx Last sample               
===============================================================================
^+ ptaeentp001.estonia.conf>     1   8   377   241   -204us[ -216us] +/- 1638us
^* ptaeentp002.estonia.conf>     1   7   377   116   -113us[ -125us] +/- 1561us
```

---
## 3. Tracking Status (chronyc tracking)
```
Reference ID    : 0A2900DB (ptaeentp002.estonia.confidens)
Stratum         : 2
Ref time (UTC)  : Tue Feb 10 11:53:03 2026
System time     : 0.000045404 seconds slow of NTP time
Last offset     : -0.000012087 seconds
RMS offset      : 0.000112576 seconds
Frequency       : 9.925 ppm fast
Residual freq   : -0.000 ppm
Skew            : 0.025 ppm
Root delay      : 0.000487277 seconds
Root dispersion : 0.001242496 seconds
Update interval : 128.9 seconds
Leap status     : Normal
```

---
## 4. Source Statistics (chronyc sourcestats)
```
Name/IP Address            NP  NR  Span  Frequency  Freq Skew  Offset  Std Dev
==============================================================================
ptaeentp001.estonia.conf>  25  11   29m     -0.109      0.207   -164us   138us
ptaeentp002.estonia.conf>  22   9   31m     +0.001      0.024   +138us    16us
```

---
## 5. Overall Health Assessment
- Primary source line: `^* ptaeentp002.estonia.conf>     1   7   377   116   -113us[ -125us] +/- 1561us`
- Primary offset: -113 µs (abs: 113 µs)
- Status: **OK**

Thresholds:
- Warning  > 5 ms  (5000 µs)
- Critical > 20 ms (20000 µs)

---
## 6. Notes
- Offset evaluated as absolute value.
- Persistent WARN/CRITICAL → check network path + NTP appliance health.
