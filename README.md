# JUDSYS-1

*Current Status*: Just began.

JUDSYS-1 (**J**SON **U**nified **D**igital **S**ignature S**y**stem **S**tandard) is a standard meant to replace CMS/CAdES, XML-DSIG/XAdES, PAdES (PDF) and other digital signature systems.

This is mainly intended for Brazil, but it should be able to work for other countries with minimal or no changes.

Main points:

  * Full Unicode support for strings with an ASCII fallback. Examples:
    ```
    {"name": "República Federativa do Brasil 🇧🇷", "name_ascii: "Republica Federativa do Brasil"}
    {"name": "中华人民共和国 🇨🇳", "name_ascii: "Zhong1hua2 Ren2min2 Gong4he2guo2"}
    ```
  * Full certification chain is always included (except for the root CAs).
  * Rules for dealing with illiterate people (no reading, computer illiterate or functionaly illiterate).
  * Simple and consistent JSON syntax with base64 to avoid canonicalization problems.
  * Minimal number of allowed algorithms in order to make implementations and interoperability easier.
  * Single document for all the rules. (timestamps, CA rules, hardware interaction, user interaction and naming conventions)
  * Single web API for timestamping. (just change the base URL)
  * Single web API for getting the public key for encrypting messages. (unified base URL)
  * Spearate key pairs for identifing the person and for signing documents.
  * Ease for users: Minimal options and variations to make digital signatures easy (or at least easier) to use.
    * Standard naming conventions.
    * Detached only signatures: this is for interoperability and to avoid unnecessary backups. (it also reduces the memory needed to parse the files)
    * Only two signature types: regular and timestamped.
    * Main document ids already in the certificate: CPF (Brazil SSN equivalent), RG/RNE (state issued ID).
    * Standard file extensions: `.y1c` for certificates, `.y1k` for private keys, `.y1s` for file signatures, `.y1e` for encrypted files, `.y1r` for revocation information, `.y1a` for attribute certificates.

Open questions:

  * Should quantum resistent algorithms be used?
  * Should `.par2` be automatically generated?
  * Should the expression "digital signature" or "cryptographic signature" be used?
  * Which government ids be included on the certificate instead of on a revocation certificate? CPF and RG/RNE only? What about: NIT (empoyee identification number), Título de Eleitor (voter's card), CNH (driver's license)?
  * Should a picture of the user be included in the certificate?
  * How to deal with social names and nicknames?
  * Should people's personal certificates be separated from those used in their jobs?
    * Example: should a judge have a single certificate and an attribute certificate or should they have two separate certificates? 
    * The first one is cheaper, as people won't have to pay for two separate certificates, but the second one is easier to implement.
  * Who can issue attribute certificates?
    * I think that allowing anyone to issue them can makes things easier, as it can easily work as "procuração" (a document syaing that someone else is allowed to do certain specified things in your name).

Algortithm candidates:

  * Hashing: [SHA3-512](https://en.wikipedia.org/wiki/SHA-3)
  * Encryptions and signing: [RSA](https://en.wikipedia.org/wiki/RSA_(cryptosystem)) with a minimum of 4096 bits (better safe than sorry :)
  * Key derivation from passwords: [Argon2id](https://en.wikipedia.org/wiki/Argon2)
