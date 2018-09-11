# JSON Schemas

## Certificate File (.j1c)
<{{schemas/j1c.json}}

## Private Keys File (.j1k)
<{{schemas/j1k.json}}

## Proof of Attribute File (.j1a)

## Detached Digital Signature File (.j1s)
<{{schemas/j1s.json}}

## Document Signature
### Unsigned Document Signature
<{{schemas/unsigned-document-signature.json}}
### Signed Document Signature
<{{schemas/signed-document-signature.json}}

## Encrypted File (.j1e)

## Revocation Information File (.j1r)

## Hash (optionally salted)
<{{schemas/hash.json}}
## AES-256-CBC
Advanced Encryption Standard with 256 bit keys in CBC (Cipher Block Chaining) mode.

<{{schemas/aes-256-cbc.json}}
## Argon2
## ECDSA
## Encrypted Object
<{{schemas/encrypted-object.json}}
## Signed Object
<{{schemas/signed-object.json}}
## Key
<{{schemas/key.json}}
### RSA

All RSA private keys MUST have exactly two primes.

The key ID MUST be `"RSA/" + sha-3-512(N + "|" + E)` (all values are strings and all numbers are in base 10). 

#### RSA Public
<{{schemas/key-rsa-public.json}}
#### RSA Private
<{{schemas/key-rsa-private.json}}
### ECDSA Public Key
## Entity (subject)
<{{schemas/entity.json}}
<{{schemas/signed-certificate.json}}
## Address
<{{schemas/int-address.json}}
## Passport
<{{schemas/int-passport.json}}

## Certificates
### Unsigned Certificate
<{{schemas/unsigned-certificate.json}}
### Signed Certificate
<{{schemas/signed-certificate.json}}

