# JSON Schemas

## Certificate File (.j1c)

```js
{
  "$id": "https://judsys.github.io/schema/j1c.json",
  "title": "JUDSYS-1 .j1c file",
  "type": "object",
  "required": ["what", "certificates"],
  "additionalProperties": true,
  "properties": {
    "what": {
      "const": "JUDSYS-1 Certificate File (.j1c)"
    },
    "certificates": {
      "type": "array",
      "items": {
        "$ref": "https://judsys.github.io/schema/signed-object.json"
      }
    }
  }
}
```

## Private Keys File (.j1k)

```js
{
  "$id": "https://judsys.github.io/schema/j1c.json",
  "title": "JUDSYS-1 .j1c file",
  "type": "object",
  "required": ["what", "certificates"],
  "additionalProperties": false,
  "properties": {
    "what": {
      "const": "JUDSYS-1 Private Keys File (.j1k)"
    },
    "certificates": {
      "type": "array",
      "items": {
        "$ref": "https://judsys.github.io/schema/signed-object.json"
      }
    },
    "private-keys": {
      "description": "An encrypted message containing an array of private keys for the first certificate present on the certificates array.",
      "$ref": "https://judsys.github.io/schema/encrypted-object.json"
    }
  }
}
```

## Proof of Attribute File (.j1a)

## Detached Digital Signature File (.j1s)

## Encrypted File (.j1e)

## Revocation Information File (.j1r)

## Hash (optionally salted)

```js
{
  "$id": "https://judsys.github.io/schema/hash.json",
  "title": "JUDSYS-1 salted hash",
  "type": "object",
  "required": ["algorithm", "value"],
  "additionalProperties": true,
  "properties": {
    "algorithm": {
      "enum": ["SHA-3-512"],
      "description": "The hashing algorithm"
    },
    "value": {
      "type": "string",
      "description": "The hash of the salted password, hex encoded"
    },
    "salt": {
      "type": "string",
      "description": "The password salt, hex encoded"
    }
  }
}
```

## AES-256-CBC

Advanced Encryption Standard with 256 bit keys in CBC (Cipher Block Chaining) mode.

```js
{
  "$id": "https://judsys.github.io/schema/aes-256-cbc.json",
  "title": "JUDSYS-1 Algorithm Identifier for AES-256-CBC",
  "type": "object",
  "required": ["name", "IV"],
  "additionalProperties": false,
  "properties": {
    "name": {
      "const": "AES-256-CBC"
    },
    "IV": {
      "type": "string",
      "description": "A base64 encoding of the initialization vector"
    }
  }
}
```

## Argon2

## ECDSA

## Encrypted Object

```js
{
  "$id": "https://judsys.github.io/schema/encrypted-object.json",
  "title": "JUDSYS-1 Signed Object",
  "type": "object",
  "required": ["what", "raw", "alg", "key_src"],
  "additionalProperties": false,
  "properties": {
    "what": {
      "const": "JUDSYS-1 Encrypted Object"
    },
    "raw": {
      "type": "string",
      "description": "A base64 encoding of the encrypted JSON object."
    },
    "algorithm": {
      "description": "The encryption algorithm.",
      "oneOf": [
        { "$ref": "https://judsys.github.io/schema/aes-256-cbc.json" }
      ]
    },
    "key_src": {
      "enum": ["password", "key-file"]
    },
    "key_id": {
      "type": "string",
      "description": "The ID of the public key"
    },
    "key_password": {
      "type": "object",
      "properties": {
        "derivation": {
          "description": "The key derivation algorithm.",
          "oneOf": [
            { "$ref": "https://judsys.github.io/schema/argon2id.json" }
          ]
        },
        "hash": {
          "$ref": "https://judsys.github.io/schema/hash.json"
        }
      }
    }
  }
}
```

## Signed Object

```js
{
  "$id": "https://judsys.github.io/schema/signed-object.json",
  "title": "JUDSYS-1 Signed Object",
  "type": "object",
  "required": ["what", "raw", "sig"],
  "additionalProperties": true,
  "properties": {
    "what": {
      "const": "JUDSYS-1 Signed Object"
    },
    "raw": {
      "type": "string",
      "description": "A base64 encoding of the JSON object."
    },
    "sig": {
      "type": "string",
      "description": "A base64 encoding of the signature."
    }
  }
}
```

## Key

```js
{
  "$id": "https://judsys.github.io/schema/key.json",
  "title": "JUDSYS-1 key",
  "type": "object",
  "required": ["algorithm", "kind", "id", "usage"],
  "additionalProperties": true,
  "properties": {
    "algorithm": {
      "type": "string"
    },
    "kind": {
      "enum": ["public", "private"]  
    },
    "id": {
      "type": "string",
      "description": "A value that uniquely identifies that key (algorithm dependent)"  
    },
    "usage": {
      "enum": ["identification", "signing", "encryption", "issue-certs", "revoke-certs"]
    }
  }
}
```

### RSA

All RSA private keys MUST have exactly two primes.

The key ID MUST be `"RSA/" + sha-3-512(N + "|" + E)` (all values are strings and all numbers are in base 10). 

#### RSA Public

```js
{
  "$id": "https://judsys.github.io/schema/key-rsa-public.json",
  "title": "JUDSYS-1 key",
  "type": "object",
  "required": ["algorithm", "kind", "id", "N", "E"],
  "additionalProperties": false,
  "properties": {
    "algorithm": {
      "const": "RSA"
    },
    "kind": {
      "const": "public"
    },
    "id": {
      "type": "string",
      "pattern": "^RSA:[0-9a-fA-F]{128}$"
    },
    "N": {
      "type": "string",
      "description": "RSA public modulus N, in base 10"
    },
    "E": {
      "type": "string",
      "description": "RSA public exponent E, in base 10"
    }
  }
}
```

#### RSA Private

```js
{
  "$id": "https://judsys.github.io/schema/key-rsa-public.json",
  "title": "JUDSYS-1 key",
  "type": "object",
  "required": ["algorithm", "kind", "id", "N", "E", "D", "P", "Q", "DQ", "DP", "QINV"],
  "additionalProperties": false,
  "properties": {
    "algorithm": {
      "const": "RSA"
    },
    "kind": {
      "const": "private"
    },
    "id": {
      "type": "string",
      "pattern": "^RSA:[0-9a-fA-F]{128}$"
    },
    "N": {
      "type": "string",
      "description": "RSA public modulus N, in base 10"
    },
    "E": {
      "type": "string",
      "description": "RSA public exponent E, in base 10"
    },
    "D": {
      "type": "string",
      "description": "RSA private exponent D, in base 10"
    },
    "P": {
      "type": "string",
      "description": "RSA secret prime P, in base 10"
    },
    "Q": {
      "type": "string",
      "description": "RSA secret prime Q, in base 10"
    },
    "DP": {
      "type": "string",
      "description": "D mod (P-1), in base 10"
    },
    "DQ": {
      "type": "string",
      "description": "D mod (Q-1), in base 10"
    },
    "QINV": {
      "type": "string",
      "description": "Q^-1 mod P, in base 10"
    }
  }
}
```

### ECDSA Public Key

## Entity (subject of issuer)

```js
{
  "$id": "https://judsys.github.io/schema/entity.json",
  "title": "JUDSYS-1 Entity",
  "type": "object",
  "required": ["id", "INT/names"],
  "additionalProperties": true,
  "properties": {
    "id": {
      "type": "string"
    },
    "INT/names": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "minItems": 1,
      "uniqueItems": true
    },
    "INT/emails": {
      "type": "array",
      "items": {
        "type": "string",
        "format": "idn-email"
      },
      "minItems": 1,
      "uniqueItems": true
    },
    "INT/phones": {
      "type": "array",
      "items": {
        "type": "string",
        "pattern": "^\+[0-9]{1,} .*$"
      },
      "minItems": 1,
      "uniqueItems": true
    },
    "INT/addresses": {
      "type": "array",
      "items": {
        "$ref": "https://judsys.github.io/schema/address.json"
      },
      "minItems": 1,
      "uniqueItems": true
    },
    "INT/picture": {
      "type": "string",
      "contentEncoding": "base64",
      "contentMediaType": "image"
    },
    "INT/passport": {
      "type": "array",
      "items": {
        "$ref": "https://judsys.github.io/schema/passport.json"
      },
      "minItems": 1,
      "uniqueItems": true
    }
  }
}
```

## Certificate

```js
{
  "$id": "https://judsys.github.io/schema/certificate.json",
  "title": "JUDSYS-1 Certificate",
  "type": "object",
  "required": ["subject", "notBefore", "notAfter", "serial", "keys"],
  "properties": {
    "serial": { "type": "string" },
    "subject": {
      "$ref": "https://judsys.github.io/schema/entity.json"
    },
    "issuer": {
      "$ref": "https://judsys.github.io/schema/entity.json"
    },
    "notBefore": {
      "type": "string",
      "format": "date-time"
    },
    "notAfter": {
      "type": "string",
      "format": "date-time"
    },
    "keys": {
      "type": "array",
      "items": {
        "$ref": "https://judsys.github.io/schema/key.json"
      }
    }
  }
}
```

## Address

```js
{
  "$id": "https://judsys.github.io/schema/address.json",
  "title": "JUDSYS-1 Address",
  "type": "object",
  "required": ["country", "state", "city"],
  "additionalProperties": false,
  "properties": {
    "country": {
      "type": "string"
    },
    "zip": {
      "type": "string"
    },
    "comment": {
      "type": "string",
      "description": "Text describing addresses that do not fit into the structured model AND/OR additional comments about how to get to the place AND/OR access codes"
    },
    "recipient": {
      "type": "string"
    },
    "complement": {
      "type": "string"
    },
    "numberOrBuildingName": {
      "type": "string"
    },
    "street": {
      "type": "string"
    },
    "neighbourhood": {
      "type": "string"
    },
    "city": {
      "type": "string"
    },
    "state": {
      "type": "string",
      "description": "If the country does not have states or provinces, this value MUST be a single hyphen '-'"
    },
    "lat": {
      "type": "number",
      "minimum": -90,
      "maximum": 90,
      "description": "The latitude of the address, preferably of the building entrance"
    },
    "lon": {
      "type": "number",
      "minimum": -180,
      "maximum": 180,
      "description": "The longitude of the address, preferably of the building entrance"
    }
  }
}
```

## Passport

```js
{
  "$id": "https://judsys.github.io/schema/entity.json",
  "title": "JUDSYS-1 Entity",
  "type": "object",
  "required": ["country", "number"],
  "additionalProperties": true,
  "properties": {
    "type": {
      "type": "string",
      "description": "Type of travel document, usually a 'P' indicating passport."
    },
    "country": {
      "type": "string",
      "description": "The country that ISSUED the passport."
    },
    "number": {
      "type": "string"
    },
    "surname": {
      "type": "string",
      "description": "The surname as it appears on the VIZ (Visual Inspection Zone)"
    },
    "givenName": {
      "type": "string",
      "description": "The given name as it appears on the VIZ (Visual Inspection Zone)"
    },
    "nationality": {
      "type": "string"
    },
    "date_of_birth": {
      "type": "string",
      "format": "date"
    },
    "place_of_birth": {
      "type": "string"
    },
    "personal_number": {
      "type": "string"
    },
    "sex": {
      "type": "string",
      "description": "The sex of the passport holder. It may be 'X'."
    },
    "date_of_issue": {
      "type": "string",
      "format": "date"
    },
    "date_of_expiry": {
      "type": "string",
      "format": "date"
    },
    "MRZ": {
      "type": "string"
    }
  }
}
```