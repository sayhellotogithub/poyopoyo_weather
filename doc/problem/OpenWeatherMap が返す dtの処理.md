OpenWeatherMapの`dt`を日本時間に変える必要があります。

OpenWeatherMap APIでは、天気予報データに含まれる時間（`dt`）は**UTC（協定世界時）形式のUNIXタイムスタンプ（秒）です。

Flutterアプリで日本のユーザー向けに**日本時間（JST）で表示したい**場合、`DateTime`クラスを使って変換する必要があります。

### OpenWeatherMapの`dt`と`dt_txt`の違いに注意！

APIレスポンス例（抜粋）：

```json
{
  "dt": 1753110000,
  "dt_txt": "2025-07-21 15:00:00"
}
```

- `dt`: **UTC基準**のUNIXタイムスタンプ（秒）
- `dt_txt`: **UTC基準の時刻文字列**

> ⚠️注意：「`dt_txt`: "2025-07-21 15:00:00"」は**日本時間の15時ではなく、UTCの15時**を意味します。

#### つまりどうなる？

```
UTC 2025-07-21 15:00:00 +09:00 = JST 2025-07-22 00:00:00
```

```
→ 日本で表示する場合は、「7月22日 0時」とするのが正しい！
```

### UTC → 日本時間に変換する方法

Flutterでは以下のように変換できます：

```dart
final localDateTime = DateTime.fromMillisecondsSinceEpoch(dt * 1000).toLocal();
```

- `dt * 1000`: 秒 → ミリ秒 に変換（Dartの`DateTime`はミリ秒単位）
- `.toLocal()`: 端末のローカルタイムゾーン（日本ならJST）に自動変換

#### 資源

API

```
https://api.openweathermap.org/data/2.5/forecast?q=%E5%A4%A7%E9%98%AA%E5%B8%82&appid={{appid}}&units=metric&lang=ja
```

#### json

```
{
    "cod": "200",
    "message": 0,
    "cnt": 40,
    "list": [
        {
            "dt": 1753110000,
            "main": {
                "temp": 29.45,
                "feels_like": 31.64,
                "temp_min": 28.88,
                "temp_max": 29.45,
                "pressure": 1016,
                "sea_level": 1016,
                "grnd_level": 1012,
                "humidity": 59,
                "temp_kf": 0.57
            },
            "weather": [
                {
                    "id": 803,
                    "main": "Clouds",
                    "description": "曇りがち",
                    "icon": "04n"
                }
            ],
            "clouds": {
                "all": 61
            },
            "wind": {
                "speed": 2.81,
                "deg": 255,
                "gust": 4.81
            },
            "visibility": 10000,
            "pop": 0.1,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2025-07-21 15:00:00"
        },
        {
            "dt": 1753120800,
            "main": {
                "temp": 28.49,
                "feels_like": 31.65,
                "temp_min": 27.87,
                "temp_max": 28.49,
                "pressure": 1016,
                "sea_level": 1016,
                "grnd_level": 1011,
                "humidity": 70,
                "temp_kf": 0.62
            },
            "weather": [
                {
                    "id": 803,
                    "main": "Clouds",
                    "description": "曇りがち",
                    "icon": "04n"
                }
            ],
            "clouds": {
                "all": 74
            },
            "wind": {
                "speed": 1.95,
                "deg": 249,
                "gust": 3.74
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2025-07-21 18:00:00"
        },
        {
            "dt": 1753131600,
            "main": {
                "temp": 27.87,
                "feels_like": 31.92,
                "temp_min": 27.87,
                "temp_max": 27.87,
                "pressure": 1017,
                "sea_level": 1017,
                "grnd_level": 1012,
                "humidity": 81,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 802,
                    "main": "Clouds",
                    "description": "雲",
                    "icon": "03d"
                }
            ],
            "clouds": {
                "all": 48
            },
            "wind": {
                "speed": 1.07,
                "deg": 249,
                "gust": 1.97
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-21 21:00:00"
        },
        {
            "dt": 1753142400,
            "main": {
                "temp": 30.7,
                "feels_like": 35.71,
                "temp_min": 30.7,
                "temp_max": 30.7,
                "pressure": 1017,
                "sea_level": 1017,
                "grnd_level": 1012,
                "humidity": 66,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 802,
                    "main": "Clouds",
                    "description": "雲",
                    "icon": "03d"
                }
            ],
            "clouds": {
                "all": 34
            },
            "wind": {
                "speed": 1.4,
                "deg": 244,
                "gust": 1.06
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-22 00:00:00"
        },
        {
            "dt": 1753153200,
            "main": {
                "temp": 33.03,
                "feels_like": 38.54,
                "temp_min": 33.03,
                "temp_max": 33.03,
                "pressure": 1016,
                "sea_level": 1016,
                "grnd_level": 1011,
                "humidity": 57,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 803,
                    "main": "Clouds",
                    "description": "曇りがち",
                    "icon": "04d"
                }
            ],
            "clouds": {
                "all": 52
            },
            "wind": {
                "speed": 3.54,
                "deg": 234,
                "gust": 2.07
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-22 03:00:00"
        },
        {
            "dt": 1753164000,
            "main": {
                "temp": 34.08,
                "feels_like": 40,
                "temp_min": 34.08,
                "temp_max": 34.08,
                "pressure": 1014,
                "sea_level": 1014,
                "grnd_level": 1009,
                "humidity": 54,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 802,
                    "main": "Clouds",
                    "description": "雲",
                    "icon": "03d"
                }
            ],
            "clouds": {
                "all": 36
            },
            "wind": {
                "speed": 4.42,
                "deg": 234,
                "gust": 3.14
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-22 06:00:00"
        },
        {
            "dt": 1753174800,
            "main": {
                "temp": 30.4,
                "feels_like": 34.29,
                "temp_min": 30.4,
                "temp_max": 30.4,
                "pressure": 1013,
                "sea_level": 1013,
                "grnd_level": 1009,
                "humidity": 63,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "晴天",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 6.13,
                "deg": 232,
                "gust": 6.63
            },
            "visibility": 10000,
            "pop": 0.04,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-22 09:00:00"
        },
        {
            "dt": 1753185600,
            "main": {
                "temp": 28.33,
                "feels_like": 31.62,
                "temp_min": 28.33,
                "temp_max": 28.33,
                "pressure": 1015,
                "sea_level": 1015,
                "grnd_level": 1010,
                "humidity": 72,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "晴天",
                    "icon": "01n"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 4.71,
                "deg": 237,
                "gust": 6.3
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2025-07-22 12:00:00"
        },
        {
            "dt": 1753196400,
            "main": {
                "temp": 27.82,
                "feels_like": 30.7,
                "temp_min": 27.82,
                "temp_max": 27.82,
                "pressure": 1015,
                "sea_level": 1015,
                "grnd_level": 1010,
                "humidity": 73,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 801,
                    "main": "Clouds",
                    "description": "薄い雲",
                    "icon": "02n"
                }
            ],
            "clouds": {
                "all": 20
            },
            "wind": {
                "speed": 2.97,
                "deg": 250,
                "gust": 4.42
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2025-07-22 15:00:00"
        },
        {
            "dt": 1753207200,
            "main": {
                "temp": 27.34,
                "feels_like": 29.75,
                "temp_min": 27.34,
                "temp_max": 27.34,
                "pressure": 1014,
                "sea_level": 1014,
                "grnd_level": 1009,
                "humidity": 73,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 801,
                    "main": "Clouds",
                    "description": "薄い雲",
                    "icon": "02n"
                }
            ],
            "clouds": {
                "all": 19
            },
            "wind": {
                "speed": 1.39,
                "deg": 263,
                "gust": 3.06
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2025-07-22 18:00:00"
        },
        {
            "dt": 1753218000,
            "main": {
                "temp": 27.34,
                "feels_like": 29.64,
                "temp_min": 27.34,
                "temp_max": 27.34,
                "pressure": 1014,
                "sea_level": 1014,
                "grnd_level": 1009,
                "humidity": 72,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 801,
                    "main": "Clouds",
                    "description": "薄い雲",
                    "icon": "02d"
                }
            ],
            "clouds": {
                "all": 13
            },
            "wind": {
                "speed": 0.74,
                "deg": 246,
                "gust": 1.7
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-22 21:00:00"
        },
        {
            "dt": 1753228800,
            "main": {
                "temp": 30.13,
                "feels_like": 33.08,
                "temp_min": 30.13,
                "temp_max": 30.13,
                "pressure": 1014,
                "sea_level": 1014,
                "grnd_level": 1009,
                "humidity": 60,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 801,
                    "main": "Clouds",
                    "description": "薄い雲",
                    "icon": "02d"
                }
            ],
            "clouds": {
                "all": 13
            },
            "wind": {
                "speed": 1.63,
                "deg": 251,
                "gust": 1.59
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-23 00:00:00"
        },
        {
            "dt": 1753239600,
            "main": {
                "temp": 32.81,
                "feels_like": 36.77,
                "temp_min": 32.81,
                "temp_max": 32.81,
                "pressure": 1013,
                "sea_level": 1013,
                "grnd_level": 1008,
                "humidity": 53,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 801,
                    "main": "Clouds",
                    "description": "薄い雲",
                    "icon": "02d"
                }
            ],
            "clouds": {
                "all": 19
            },
            "wind": {
                "speed": 2.39,
                "deg": 233,
                "gust": 2.31
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-23 03:00:00"
        },
        {
            "dt": 1753250400,
            "main": {
                "temp": 33.14,
                "feels_like": 37.17,
                "temp_min": 33.14,
                "temp_max": 33.14,
                "pressure": 1011,
                "sea_level": 1011,
                "grnd_level": 1006,
                "humidity": 52,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 801,
                    "main": "Clouds",
                    "description": "薄い雲",
                    "icon": "02d"
                }
            ],
            "clouds": {
                "all": 13
            },
            "wind": {
                "speed": 3.99,
                "deg": 237,
                "gust": 2.26
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-23 06:00:00"
        },
        {
            "dt": 1753261200,
            "main": {
                "temp": 29.99,
                "feels_like": 33.43,
                "temp_min": 29.99,
                "temp_max": 29.99,
                "pressure": 1011,
                "sea_level": 1011,
                "grnd_level": 1006,
                "humidity": 63,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "晴天",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 6.12,
                "deg": 237,
                "gust": 7.24
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-23 09:00:00"
        },
        {
            "dt": 1753272000,
            "main": {
                "temp": 28.1,
                "feels_like": 31.14,
                "temp_min": 28.1,
                "temp_max": 28.1,
                "pressure": 1012,
                "sea_level": 1012,
                "grnd_level": 1008,
                "humidity": 72,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "小雨",
                    "icon": "10n"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 4.23,
                "deg": 251,
                "gust": 6.2
            },
            "visibility": 10000,
            "pop": 0.2,
            "rain": {
                "3h": 0.22
            },
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2025-07-23 12:00:00"
        },
        {
            "dt": 1753282800,
            "main": {
                "temp": 27.8,
                "feels_like": 30.92,
                "temp_min": 27.8,
                "temp_max": 27.8,
                "pressure": 1012,
                "sea_level": 1012,
                "grnd_level": 1007,
                "humidity": 75,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "小雨",
                    "icon": "10n"
                }
            ],
            "clouds": {
                "all": 31
            },
            "wind": {
                "speed": 2.33,
                "deg": 261,
                "gust": 4.21
            },
            "visibility": 10000,
            "pop": 0.2,
            "rain": {
                "3h": 0.28
            },
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2025-07-23 15:00:00"
        },
        {
            "dt": 1753293600,
            "main": {
                "temp": 27.25,
                "feels_like": 30.3,
                "temp_min": 27.25,
                "temp_max": 27.25,
                "pressure": 1012,
                "sea_level": 1012,
                "grnd_level": 1007,
                "humidity": 80,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "小雨",
                    "icon": "10n"
                }
            ],
            "clouds": {
                "all": 35
            },
            "wind": {
                "speed": 0.84,
                "deg": 300,
                "gust": 2.52
            },
            "visibility": 10000,
            "pop": 0.8,
            "rain": {
                "3h": 0.85
            },
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2025-07-23 18:00:00"
        },
        {
            "dt": 1753304400,
            "main": {
                "temp": 27.27,
                "feels_like": 30.35,
                "temp_min": 27.27,
                "temp_max": 27.27,
                "pressure": 1012,
                "sea_level": 1012,
                "grnd_level": 1007,
                "humidity": 80,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 803,
                    "main": "Clouds",
                    "description": "曇りがち",
                    "icon": "04d"
                }
            ],
            "clouds": {
                "all": 53
            },
            "wind": {
                "speed": 1.99,
                "deg": 41,
                "gust": 3.11
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-23 21:00:00"
        },
        {
            "dt": 1753315200,
            "main": {
                "temp": 30.33,
                "feels_like": 34.37,
                "temp_min": 30.33,
                "temp_max": 30.33,
                "pressure": 1012,
                "sea_level": 1012,
                "grnd_level": 1007,
                "humidity": 64,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 802,
                    "main": "Clouds",
                    "description": "雲",
                    "icon": "03d"
                }
            ],
            "clouds": {
                "all": 28
            },
            "wind": {
                "speed": 1.6,
                "deg": 99,
                "gust": 1.52
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-24 00:00:00"
        },
        {
            "dt": 1753326000,
            "main": {
                "temp": 34.25,
                "feels_like": 37,
                "temp_min": 34.25,
                "temp_max": 34.25,
                "pressure": 1010,
                "sea_level": 1010,
                "grnd_level": 1006,
                "humidity": 44,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "晴天",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 1.63,
                "deg": 231,
                "gust": 1.93
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-24 03:00:00"
        },
        {
            "dt": 1753336800,
            "main": {
                "temp": 32.74,
                "feels_like": 36.05,
                "temp_min": 32.74,
                "temp_max": 32.74,
                "pressure": 1010,
                "sea_level": 1010,
                "grnd_level": 1005,
                "humidity": 51,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "晴天",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 5.58,
                "deg": 237,
                "gust": 3.48
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-24 06:00:00"
        },
        {
            "dt": 1753347600,
            "main": {
                "temp": 29.9,
                "feels_like": 34.33,
                "temp_min": 29.9,
                "temp_max": 29.9,
                "pressure": 1010,
                "sea_level": 1010,
                "grnd_level": 1005,
                "humidity": 68,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 801,
                    "main": "Clouds",
                    "description": "薄い雲",
                    "icon": "02d"
                }
            ],
            "clouds": {
                "all": 11
            },
            "wind": {
                "speed": 5.91,
                "deg": 237,
                "gust": 6.67
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-24 09:00:00"
        },
        {
            "dt": 1753358400,
            "main": {
                "temp": 28.65,
                "feels_like": 32.85,
                "temp_min": 28.65,
                "temp_max": 28.65,
                "pressure": 1011,
                "sea_level": 1011,
                "grnd_level": 1006,
                "humidity": 75,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "小雨",
                    "icon": "10n"
                }
            ],
            "clouds": {
                "all": 8
            },
            "wind": {
                "speed": 3.34,
                "deg": 253,
                "gust": 4.5
            },
            "visibility": 10000,
            "pop": 0.2,
            "rain": {
                "3h": 0.23
            },
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2025-07-24 12:00:00"
        },
        {
            "dt": 1753369200,
            "main": {
                "temp": 28.46,
                "feels_like": 32.57,
                "temp_min": 28.46,
                "temp_max": 28.46,
                "pressure": 1011,
                "sea_level": 1011,
                "grnd_level": 1006,
                "humidity": 76,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "小雨",
                    "icon": "10n"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 0.74,
                "deg": 317,
                "gust": 2.31
            },
            "visibility": 10000,
            "pop": 0.25,
            "rain": {
                "3h": 0.19
            },
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2025-07-24 15:00:00"
        },
        {
            "dt": 1753380000,
            "main": {
                "temp": 27.53,
                "feels_like": 30.83,
                "temp_min": 27.53,
                "temp_max": 27.53,
                "pressure": 1010,
                "sea_level": 1010,
                "grnd_level": 1005,
                "humidity": 79,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "晴天",
                    "icon": "01n"
                }
            ],
            "clouds": {
                "all": 0
            },
            "wind": {
                "speed": 1.79,
                "deg": 104,
                "gust": 2.4
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2025-07-24 18:00:00"
        },
        {
            "dt": 1753390800,
            "main": {
                "temp": 26.63,
                "feels_like": 26.63,
                "temp_min": 26.63,
                "temp_max": 26.63,
                "pressure": 1011,
                "sea_level": 1011,
                "grnd_level": 1006,
                "humidity": 77,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 801,
                    "main": "Clouds",
                    "description": "薄い雲",
                    "icon": "02d"
                }
            ],
            "clouds": {
                "all": 16
            },
            "wind": {
                "speed": 2.92,
                "deg": 73,
                "gust": 3.96
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-24 21:00:00"
        },
        {
            "dt": 1753401600,
            "main": {
                "temp": 29.98,
                "feels_like": 32.41,
                "temp_min": 29.98,
                "temp_max": 29.98,
                "pressure": 1011,
                "sea_level": 1011,
                "grnd_level": 1006,
                "humidity": 58,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "晴天",
                    "icon": "01d"
                }
            ],
            "clouds": {
                "all": 9
            },
            "wind": {
                "speed": 2.36,
                "deg": 79,
                "gust": 2.21
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-25 00:00:00"
        },
        {
            "dt": 1753412400,
            "main": {
                "temp": 33.88,
                "feels_like": 36.29,
                "temp_min": 33.88,
                "temp_max": 33.88,
                "pressure": 1009,
                "sea_level": 1009,
                "grnd_level": 1005,
                "humidity": 44,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 803,
                    "main": "Clouds",
                    "description": "曇りがち",
                    "icon": "04d"
                }
            ],
            "clouds": {
                "all": 72
            },
            "wind": {
                "speed": 0.63,
                "deg": 164,
                "gust": 2.4
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-25 03:00:00"
        },
        {
            "dt": 1753423200,
            "main": {
                "temp": 33.55,
                "feels_like": 37.11,
                "temp_min": 33.55,
                "temp_max": 33.55,
                "pressure": 1008,
                "sea_level": 1008,
                "grnd_level": 1003,
                "humidity": 49,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "厚い雲",
                    "icon": "04d"
                }
            ],
            "clouds": {
                "all": 86
            },
            "wind": {
                "speed": 2.68,
                "deg": 218,
                "gust": 3.31
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-25 06:00:00"
        },
        {
            "dt": 1753434000,
            "main": {
                "temp": 30.69,
                "feels_like": 34.43,
                "temp_min": 30.69,
                "temp_max": 30.69,
                "pressure": 1008,
                "sea_level": 1008,
                "grnd_level": 1003,
                "humidity": 61,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "厚い雲",
                    "icon": "04d"
                }
            ],
            "clouds": {
                "all": 100
            },
            "wind": {
                "speed": 4.53,
                "deg": 252,
                "gust": 4.09
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-25 09:00:00"
        },
        {
            "dt": 1753444800,
            "main": {
                "temp": 29.71,
                "feels_like": 33.27,
                "temp_min": 29.71,
                "temp_max": 29.71,
                "pressure": 1010,
                "sea_level": 1010,
                "grnd_level": 1005,
                "humidity": 65,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "小雨",
                    "icon": "10n"
                }
            ],
            "clouds": {
                "all": 96
            },
            "wind": {
                "speed": 2.97,
                "deg": 277,
                "gust": 3.99
            },
            "visibility": 10000,
            "pop": 0.26,
            "rain": {
                "3h": 0.1
            },
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2025-07-25 12:00:00"
        },
        {
            "dt": 1753455600,
            "main": {
                "temp": 29.08,
                "feels_like": 32.53,
                "temp_min": 29.08,
                "temp_max": 29.08,
                "pressure": 1010,
                "sea_level": 1010,
                "grnd_level": 1005,
                "humidity": 68,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "厚い雲",
                    "icon": "04n"
                }
            ],
            "clouds": {
                "all": 100
            },
            "wind": {
                "speed": 1.11,
                "deg": 16,
                "gust": 2.25
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2025-07-25 15:00:00"
        },
        {
            "dt": 1753466400,
            "main": {
                "temp": 27.66,
                "feels_like": 30.14,
                "temp_min": 27.66,
                "temp_max": 27.66,
                "pressure": 1009,
                "sea_level": 1009,
                "grnd_level": 1005,
                "humidity": 71,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "厚い雲",
                    "icon": "04n"
                }
            ],
            "clouds": {
                "all": 100
            },
            "wind": {
                "speed": 2.24,
                "deg": 82,
                "gust": 3.03
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2025-07-25 18:00:00"
        },
        {
            "dt": 1753477200,
            "main": {
                "temp": 26.88,
                "feels_like": 28.97,
                "temp_min": 26.88,
                "temp_max": 26.88,
                "pressure": 1010,
                "sea_level": 1010,
                "grnd_level": 1005,
                "humidity": 74,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "厚い雲",
                    "icon": "04d"
                }
            ],
            "clouds": {
                "all": 100
            },
            "wind": {
                "speed": 2.55,
                "deg": 66,
                "gust": 3.5
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-25 21:00:00"
        },
        {
            "dt": 1753488000,
            "main": {
                "temp": 29.89,
                "feels_like": 32.43,
                "temp_min": 29.89,
                "temp_max": 29.89,
                "pressure": 1010,
                "sea_level": 1010,
                "grnd_level": 1005,
                "humidity": 59,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "厚い雲",
                    "icon": "04d"
                }
            ],
            "clouds": {
                "all": 100
            },
            "wind": {
                "speed": 2.33,
                "deg": 77,
                "gust": 2.32
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-26 00:00:00"
        },
        {
            "dt": 1753498800,
            "main": {
                "temp": 33.9,
                "feels_like": 35.78,
                "temp_min": 33.9,
                "temp_max": 33.9,
                "pressure": 1008,
                "sea_level": 1008,
                "grnd_level": 1004,
                "humidity": 42,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "厚い雲",
                    "icon": "04d"
                }
            ],
            "clouds": {
                "all": 100
            },
            "wind": {
                "speed": 1.99,
                "deg": 216,
                "gust": 2.29
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-26 03:00:00"
        },
        {
            "dt": 1753509600,
            "main": {
                "temp": 32.97,
                "feels_like": 35.15,
                "temp_min": 32.97,
                "temp_max": 32.97,
                "pressure": 1007,
                "sea_level": 1007,
                "grnd_level": 1002,
                "humidity": 46,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 803,
                    "main": "Clouds",
                    "description": "曇りがち",
                    "icon": "04d"
                }
            ],
            "clouds": {
                "all": 79
            },
            "wind": {
                "speed": 6.36,
                "deg": 239,
                "gust": 4.15
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-26 06:00:00"
        },
        {
            "dt": 1753520400,
            "main": {
                "temp": 29.82,
                "feels_like": 33.5,
                "temp_min": 29.82,
                "temp_max": 29.82,
                "pressure": 1008,
                "sea_level": 1008,
                "grnd_level": 1003,
                "humidity": 65,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 802,
                    "main": "Clouds",
                    "description": "雲",
                    "icon": "03d"
                }
            ],
            "clouds": {
                "all": 37
            },
            "wind": {
                "speed": 5.98,
                "deg": 235,
                "gust": 6.53
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2025-07-26 09:00:00"
        },
        {
            "dt": 1753531200,
            "main": {
                "temp": 28.46,
                "feels_like": 31.74,
                "temp_min": 28.46,
                "temp_max": 28.46,
                "pressure": 1010,
                "sea_level": 1010,
                "grnd_level": 1005,
                "humidity": 71,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 801,
                    "main": "Clouds",
                    "description": "薄い雲",
                    "icon": "02n"
                }
            ],
            "clouds": {
                "all": 19
            },
            "wind": {
                "speed": 4.06,
                "deg": 245,
                "gust": 5.1
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2025-07-26 12:00:00"
        }
    ],
    "city": {
        "id": 1853909,
        "name": "大阪市",
        "coord": {
            "lat": 34.6937,
            "lon": 135.5022
        },
        "country": "JP",
        "population": 2592413,
        "timezone": 32400,
        "sunrise": 1753041581,
        "sunset": 1753092522
    }
}
```



