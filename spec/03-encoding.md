# Encoding

## Files

All JUDSYS-1 files are JSON encoded with UTF-8.

To avoid canonicalization problems, all signed messages are encoded in base64.

Example:

```js
{"b": 1, "a":2}
// becomes
{
    "what": "JUDSYS-1 base64" // This is to aid humans debugging, not for machines to use 
    "raw": "eyJiIjogMSwgImEiOjJ9Cg=="
}
```

### File extensions

All JUDSYS-1 extensions begin with `.j1` (dot, jay, one). 

For JUDSYS-1 files, all apps MUST use only the file extensions show below:

| Extension | Usage |
|-----------|-------|
| `.j1c` | Certificates (no private keys) |
| `.j1a` | Attribute certificates |
| `.j1k` | Certificates with the private keys |
| `.j1s` | Detached digital signature |
| `.j1e` | Encrypted file |
| `.j1r` | Revocation information |

## Strings

All apps MUST have proper Unicode support and fonts to display any characters that may be necessary for the country of intended use. This is, an app for France MUST have fonts with accented characters, but MAY NOT have any CJK nor Cyrillic support. An app for Russia MUST have Cyrillic and Latin support, but MAY NOT have CJK or Mongolian support.

It is RECOMMENDED to store string in NFC (Normal Form Composition).

It is RECOMMENDED that all apps support as much Unicode characters and scripts as possible. It is also RECOMMENDED that all apps include the necessary fonts.

Emoji usage is discouraged.

## Dates

All dates MUST be encoded as strings according to the [RFC 3339].

If the time is not available, it MUST be assumed to be midnight.

Times MUST NOT include fractions of a second.

## Country codes

All countries or similar MUST be represented by the upper case two letter codes defined on ISO 3166-1. If a country or similar does not have such code, it MUST be full English name with spaces and proper capitalization. Ex: `Principality of Sealand` not `principality of sealand` nor `PrincipalityOf_Sealand`.

International organizations MUST use their upper case English acronym if it has more than two letters. Ex: `ICAO` and `ICJ`. Otherwise the full English name with spaces and capitalization MUST be used. Ex: `League of Nations`.

Special cases are:

  1. `UN` for the *United Nations* (already on the ISO 3166-1).
  1. `EU` for the *European Union* (already on the ISO 3166-1).
  1. `INT` for international things such as passports, names and date of birth.
  1. `MERCOSU` for the *Southern Common Market*, *Mercosur* in Spanish and *Mercosul* in Portuguese.
  1. `UNASU` for the *Union of South American Nations*, *UNSAUR* in Spanish and *UNASUL* in Portuguese.
  1. `NAFTA` for the *North American Free Trade Agreement*.

All apps MUST NOT use fake international organizations, even if they were mentioned in presidential debates :)

## Certificate chains

All JUDSYS-1 files MUST include all the necessary certificates, attribute certificates and revocation files for verifying the file in question.

An exception is made to the root CAs which MUST NOT be included in any JUDSYS-1 file, as they MUST be a part of the apps themselves, preferably in the app's source code.
