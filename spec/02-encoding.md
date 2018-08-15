# Encoding

All JUDSYS-1 files are JSON encoded with UTF-8 in NFD (Normal Form Decomposition) or NFKD (Normal Form Compatibility Decomposition). The choice between either depends on the language of the text. When in doubt, use NFD.

To avoid canonicalization problems, all signed messages are encoded in base64.

Examples:

✏️

All countries or similar MUST be represented by the upper case two letter codes defined on ISO 3166-1. If a country or similar does not have such code, it MUST be full English name with spaces and proper capitalization. Ex: `Principality of Sealand` not `principality of sealand` nor `PrincipalityOf_Sealand`.

International organizations MUST use their upper case English acronym if it has more than two letters. Ex: `ICAO` and `ICJ`. Otherwise the full English name with spaces and capitalization MUST be used. Ex: `African Union`.

Special cases are:

  1. `UN` for the *United Nations* (already on the ISO 3166-1).
  1. `EU` for the *European Union* (already on the ISO 3166-1).
  1. `INT` for international things such as passports.
  1. `MERCOSU` for the *Southern Common Market*, *Mercosur* in Spanish and *Mercosul* in Portuguese.
  1. `UNASU` for the *Union of South American Nations*, *UNSAUR* in Spanish and *UNASUL* in Portuguese.
  1. `NAFTA` for the *North American Free Trade Agreement*.

All apps MUST NOT use fake international organizations, even if they were mentioned in presidential debates :)

## File extensions

All JUDSYS-1 extensions begin with `.j1` (dot, jay, one). 

All apps MUST use only the file extensions show below:

| Extension | Usage |
|-----------|-------|
| `.j1c` | Certificates (no private keys) |
| `.j1a` | Attribute certificates |
| `.j1k` | Certificates with the private keys |
| `.j1s` | Detached digital signature |
| `.j1e` | Encrypted file |
| `.j1r` | Revocation information |

