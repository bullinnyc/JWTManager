# JWTManager

Get payload data from token.

## Usage

```swift
let decodeJWT = JWTManager.decodeJWT(accessToken)
let example = decodeJWT["example"] as? String
```
