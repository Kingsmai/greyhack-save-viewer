# Config OS

## Same

### Metadata

- Boolean
  - Is Rented
  - Saved?
  - Override Settings?
  - Override Used?
- Value
  - Pc Name
  - Public IP
  - Local IP
  - Active Net Card
  - Original Public IP
  - Last Reboot
- Array / Dict
  - Ports
  - Services
  - Person（Personas）
  - Saved Networks

### Saved Networks

```json
[
  {
    "bssid": "1F:7E:4D:F1:A9:62",
    "essid": "Oncorde_YRXH",
    "password": "Ondsay",
    "publicIp": "34.124.230.139"
  }
]
```

### Services

```json
[
  {
    "ID": 2,
    "puerto": 8080,
    "pathExe": "/server/",
    "pathDb": "/server/conf/",
    "nomdb": "httpd.conf",
    "nomexe": "httpd",
    "probabilidad": 0,
    "isClosed": false
  }
]
```

## Router

### Metadata

- Boolean
  - is Home Network
- Value
  - Router Password
- Array / Dict
  - Reverse Shells
  - Network Lan

### Reverse Shells

```json
{
  "28.39.29.213:401115745": {
    "puerto": 1222,
    "userName": "Ermannan",
    "PID": 1975,
    "netID": "28.39.29.213:401115745"
  },
  "53.211.234.145:1322017256": {
    "puerto": 1222,
    "userName": "Tolmsle",
    "PID": 5220,
    "netID": "53.211.234.145:1322017256"
  },
  "179.24.234.5:1705608959": {
    "puerto": 1222,
    "userName": "Cokes",
    "PID": 8950,
    "netID": "179.24.234.5:1705608959"
  }
}
```

## Player Computer

- Value
  - player ID
  - wallet ID
  - Coin Name
  - Coin Pass
  - Coupons
- Dict
  - User Mail
  - User Bank
- Unknown
  - CTF Credentials
  - ISP Gateway Eth
  - ISP Local IP Eth
  - Rental Home IP

### User Mail

```json
{
  "userName": "xiaomai@humemejaf.info",
  "password": "iamhacker",
  "encPassword": "78a1cdefcb87a7d3a9af3570416c2a93"
}
```

### User Bank

```json
{
  "userName": "KUeJKRb6-erazewac.info",
  "password": "iammillionaire",
  "encPassword": "fde17cae1cbdd9ccd04569ba01f8099b"
}
```
